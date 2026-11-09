-- Allow editing trip details after recruitment has closed without changing
-- membership or pending invitations. The row lock serializes edits with
-- membership close/reopen operations.
create or replace function public.save_trip(
  p_trip_id bigint DEFAULT NULL::bigint,
  p_name text DEFAULT NULL::text,
  p_location text DEFAULT NULL::text,
  p_description text DEFAULT NULL::text,
  p_meeting_point text DEFAULT NULL::text,
  p_departure_at timestamp with time zone DEFAULT NULL::timestamp with time zone,
  p_return_at timestamp with time zone DEFAULT NULL::timestamp with time zone,
  p_budget bigint DEFAULT 0,
  p_schedule_type text DEFAULT 'fixed'::text,
  p_cost_items text[] DEFAULT '{}'::text[],
  p_rules text[] DEFAULT '{}'::text[],
  p_invited_user_ids uuid[] DEFAULT '{}'::uuid[]
)
returns bigint
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_user_id uuid := (select auth.uid());
  v_trip_id bigint;
  v_membership_closed boolean := false;
begin
  if v_user_id is null then raise exception 'not_authenticated'; end if;

  if p_trip_id is not null then
    select t.membership_closed into v_membership_closed
    from public.trips t
    where t.id = p_trip_id and t.created_by = v_user_id
    for update;
    if not found then raise exception 'trip_not_found_or_forbidden'; end if;
  end if;

  if nullif(trim(coalesce(p_name, '')), '') is null then
    raise exception 'trip_name_required';
  end if;
  if nullif(trim(coalesce(p_location, '')), '') is null then
    raise exception 'trip_location_required';
  end if;
  if p_departure_at is null or p_return_at is null
     or p_return_at <= p_departure_at then
    raise exception 'invalid_trip_dates';
  end if;
  if coalesce(p_budget, -1) < 0 then raise exception 'invalid_trip_budget'; end if;
  if coalesce(p_schedule_type, '') not in ('fixed', 'voting') then
    raise exception 'invalid_schedule_type';
  end if;

  if not v_membership_closed and exists (
    select 1
    from unnest(coalesce(p_invited_user_ids, '{}'::uuid[])) invited(user_id)
    where invited.user_id <> v_user_id
      and not exists (
        select 1 from public.friendships f
        where (f.user_id = v_user_id and f.friend_id = invited.user_id)
           or (f.friend_id = v_user_id and f.user_id = invited.user_id)
      )
  ) then raise exception 'invalid_invitees'; end if;

  if p_trip_id is null then
    if exists (
      select 1 from public.trip_members tm
      where tm.user_id = v_user_id and tm.member_status = 'accepted'
    ) then raise exception 'already_in_another_trip'; end if;

    insert into public.trips (
      name, location, departure_at, return_at, status, budget,
      created_by, description, meeting_point, schedule_type, cost_items
    )
    values (
      trim(p_name), trim(p_location), p_departure_at, p_return_at,
      'preparing', p_budget, v_user_id,
      nullif(trim(coalesce(p_description, '')), ''),
      nullif(trim(coalesce(p_meeting_point, '')), ''),
      p_schedule_type, coalesce(p_cost_items, '{}'::text[])
    )
    returning trips.id into v_trip_id;
  else
    update public.trips
    set
      name = trim(p_name),
      location = trim(p_location),
      departure_at = p_departure_at,
      return_at = p_return_at,
      budget = p_budget,
      description = nullif(trim(coalesce(p_description, '')), ''),
      meeting_point = nullif(trim(coalesce(p_meeting_point, '')), ''),
      schedule_type = p_schedule_type,
      cost_items = coalesce(p_cost_items, '{}'::text[]),
      updated_at = now()
    where trips.id = p_trip_id and trips.created_by = v_user_id
    returning trips.id into v_trip_id;
    if v_trip_id is null then raise exception 'trip_not_found_or_forbidden'; end if;
  end if;

  delete from public.trip_rules where trip_id = v_trip_id;

  insert into public.trip_rules (trip_id, rule)
  select v_trip_id, trim(rule_values.rule_text)
  from unnest(coalesce(p_rules, '{}'::text[])) as rule_values(rule_text)
  where nullif(trim(rule_values.rule_text), '') is not null;

  if not v_membership_closed then
    delete from public.trip_members
    where trip_id = v_trip_id
      and user_id <> v_user_id
      and member_status = 'pending'
      and not (user_id = any(coalesce(p_invited_user_ids, '{}'::uuid[])));

    insert into public.trip_members as existing_members (
      trip_id, user_id, member_type, member_status
    )
    select v_trip_id, invited.user_id, 'member', 'pending'
    from (
      select distinct invited_ids.user_id
      from unnest(coalesce(p_invited_user_ids, '{}'::uuid[])) as invited_ids(user_id)
      where invited_ids.user_id <> v_user_id
    ) invited
    on conflict (trip_id, user_id) do update
      set member_type = 'member', member_status = 'pending'
      where existing_members.member_status in ('rejected', 'left', 'removed');
  end if;

  return v_trip_id;
end;
$$;

revoke all on function public.save_trip(bigint, text, text, text, text, timestamp with time zone, timestamp with time zone, bigint, text, text[], text[], uuid[]) from public, anon;
grant execute on function public.save_trip(bigint, text, text, text, text, timestamp with time zone, timestamp with time zone, bigint, text, text[], text[], uuid[]) to authenticated;
