-- Trip CRUD, invitations and discoverable trip search.
-- Existing trips / trip_members / trip_rules tables are reused.

alter table public.trips
  add column if not exists description text,
  add column if not exists meeting_point text,
  add column if not exists schedule_type text not null default 'fixed',
  add column if not exists cost_items text[] not null default '{}'::text[];

do $$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'valid_trip_schedule_type'
      and conrelid = 'public.trips'::regclass
  ) then
    alter table public.trips
      add constraint valid_trip_schedule_type
      check (schedule_type in ('fixed', 'voting'));
  end if;
end;
$$;

create index if not exists trips_status_departure_idx
  on public.trips (status, departure_at);

create index if not exists trips_created_by_idx
  on public.trips (created_by);

create index if not exists trip_members_user_status_trip_idx
  on public.trip_members (user_id, member_status, trip_id);

create index if not exists trip_rules_trip_id_idx
  on public.trip_rules (trip_id);

create index if not exists trip_activities_trip_id_idx
  on public.trip_activities (trip_id);

-- A single authenticated RPC provides:
--   p_mode = 'mine'    -> trips created by or accepted by the current user
--   p_mode = 'search'  -> preparing/active trips discoverable in search
--   p_mode = 'details' -> one trip visible to its creator or a member
-- Only summary/member data appropriate to each mode is returned.
create or replace function public.get_trips(
  p_mode text,
  p_query text default null,
  p_trip_id bigint default null
)
returns table (
  id bigint,
  name text,
  location text,
  departure_at timestamptz,
  return_at timestamptz,
  status text,
  budget bigint,
  created_by uuid,
  description text,
  meeting_point text,
  schedule_type text,
  cost_items text[],
  rules text[],
  member_count bigint,
  leader_name text,
  is_creator boolean,
  is_member boolean,
  members jsonb
)
language sql
stable
security definer
set search_path = public
as $$
  select
    t.id,
    t.name,
    t.location,
    t.departure_at,
    t.return_at,
    t.status,
    t.budget,
    t.created_by,
    t.description,
    t.meeting_point,
    t.schedule_type,
    coalesce(t.cost_items, '{}'::text[]),
    coalesce(rule_data.rules, '{}'::text[]),
    coalesce(member_data.member_count, 0),
    coalesce(
      nullif(trim(concat_ws(' ', owner_profile.first_name, owner_profile.last_name)), ''),
      'کاربر هم‌سفر'
    ),
    t.created_by = (select auth.uid()),
    exists (
      select 1
      from public.trip_members current_membership
      where current_membership.trip_id = t.id
        and current_membership.user_id = (select auth.uid())
        and current_membership.member_status in ('pending', 'accepted')
    ),
    case
      when t.created_by = (select auth.uid())
        or exists (
          select 1
          from public.trip_members visible_membership
          where visible_membership.trip_id = t.id
            and visible_membership.user_id = (select auth.uid())
            and visible_membership.member_status in ('pending', 'accepted')
        )
      then coalesce(member_data.members, '[]'::jsonb)
      else '[]'::jsonb
    end
  from public.trips t
  left join public.profiles owner_profile on owner_profile.id = t.created_by
  left join lateral (
    select array_agg(tr.rule order by tr.id) as rules
    from public.trip_rules tr
    where tr.trip_id = t.id
  ) rule_data on true
  left join lateral (
    select
      count(*) filter (where tm.member_status = 'accepted') as member_count,
      jsonb_agg(
        jsonb_build_object(
          'id', member_profile.id,
          'first_name', member_profile.first_name,
          'last_name', member_profile.last_name,
          'username', member_profile.username,
          'avatar_icon', member_profile.avatar_icon,
          'member_type', tm.member_type,
          'member_status', tm.member_status
        )
        order by tm.member_type desc, tm.joined_at
      ) filter (
        where tm.member_status = 'accepted'
           or t.created_by = (select auth.uid())
      ) as members
    from public.trip_members tm
    join public.profiles member_profile on member_profile.id = tm.user_id
    where tm.trip_id = t.id
      and (
        tm.member_status = 'accepted'
        or t.created_by = (select auth.uid())
      )
  ) member_data on true
  where (select auth.uid()) is not null
    and case p_mode
      when 'mine' then
        (
          t.created_by = (select auth.uid())
          or exists (
            select 1
            from public.trip_members my_membership
            where my_membership.trip_id = t.id
              and my_membership.user_id = (select auth.uid())
              and my_membership.member_status = 'accepted'
          )
        )
      when 'search' then
        t.status in ('preparing', 'active')
        and (
          nullif(trim(coalesce(p_query, '')), '') is null
          or t.name ilike '%' || trim(p_query) || '%'
          or coalesce(t.location, '') ilike '%' || trim(p_query) || '%'
        )
      when 'details' then
        t.id = p_trip_id
        and (
          t.status in ('preparing', 'active')
          or t.created_by = (select auth.uid())
          or exists (
            select 1
            from public.trip_members detail_membership
            where detail_membership.trip_id = t.id
              and detail_membership.user_id = (select auth.uid())
              and detail_membership.member_status in ('pending', 'accepted')
          )
        )
      else false
    end
  order by
    case when p_mode = 'mine' then t.updated_at end desc nulls last,
    case when p_mode = 'search' then t.departure_at end asc nulls last,
    t.created_at desc
  limit case when p_mode = 'details' then 1 else 100 end;
$$;

revoke all on function public.get_trips(text, text, bigint) from public, anon;
grant execute on function public.get_trips(text, text, bigint) to authenticated;

-- Atomic create/update of the trip, rules, leader membership and friend invitations.
-- Editing is restricted to the trip creator. Invitees must be existing friends.
create or replace function public.save_trip(
  p_trip_id bigint default null,
  p_name text default null,
  p_location text default null,
  p_description text default null,
  p_meeting_point text default null,
  p_departure_at timestamptz default null,
  p_return_at timestamptz default null,
  p_budget bigint default 0,
  p_schedule_type text default 'fixed',
  p_cost_items text[] default '{}'::text[],
  p_rules text[] default '{}'::text[],
  p_invited_user_ids uuid[] default '{}'::uuid[]
)
returns bigint
language plpgsql
security definer
set search_path = public
as $$
declare
  v_user_id uuid := (select auth.uid());
  v_trip_id bigint;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
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

  if coalesce(p_budget, -1) < 0 then
    raise exception 'invalid_trip_budget';
  end if;

  if coalesce(p_schedule_type, '') not in ('fixed', 'voting') then
    raise exception 'invalid_schedule_type';
  end if;

  if exists (
    select 1
    from unnest(coalesce(p_invited_user_ids, '{}'::uuid[])) invited(user_id)
    where invited.user_id <> v_user_id
      and not exists (
        select 1
        from public.friendships f
        where (f.user_id = v_user_id and f.friend_id = invited.user_id)
           or (f.friend_id = v_user_id and f.user_id = invited.user_id)
      )
  ) then
    raise exception 'invalid_invitees';
  end if;

  if p_trip_id is null then
    insert into public.trips (
      name, location, departure_at, return_at, status, budget,
      created_by, description, meeting_point, schedule_type, cost_items
    )
    values (
      trim(p_name), trim(p_location), p_departure_at, p_return_at,
      'preparing', p_budget, v_user_id,
      nullif(trim(coalesce(p_description, '')), ''),
      nullif(trim(coalesce(p_meeting_point, '')), ''),
      p_schedule_type,
      coalesce(p_cost_items, '{}'::text[])
    )
    returning trips.id into v_trip_id;

    insert into public.trip_members (
      trip_id, user_id, member_type, member_status
    )
    values (v_trip_id, v_user_id, 'leader', 'accepted')
    on conflict (trip_id, user_id) do nothing;
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
    where trips.id = p_trip_id
      and trips.created_by = v_user_id
    returning trips.id into v_trip_id;

    if v_trip_id is null then
      raise exception 'trip_not_found_or_forbidden';
    end if;
  end if;

  delete from public.trip_rules where trip_id = v_trip_id;

  -- Keep pending invitations in sync when the creator edits the trip.
  -- Accepted members are never removed by editing the invitation list.
  delete from public.trip_members
  where trip_id = v_trip_id
    and user_id <> v_user_id
    and member_status = 'pending'
    and not (
      user_id = any(coalesce(p_invited_user_ids, '{}'::uuid[]))
    );

  insert into public.trip_rules (trip_id, rule)
  select v_trip_id, trim(rule_text)
  from unnest(coalesce(p_rules, '{}'::text[])) rule_text
  where nullif(trim(rule_text), '') is not null;

  insert into public.trip_members (
    trip_id, user_id, member_type, member_status
  )
  select v_trip_id, invited.user_id, 'member', 'pending'
  from (
    select distinct invited_ids.user_id
    from unnest(coalesce(p_invited_user_ids, '{}'::uuid[])) as invited_ids(user_id)
    where invited_ids.user_id <> v_user_id
  ) invited
  on conflict (trip_id, user_id) do nothing;

  return v_trip_id;
end;
$$;

revoke all on function public.save_trip(
  bigint, text, text, text, text, timestamptz, timestamptz,
  bigint, text, text[], text[], uuid[]
) from public, anon;
grant execute on function public.save_trip(
  bigint, text, text, text, text, timestamptz, timestamptz,
  bigint, text, text[], text[], uuid[]
) to authenticated;

