-- Trip membership lifecycle: join, invitation response, leave, invite and remove.
-- Reuses public.trip_members; no duplicate membership table is introduced.

create or replace function public.join_trip(p_trip_id bigint)
returns void language plpgsql security definer set search_path = ''
as $$
declare
  v_user_id uuid := (select auth.uid());
  v_trip_status text;
  v_existing_status text;
begin
  if v_user_id is null then raise exception 'not_authenticated'; end if;
  select t.status into v_trip_status from public.trips t where t.id = p_trip_id for update;
  if not found then raise exception 'trip_not_found'; end if;
  if v_trip_status not in ('preparing', 'active') then raise exception 'trip_not_joinable'; end if;

  select tm.member_status into v_existing_status
  from public.trip_members tm
  where tm.trip_id = p_trip_id and tm.user_id = v_user_id for update;

  if v_existing_status = 'accepted' then raise exception 'already_joined'; end if;
  if v_existing_status = 'pending' then
    update public.trip_members set member_status = 'accepted', joined_at = now()
    where trip_id = p_trip_id and user_id = v_user_id;
  elsif v_existing_status = 'removed' then
    raise exception 'membership_removed';
  elsif v_existing_status is null then
    insert into public.trip_members (trip_id, user_id, member_type, member_status)
    values (p_trip_id, v_user_id, 'member', 'accepted');
  else
    update public.trip_members set member_status = 'accepted', joined_at = now()
    where trip_id = p_trip_id and user_id = v_user_id;
  end if;
end;
$$;

create or replace function public.respond_to_trip_invitation(p_trip_id bigint, p_accept boolean)
returns void language plpgsql security definer set search_path = ''
as $$
declare
  v_user_id uuid := (select auth.uid());
  v_status text;
  v_trip_status text;
begin
  if v_user_id is null then raise exception 'not_authenticated'; end if;
  select t.status into v_trip_status from public.trips t where t.id = p_trip_id;
  if not found then raise exception 'trip_not_found'; end if;
  if v_trip_status not in ('preparing', 'active') then raise exception 'trip_not_joinable'; end if;

  select tm.member_status into v_status from public.trip_members tm
  where tm.trip_id = p_trip_id and tm.user_id = v_user_id for update;
  if v_status is distinct from 'pending' then raise exception 'invitation_not_pending'; end if;

  update public.trip_members
  set member_status = case when p_accept then 'accepted' else 'rejected' end,
      joined_at = case when p_accept then now() else joined_at end
  where trip_id = p_trip_id and user_id = v_user_id;
end;
$$;

create or replace function public.leave_trip(p_trip_id bigint)
returns void language plpgsql security definer set search_path = ''
as $$
declare v_user_id uuid := (select auth.uid());
begin
  if v_user_id is null then raise exception 'not_authenticated'; end if;
  if exists (select 1 from public.trips t where t.id = p_trip_id and t.created_by = v_user_id)
  then raise exception 'leader_cannot_leave'; end if;

  update public.trip_members set member_status = 'left'
  where trip_id = p_trip_id and user_id = v_user_id and member_status = 'accepted';
  if not found then raise exception 'not_active_trip_member'; end if;
end;
$$;

create or replace function public.invite_to_trip(p_trip_id bigint, p_user_ids uuid[])
returns integer language plpgsql security definer set search_path = ''
as $$
declare
  v_user_id uuid := (select auth.uid());
  v_count integer := 0;
begin
  if v_user_id is null then raise exception 'not_authenticated'; end if;
  if not exists (
    select 1 from public.trips t where t.id = p_trip_id
      and t.created_by = v_user_id and t.status in ('preparing', 'active')
  ) then raise exception 'trip_not_found_or_forbidden'; end if;

  if exists (
    select 1 from unnest(coalesce(p_user_ids, '{}'::uuid[])) u(id)
    where u.id = v_user_id or not exists (
      select 1 from public.friendships f
      where (f.user_id = v_user_id and f.friend_id = u.id)
         or (f.friend_id = v_user_id and f.user_id = u.id)
    )
  ) then raise exception 'invalid_invitees'; end if;

  insert into public.trip_members as existing (trip_id, user_id, member_type, member_status)
  select p_trip_id, ids.id, 'member', 'pending'
  from (select distinct unnest(coalesce(p_user_ids, '{}'::uuid[])) as id) ids
  on conflict (trip_id, user_id) do update
    set member_type = 'member', member_status = 'pending'
    where existing.member_status in ('rejected', 'left');
  get diagnostics v_count = row_count;
  return v_count;
end;
$$;

create or replace function public.remove_trip_member(p_trip_id bigint, p_user_id uuid)
returns void language plpgsql security definer set search_path = ''
as $$
declare v_actor uuid := (select auth.uid());
begin
  if v_actor is null then raise exception 'not_authenticated'; end if;
  if p_user_id = v_actor then raise exception 'cannot_remove_self'; end if;
  if not exists (select 1 from public.trips t where t.id = p_trip_id and t.created_by = v_actor)
  then raise exception 'trip_not_found_or_forbidden'; end if;

  update public.trip_members set member_status = 'removed'
  where trip_id = p_trip_id and user_id = p_user_id
    and member_type <> 'leader' and member_status in ('pending', 'accepted');
  if not found then raise exception 'member_not_removable'; end if;
end;
$$;

create or replace function public.get_trip_membership_status(p_trip_id bigint)
returns text language sql stable security definer set search_path = ''
as $$
  select tm.member_status from public.trip_members tm
  where tm.trip_id = p_trip_id and tm.user_id = (select auth.uid()) limit 1;
$$;

revoke all on function public.join_trip(bigint) from public, anon;
revoke all on function public.respond_to_trip_invitation(bigint, boolean) from public, anon;
revoke all on function public.leave_trip(bigint) from public, anon;
revoke all on function public.invite_to_trip(bigint, uuid[]) from public, anon;
revoke all on function public.remove_trip_member(bigint, uuid) from public, anon;
revoke all on function public.get_trip_membership_status(bigint) from public, anon;
grant execute on function public.join_trip(bigint) to authenticated;
grant execute on function public.respond_to_trip_invitation(bigint, boolean) to authenticated;
grant execute on function public.leave_trip(bigint) to authenticated;
grant execute on function public.invite_to_trip(bigint, uuid[]) to authenticated;
grant execute on function public.remove_trip_member(bigint, uuid) to authenticated;
grant execute on function public.get_trip_membership_status(bigint) to authenticated;
