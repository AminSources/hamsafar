-- A trip can accept members only while it is preparing.
-- Starting the trip permanently closes membership at the database level.

create or replace function private.enforce_trip_start_closes_membership()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if old.status <> 'preparing' and new.status = 'preparing' then
    raise exception 'trip_already_started';
  end if;

  if new.status <> 'preparing' then
    new.membership_closed := true;
  end if;

  return new;
end;
$$;

drop trigger if exists enforce_trip_start_closes_membership on public.trips;
create trigger enforce_trip_start_closes_membership
before update of status, membership_closed on public.trips
for each row execute function private.enforce_trip_start_closes_membership();

create or replace function private.enforce_trip_membership_lock()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_membership_closed boolean;
  v_trip_status text;
begin
  if tg_op = 'INSERT' then
    select t.membership_closed, t.status
    into v_membership_closed, v_trip_status
    from public.trips t
    where t.id = new.trip_id
    for update;

    if not found then
      return new;
    end if;

    if coalesce(v_membership_closed, false) or v_trip_status <> 'preparing' then
      raise exception 'membership_closed';
    end if;

    return new;
  elsif tg_op = 'DELETE' then
    select t.membership_closed, t.status
    into v_membership_closed, v_trip_status
    from public.trips t
    where t.id = old.trip_id
    for update;

    -- Allow trip deletion cascades after the parent row has disappeared.
    if not found then
      return old;
    end if;

    if coalesce(v_membership_closed, false) or v_trip_status <> 'preparing' then
      raise exception 'membership_closed';
    end if;

    return old;
  else
    if new.trip_id is distinct from old.trip_id
       or new.user_id is distinct from old.user_id
       or new.member_type is distinct from old.member_type
       or new.member_status is distinct from old.member_status then
      select t.membership_closed, t.status
      into v_membership_closed, v_trip_status
      from public.trips t
      where t.id = old.trip_id
      for update;

      if found and (coalesce(v_membership_closed, false) or v_trip_status <> 'preparing') then
        -- Declining a pending invitation is still allowed after membership closes.
        if not (
          old.member_status = 'pending'
          and new.member_status = 'rejected'
          and new.trip_id is not distinct from old.trip_id
          and new.user_id is not distinct from old.user_id
          and new.member_type is not distinct from old.member_type
        ) then
          raise exception 'membership_closed';
        end if;
      end if;

      if new.trip_id is distinct from old.trip_id then
        select t.membership_closed, t.status
        into v_membership_closed, v_trip_status
        from public.trips t
        where t.id = new.trip_id
        for update;

        if found and (coalesce(v_membership_closed, false) or v_trip_status <> 'preparing') then
          raise exception 'membership_closed';
        end if;
      end if;
    end if;

    return new;
  end if;
end;
$$;

create or replace function public.get_trip_membership_closed(p_trip_id bigint)
returns boolean
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  v_closed boolean;
begin
  if (select auth.uid()) is null then
    raise exception 'not_authenticated';
  end if;

  select coalesce(t.membership_closed, false) or t.status <> 'preparing'
  into v_closed
  from public.trips t
  where t.id = p_trip_id;

  if not found then
    raise exception 'trip_not_found';
  end if;

  return v_closed;
end;
$$;

create or replace function public.set_trip_membership_closed(
  p_trip_id bigint,
  p_closed boolean
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_user_id uuid := (select auth.uid());
  v_trip_status text;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select t.status
  into v_trip_status
  from public.trips t
  where t.id = p_trip_id
    and t.created_by = v_user_id
  for update;

  if not found then
    raise exception 'trip_not_found_or_forbidden';
  end if;

  if v_trip_status <> 'preparing' then
    raise exception 'trip_not_preparing';
  end if;

  update public.trips
  set membership_closed = p_closed,
      updated_at = now()
  where id = p_trip_id;
end;
$$;

create or replace function public.join_trip(p_trip_id bigint)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_user_id uuid := (select auth.uid());
  v_trip_status text;
  v_membership_closed boolean;
  v_existing_status text;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select t.status, t.membership_closed
  into v_trip_status, v_membership_closed
  from public.trips t
  where t.id = p_trip_id
  for update;

  if not found then
    raise exception 'trip_not_found';
  end if;

  if v_membership_closed or v_trip_status <> 'preparing' then
    raise exception 'membership_closed';
  end if;

  if exists (
    select 1 from public.trip_members tm
    where tm.user_id = v_user_id
      and tm.member_status = 'accepted'
      and tm.trip_id <> p_trip_id
  ) then
    raise exception 'already_in_another_trip';
  end if;

  select tm.member_status
  into v_existing_status
  from public.trip_members tm
  where tm.trip_id = p_trip_id
    and tm.user_id = v_user_id
  for update;

  if v_existing_status = 'accepted' then
    raise exception 'already_joined';
  elsif v_existing_status = 'pending' then
    update public.trip_members
    set member_status = 'accepted', joined_at = now()
    where trip_id = p_trip_id and user_id = v_user_id;
  elsif v_existing_status = 'removed' then
    raise exception 'membership_removed';
  elsif v_existing_status is null then
    insert into public.trip_members (
      trip_id, user_id, member_type, member_status
    ) values (p_trip_id, v_user_id, 'member', 'accepted');
  else
    update public.trip_members
    set member_status = 'accepted', joined_at = now()
    where trip_id = p_trip_id and user_id = v_user_id;
  end if;

exception
  when unique_violation then
    raise exception 'already_in_another_trip';
end;
$$;

create or replace function public.invite_to_trip(p_trip_id bigint, p_user_ids uuid[])
returns integer
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_user_id uuid := (select auth.uid());
  v_trip_status text;
  v_membership_closed boolean;
  v_count integer := 0;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select t.status, t.membership_closed
  into v_trip_status, v_membership_closed
  from public.trips t
  where t.id = p_trip_id
    and t.created_by = v_user_id
  for update;

  if not found then
    raise exception 'trip_not_found_or_forbidden';
  end if;

  if v_membership_closed or v_trip_status <> 'preparing' then
    raise exception 'membership_closed';
  end if;

  if exists (
    select 1
    from unnest(coalesce(p_user_ids, '{}'::uuid[])) u(id)
    where u.id = v_user_id
      or not exists (
        select 1 from public.friendships f
        where (f.user_id = v_user_id and f.friend_id = u.id)
           or (f.friend_id = v_user_id and f.user_id = u.id)
      )
  ) then
    raise exception 'invalid_invitees';
  end if;

  insert into public.trip_members as existing (
    trip_id, user_id, member_type, member_status
  )
  select p_trip_id, ids.id, 'member', 'pending'
  from (
    select distinct unnest(coalesce(p_user_ids, '{}'::uuid[])) as id
  ) ids
  on conflict (trip_id, user_id) do update
    set member_type = 'member', member_status = 'pending'
    where existing.member_status in ('rejected', 'left');

  get diagnostics v_count = row_count;
  return v_count;
end;
$$;

create or replace function public.respond_to_trip_invitation(
  p_trip_id bigint,
  p_accept boolean
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_user_id uuid := (select auth.uid());
  v_status text;
  v_trip_status text;
  v_membership_closed boolean;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  select t.status, t.membership_closed
  into v_trip_status, v_membership_closed
  from public.trips t
  where t.id = p_trip_id
  for update;

  if not found then
    raise exception 'trip_not_found';
  end if;

  if p_accept and (v_membership_closed or v_trip_status <> 'preparing') then
    raise exception 'membership_closed';
  end if;

  select tm.member_status
  into v_status
  from public.trip_members tm
  where tm.trip_id = p_trip_id and tm.user_id = v_user_id
  for update;

  if v_status is distinct from 'pending' then
    raise exception 'invitation_not_pending';
  end if;

  if p_accept and exists (
    select 1 from public.trip_members tm
    where tm.user_id = v_user_id
      and tm.member_status = 'accepted'
      and tm.trip_id <> p_trip_id
  ) then
    raise exception 'already_in_another_trip';
  end if;

  update public.trip_members
  set member_status = case when p_accept then 'accepted' else 'rejected' end,
      joined_at = case when p_accept then now() else joined_at end
  where trip_id = p_trip_id and user_id = v_user_id;

exception
  when unique_violation then
    raise exception 'already_in_another_trip';
end;
$$;

create or replace function public.start_trip(p_trip_id bigint)
returns void
language plpgsql
security invoker
set search_path = ''
as $$
begin
  if (select auth.uid()) is null then
    raise exception 'not_authenticated';
  end if;

  update public.trips
  set status = 'active',
      membership_closed = true,
      updated_at = now()
  where id = p_trip_id
    and created_by = (select auth.uid())
    and status = 'preparing';

  if not found then
    raise exception 'trip_not_found_or_not_preparing';
  end if;
end;
$$;

create or replace function public.activate_departed_trips()
returns integer
language plpgsql
security invoker
set search_path = ''
as $$
declare
  v_updated_count integer;
begin
  update public.trips
  set status = 'active',
      membership_closed = true,
      updated_at = now()
  where status = 'preparing'
    and departure_at <= now();

  get diagnostics v_updated_count = row_count;
  return v_updated_count;
end;
$$;

-- Repair trips that had already started before this invariant was introduced.
update public.trips
set membership_closed = true,
    updated_at = now()
where status <> 'preparing'
  and membership_closed is distinct from true;

revoke all on function private.enforce_trip_start_closes_membership() from public, anon, authenticated;
revoke all on function private.enforce_trip_membership_lock() from public, anon, authenticated;
revoke all on function public.get_trip_membership_closed(bigint) from public, anon;
revoke all on function public.set_trip_membership_closed(bigint, boolean) from public, anon;
revoke all on function public.join_trip(bigint) from public, anon;
revoke all on function public.invite_to_trip(bigint, uuid[]) from public, anon;
revoke all on function public.respond_to_trip_invitation(bigint, boolean) from public, anon;
revoke all on function public.start_trip(bigint) from public, anon;
revoke all on function public.activate_departed_trips() from public, anon, authenticated;

grant execute on function public.get_trip_membership_closed(bigint) to authenticated;
grant execute on function public.set_trip_membership_closed(bigint, boolean) to authenticated;
grant execute on function public.join_trip(bigint) to authenticated;
grant execute on function public.invite_to_trip(bigint, uuid[]) to authenticated;
grant execute on function public.respond_to_trip_invitation(bigint, boolean) to authenticated;
grant execute on function public.start_trip(bigint) to authenticated;

notify pgrst, 'reload schema';
