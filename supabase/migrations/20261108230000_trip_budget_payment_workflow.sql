-- Trip budget and payment confirmation workflow.
alter table public.trips
  add column if not exists bank_card_number text,
  add column if not exists bank_account_name text;

alter table public.trip_members
  add column if not exists payment_method text,
  add column if not exists payment_reference text,
  add column if not exists payment_submitted_at timestamptz,
  add column if not exists payment_confirmed_at timestamptz;

alter table public.trip_members drop constraint if exists trip_members_pay_status_check;
alter table public.trip_members add constraint trip_members_pay_status_check
  check (pay_status in ('pending', 'under_review', 'paid'));

alter table public.trip_members drop constraint if exists trip_members_payment_method_check;
alter table public.trip_members add constraint trip_members_payment_method_check
  check (payment_method is null or payment_method in ('bank_transfer', 'cash'));

update public.trip_members set pay_status='pending' where pay_status='unpaid';
update public.trip_members set pay_status='pending' where pay_status='partial';

create index if not exists trip_members_payment_review_idx
  on public.trip_members (trip_id, pay_status) where member_status='accepted';

create or replace function private.recalculate_trip_member_shares(p_trip_id bigint)
returns void language plpgsql security definer set search_path=''
as $$
declare v_budget bigint; v_count bigint; v_share bigint;
begin
  select t.budget into v_budget from public.trips t where t.id=p_trip_id;
  if not found then return; end if;
  select count(*) into v_count from public.trip_members tm
    where tm.trip_id=p_trip_id and tm.member_status='accepted';
  if v_count=0 then return; end if;
  v_share := floor(v_budget::numeric / v_count)::bigint;
  update public.trip_members set share=v_share
    where trip_id=p_trip_id and member_status='accepted';
end;
$$;
revoke all on function private.recalculate_trip_member_shares(bigint) from public, anon, authenticated;

create or replace function private.sync_trip_member_shares()
returns trigger language plpgsql security definer set search_path=''
as $$
begin
  if tg_table_name='trips' then
    perform private.recalculate_trip_member_shares(new.id);
    return new;
  end if;
  if tg_op='DELETE' then
    perform private.recalculate_trip_member_shares(old.trip_id);
    return old;
  end if;
  perform private.recalculate_trip_member_shares(new.trip_id);
  if tg_op='UPDATE' and old.trip_id is distinct from new.trip_id then
    perform private.recalculate_trip_member_shares(old.trip_id);
  end if;
  return new;
end;
$$;
revoke all on function private.sync_trip_member_shares() from public, anon, authenticated;

drop trigger if exists sync_trip_member_shares_on_membership on public.trip_members;
create trigger sync_trip_member_shares_on_membership
after insert or update of member_status, trip_id or delete on public.trip_members
for each row execute function private.sync_trip_member_shares();

drop trigger if exists sync_trip_member_shares_on_budget on public.trips;
create trigger sync_trip_member_shares_on_budget
after update of budget on public.trips
for each row execute function private.sync_trip_member_shares();

-- Backfill equal shares for existing accepted memberships.
do $$
declare r record;
begin
  for r in select id from public.trips loop
    perform private.recalculate_trip_member_shares(r.id);
  end loop;
end;
$$;

create or replace function public.save_trip_with_payment_details(
  p_trip_id bigint,p_name text,p_location text,p_description text,p_meeting_point text,
  p_departure_at timestamptz,p_return_at timestamptz,p_budget bigint,p_schedule_type text,
  p_cost_items text[],p_rules text[],p_invited_user_ids uuid[],p_departure_options jsonb,
  p_bank_card_number text,p_bank_account_name text
) returns bigint language plpgsql security invoker set search_path=''
as $$
declare v_trip_id bigint;
begin
  v_trip_id := public.save_trip_with_departure_options(
    p_trip_id,p_name,p_location,p_description,p_meeting_point,p_departure_at,p_return_at,
    p_budget,p_schedule_type,p_cost_items,p_rules,p_invited_user_ids,p_departure_options
  );
  update public.trips set
    bank_card_number=nullif(regexp_replace(coalesce(p_bank_card_number,''),'\\s','','g'),''),
    bank_account_name=nullif(trim(coalesce(p_bank_account_name,'')),'')
  where id=v_trip_id and created_by=(select auth.uid());
  if not found then raise exception 'trip_not_found_or_forbidden'; end if;
  perform private.recalculate_trip_member_shares(v_trip_id);
  return v_trip_id;
end;
$$;
revoke all on function public.save_trip_with_payment_details(bigint,text,text,text,text,timestamptz,timestamptz,bigint,text,text[],text[],uuid[],jsonb,text,text) from public, anon;
grant execute on function public.save_trip_with_payment_details(bigint,text,text,text,text,timestamptz,timestamptz,bigint,text,text[],text[],uuid[],jsonb,text,text) to authenticated;

create or replace function public.get_my_trip_budget()
returns table(
  trip_id bigint, trip_name text, total_budget bigint, bank_card_number text,
  bank_account_name text, is_leader boolean, my_share bigint, my_pay_status text,
  members jsonb
) language sql stable security definer set search_path=''
as $$
  select t.id,t.name,t.budget,t.bank_card_number,t.bank_account_name,
    (t.created_by=(select auth.uid())),
    coalesce((select tm.share from public.trip_members tm
      where tm.trip_id=t.id and tm.user_id=(select auth.uid()) and tm.member_status='accepted'),0),
    (select tm.pay_status from public.trip_members tm
      where tm.trip_id=t.id and tm.user_id=(select auth.uid()) and tm.member_status='accepted'),
    coalesce((select jsonb_agg(jsonb_build_object(
      'user_id',tm.user_id,'first_name',p.first_name,'last_name',p.last_name,
      'member_type',tm.member_type,'share',tm.share,'pay_status',tm.pay_status,
      'payment_method',tm.payment_method,'payment_reference',tm.payment_reference,
      'payment_submitted_at',tm.payment_submitted_at
    ) order by tm.member_type desc,tm.joined_at)
      from public.trip_members tm join public.profiles p on p.id=tm.user_id
      where tm.trip_id=t.id and tm.member_status='accepted'),'[]'::jsonb)
  from public.trips t
  where t.status in ('preparing','active')
    and exists(select 1 from public.trip_members me where me.trip_id=t.id
      and me.user_id=(select auth.uid()) and me.member_status='accepted')
  order by t.updated_at desc limit 1;
$$;
revoke all on function public.get_my_trip_budget() from public, anon;
grant execute on function public.get_my_trip_budget() to authenticated;

create or replace function public.submit_trip_payment(p_trip_id bigint,p_method text,p_reference text default null)
returns void language plpgsql security definer set search_path=''
as $$
declare v_user_id uuid := (select auth.uid());
begin
  if v_user_id is null then raise exception 'not_authenticated'; end if;
  if p_method not in ('bank_transfer','cash') then raise exception 'invalid_payment_method'; end if;
  if p_method='bank_transfer' and nullif(trim(coalesce(p_reference,'')),'') is null
    then raise exception 'payment_reference_required'; end if;
  update public.trip_members tm set
    pay_status='under_review',payment_method=p_method,
    payment_reference=case when p_method='bank_transfer' then trim(p_reference) else null end,
    payment_submitted_at=now(),payment_confirmed_at=null
  where tm.trip_id=p_trip_id and tm.user_id=v_user_id and tm.member_status='accepted'
    and tm.member_type<>'leader' and tm.pay_status<>'paid'
    and exists(select 1 from public.trips t where t.id=tm.trip_id and t.status in ('preparing','active'));
  if not found then raise exception 'payment_not_allowed'; end if;
end;
$$;
revoke all on function public.submit_trip_payment(bigint,text,text) from public, anon;
grant execute on function public.submit_trip_payment(bigint,text,text) to authenticated;

create or replace function public.confirm_trip_payment(p_trip_id bigint,p_user_id uuid)
returns void language plpgsql security definer set search_path=''
as $$
begin
  if not exists(select 1 from public.trips t where t.id=p_trip_id and t.created_by=(select auth.uid())) then
    raise exception 'leader_only';
  end if;
  update public.trip_members set pay_status='paid',payment_confirmed_at=now()
  where trip_id=p_trip_id and user_id=p_user_id and member_status='accepted' and pay_status='under_review';
  if not found then raise exception 'payment_not_under_review'; end if;
end;
$$;
revoke all on function public.confirm_trip_payment(bigint,uuid) from public, anon;
grant execute on function public.confirm_trip_payment(bigint,uuid) to authenticated;

notify pgrst, 'reload schema';
