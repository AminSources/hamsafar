-- Structured, allow-listed trip activity events for the Home page.
alter table public.trip_activities
  add column if not exists subject_user_id uuid references public.profiles(id) on delete set null,
  add column if not exists metadata jsonb not null default '{}'::jsonb;

create index if not exists trip_activities_recent_allowed_idx
  on public.trip_activities (trip_id, created_at desc, id desc)
  where activity in ('member_joined', 'member_left', 'member_removed', 'payment_confirmed',
    'task_completed', 'trip_status_changed', 'membership_closed', 'membership_opened');

create or replace function private.log_trip_membership_activity()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare v_actor_id uuid := (select auth.uid());
begin
  if tg_op = 'INSERT' then
    if new.member_status = 'accepted' and new.member_type <> 'leader' then
      insert into public.trip_activities (trip_id, user_id, activity, subject_user_id, metadata)
      values (new.trip_id, coalesce(v_actor_id, new.user_id), 'member_joined', new.user_id, '{}'::jsonb);
    end if;
    return new;
  end if;
  if old.member_status is distinct from new.member_status then
    if new.member_status = 'accepted' and old.member_status is distinct from 'accepted'
       and new.member_type <> 'leader' then
      insert into public.trip_activities (trip_id, user_id, activity, subject_user_id, metadata)
      values (new.trip_id, coalesce(v_actor_id, new.user_id), 'member_joined', new.user_id, '{}'::jsonb);
    elsif old.member_status = 'accepted' and new.member_status = 'left' then
      insert into public.trip_activities (trip_id, user_id, activity, subject_user_id, metadata)
      values (new.trip_id, coalesce(v_actor_id, new.user_id), 'member_left', new.user_id, '{}'::jsonb);
    elsif old.member_status = 'accepted' and new.member_status = 'removed' then
      insert into public.trip_activities (trip_id, user_id, activity, subject_user_id, metadata)
      values (new.trip_id, v_actor_id, 'member_removed', new.user_id, '{}'::jsonb);
    end if;
  end if;
  return new;
end;
$$;

create or replace function private.log_trip_payment_activity()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare v_actor_id uuid := (select auth.uid());
begin
  if old.pay_status is distinct from 'paid' and new.pay_status = 'paid'
     and new.member_type <> 'leader'
     and old.member_status = 'accepted' and new.member_status = 'accepted' then
    insert into public.trip_activities (trip_id, user_id, activity, subject_user_id, metadata)
    values (new.trip_id, v_actor_id, 'payment_confirmed', new.user_id, '{}'::jsonb);
  end if;
  return new;
end;
$$;

create or replace function private.log_trip_task_activity()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare
  v_trip_id bigint;
  v_assignee_id uuid;
  v_actor_id uuid := (select auth.uid());
begin
  if old.is_done = false and new.is_done = true then
    select tm.trip_id, tm.user_id into v_trip_id, v_assignee_id
    from public.trip_members tm where tm.id = new.trip_member_id;
    if v_trip_id is not null then
      insert into public.trip_activities (trip_id, user_id, activity, subject_user_id, metadata)
      values (v_trip_id, coalesce(v_actor_id, v_assignee_id), 'task_completed',
        v_assignee_id, jsonb_build_object('task_name', new.task));
    end if;
  end if;
  return new;
end;
$$;

create or replace function private.log_trip_state_activity()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare v_actor_id uuid := (select auth.uid());
begin
  if old.status is distinct from new.status then
    insert into public.trip_activities (trip_id, user_id, activity, metadata)
    values (new.id, v_actor_id, 'trip_status_changed',
      jsonb_build_object('old_status', old.status, 'new_status', new.status));
  end if;
  if old.membership_closed is distinct from new.membership_closed then
    insert into public.trip_activities (trip_id, user_id, activity, metadata)
    values (new.id, v_actor_id,
      case when new.membership_closed then 'membership_closed' else 'membership_opened' end,
      jsonb_build_object('old_status', old.membership_closed, 'new_status', new.membership_closed));
  end if;
  return new;
end;
$$;

drop trigger if exists log_trip_membership_activity on public.trip_members;
create trigger log_trip_membership_activity after insert or update of member_status
on public.trip_members for each row execute function private.log_trip_membership_activity();

drop trigger if exists log_trip_payment_activity on public.trip_members;
create trigger log_trip_payment_activity after update of pay_status
on public.trip_members for each row execute function private.log_trip_payment_activity();

drop trigger if exists log_trip_task_activity on public.trip_member_tasks;
create trigger log_trip_task_activity after update of is_done
on public.trip_member_tasks for each row execute function private.log_trip_task_activity();

drop trigger if exists log_trip_state_activity on public.trips;
create trigger log_trip_state_activity after update of status, membership_closed
on public.trips for each row execute function private.log_trip_state_activity();

revoke all on function private.log_trip_membership_activity() from public, anon, authenticated;
revoke all on function private.log_trip_payment_activity() from public, anon, authenticated;
revoke all on function private.log_trip_task_activity() from public, anon, authenticated;
revoke all on function private.log_trip_state_activity() from public, anon, authenticated;

create or replace function public.get_recent_trip_activities(p_trip_id bigint)
returns table (id bigint, activity text, actor_name text, subject_name text,
  task_name text, old_status text, new_status text, created_at timestamptz)
language plpgsql stable security definer set search_path = ''
as $$
declare v_user_id uuid := (select auth.uid());
begin
  if v_user_id is null then raise exception 'not_authenticated'; end if;
  if not exists (
    select 1 from public.trips t where t.id = p_trip_id
      and (t.created_by = v_user_id or exists (
        select 1 from public.trip_members tm
        where tm.trip_id = t.id and tm.user_id = v_user_id and tm.member_status = 'accepted'
      ))
  ) then raise exception 'trip_not_found_or_forbidden'; end if;

  return query
  select a.id, a.activity,
    coalesce(nullif(trim(concat_ws(' ', actor.first_name, actor.last_name)), ''),
      nullif(actor.username, ''),
      case when a.user_id is null then 'سامانه همسفر' else 'عضو سفر' end),
    coalesce(nullif(trim(concat_ws(' ', subject.first_name, subject.last_name)), ''),
      nullif(subject.username, '')),
    a.metadata ->> 'task_name', a.metadata ->> 'old_status',
    a.metadata ->> 'new_status', a.created_at
  from public.trip_activities a
  left join public.profiles actor on actor.id = a.user_id
  left join public.profiles subject on subject.id = a.subject_user_id
  where a.trip_id = p_trip_id
    and a.activity = any (array['member_joined', 'member_left', 'member_removed',
      'payment_confirmed', 'task_completed', 'trip_status_changed',
      'membership_closed', 'membership_opened']::text[])
  order by a.created_at desc, a.id desc
  limit 4;
end;
$$;

revoke all on function public.get_recent_trip_activities(bigint) from public, anon;
grant execute on function public.get_recent_trip_activities(bigint) to authenticated;
notify pgrst, 'reload schema';
