-- Trip membership closure and task ownership/authorization.
alter table public.trips
  add column if not exists membership_closed boolean not null default false;

create index if not exists trip_member_tasks_trip_member_id_idx
  on public.trip_member_tasks (trip_member_id);

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
begin
  if v_user_id is null then raise exception 'not_authenticated'; end if;

  perform 1
  from public.trips t
  where t.id = p_trip_id and t.created_by = v_user_id
  for update;

  if not found then raise exception 'trip_not_found_or_forbidden'; end if;

  update public.trips
  set membership_closed = p_closed, updated_at = now()
  where id = p_trip_id;
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
  v_user_id uuid := (select auth.uid());
begin
  if v_user_id is null then raise exception 'not_authenticated'; end if;

  select t.membership_closed into v_closed
  from public.trips t
  where t.id = p_trip_id
    and (
      t.created_by = v_user_id
      or exists (
        select 1 from public.trip_members tm
        where tm.trip_id = t.id
          and tm.user_id = v_user_id
          and tm.member_status in ('pending', 'accepted')
      )
    );

  if not found then raise exception 'trip_not_found_or_forbidden'; end if;
  return v_closed;
end;
$$;

create or replace function public.enforce_trip_membership_lock()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_closed boolean;
begin
  if tg_op = 'INSERT' then
    select t.membership_closed into v_closed
    from public.trips t where t.id = new.trip_id
    for update;
    if not found then return new; end if;
    if v_closed then raise exception 'membership_closed'; end if;
    return new;
  elsif tg_op = 'DELETE' then
    select t.membership_closed into v_closed
    from public.trips t where t.id = old.trip_id
    for update;
    if not found then return old; end if;
    if v_closed then raise exception 'membership_closed'; end if;
    return old;
  else
    if new.trip_id is distinct from old.trip_id
       or new.user_id is distinct from old.user_id
       or new.member_type is distinct from old.member_type
       or new.member_status is distinct from old.member_status then
      select t.membership_closed into v_closed
      from public.trips t where t.id = old.trip_id
      for update;

      if found and v_closed then
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
        select t.membership_closed into v_closed
        from public.trips t where t.id = new.trip_id
        for update;
        if found and v_closed then raise exception 'membership_closed'; end if;
      end if;
    end if;
    return new;
  end if;
end;
$$;

drop trigger if exists enforce_trip_membership_lock on public.trip_members;
create trigger enforce_trip_membership_lock
before insert or update or delete on public.trip_members
for each row execute function public.enforce_trip_membership_lock();

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
  if v_user_id is null then raise exception 'not_authenticated'; end if;

  select t.status, t.membership_closed
  into v_trip_status, v_membership_closed
  from public.trips t where t.id = p_trip_id for update;

  if not found then raise exception 'trip_not_found'; end if;
  if v_membership_closed then raise exception 'membership_closed'; end if;
  if v_trip_status not in ('preparing', 'active') then
    raise exception 'trip_not_joinable';
  end if;

  if exists (
    select 1 from public.trip_members tm
    where tm.user_id = v_user_id
      and tm.member_status = 'accepted'
      and tm.trip_id <> p_trip_id
  ) then raise exception 'already_in_another_trip'; end if;

  select tm.member_status into v_existing_status
  from public.trip_members tm
  where tm.trip_id = p_trip_id and tm.user_id = v_user_id
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
    insert into public.trip_members (trip_id, user_id, member_type, member_status)
    values (p_trip_id, v_user_id, 'member', 'accepted');
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

create or replace function public.leave_trip(p_trip_id bigint)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_user_id uuid := (select auth.uid());
  v_membership_closed boolean;
begin
  if v_user_id is null then raise exception 'not_authenticated'; end if;

  select t.membership_closed into v_membership_closed
  from public.trips t where t.id = p_trip_id for update;

  if not found then raise exception 'trip_not_found'; end if;
  if v_membership_closed then raise exception 'membership_closed'; end if;

  if exists (
    select 1 from public.trips t
    where t.id = p_trip_id and t.created_by = v_user_id
  ) then raise exception 'leader_cannot_leave'; end if;

  update public.trip_members
  set member_status = 'left'
  where trip_id = p_trip_id
    and user_id = v_user_id
    and member_status = 'accepted';

  if not found then raise exception 'not_active_trip_member'; end if;
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
  if v_user_id is null then raise exception 'not_authenticated'; end if;

  select t.status, t.membership_closed
  into v_trip_status, v_membership_closed
  from public.trips t
  where t.id = p_trip_id and t.created_by = v_user_id
  for update;

  if not found then raise exception 'trip_not_found_or_forbidden'; end if;
  if v_membership_closed then raise exception 'membership_closed'; end if;
  if v_trip_status not in ('preparing', 'active') then
    raise exception 'trip_not_joinable';
  end if;

  if exists (
    select 1 from unnest(coalesce(p_user_ids, '{}'::uuid[])) u(id)
    where u.id = v_user_id or not exists (
      select 1 from public.friendships f
      where (f.user_id = v_user_id and f.friend_id = u.id)
         or (f.friend_id = v_user_id and f.user_id = u.id)
    )
  ) then raise exception 'invalid_invitees'; end if;

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
  if v_user_id is null then raise exception 'not_authenticated'; end if;

  select t.status, t.membership_closed
  into v_trip_status, v_membership_closed
  from public.trips t where t.id = p_trip_id for update;

  if not found then raise exception 'trip_not_found'; end if;
  if v_trip_status not in ('preparing', 'active') then
    raise exception 'trip_not_joinable';
  end if;
  if p_accept and v_membership_closed then
    raise exception 'membership_closed';
  end if;

  select tm.member_status into v_status
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
  ) then raise exception 'already_in_another_trip'; end if;

  update public.trip_members
  set member_status = case when p_accept then 'accepted' else 'rejected' end,
      joined_at = case when p_accept then now() else joined_at end
  where trip_id = p_trip_id and user_id = v_user_id;
exception
  when unique_violation then
    raise exception 'already_in_another_trip';
end;
$$;

create or replace function public.remove_trip_member(p_trip_id bigint, p_user_id uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_actor uuid := (select auth.uid());
  v_membership_closed boolean;
begin
  if v_actor is null then raise exception 'not_authenticated'; end if;
  if p_user_id = v_actor then raise exception 'cannot_remove_self'; end if;

  select t.membership_closed into v_membership_closed
  from public.trips t
  where t.id = p_trip_id and t.created_by = v_actor
  for update;

  if not found then raise exception 'trip_not_found_or_forbidden'; end if;
  if v_membership_closed then raise exception 'membership_closed'; end if;

  update public.trip_members
  set member_status = 'removed'
  where trip_id = p_trip_id
    and user_id = p_user_id
    and member_type <> 'leader'
    and member_status in ('pending', 'accepted');

  if not found then raise exception 'member_not_removable'; end if;
end;
$$;

create or replace function public.can_view_trip_member_task(p_task_id bigint)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.trip_member_tasks task
    join public.trip_members assigned_member on assigned_member.id = task.trip_member_id
    join public.trips t on t.id = assigned_member.trip_id
    where task.id = p_task_id
      and (
        t.created_by = (select auth.uid())
        or exists (
          select 1 from public.trip_members viewer
          where viewer.trip_id = t.id
            and viewer.user_id = (select auth.uid())
            and viewer.member_status = 'accepted'
        )
      )
  );
$$;

create or replace function public.can_create_trip_member_task(p_trip_member_id bigint)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.trip_members assigned_member
    join public.trips t on t.id = assigned_member.trip_id
    where assigned_member.id = p_trip_member_id
      and assigned_member.member_status = 'accepted'
      and t.membership_closed = true
      and t.created_by = (select auth.uid())
  );
$$;

create or replace function public.can_update_trip_member_task(p_task_id bigint)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.trip_member_tasks task
    join public.trip_members assigned_member on assigned_member.id = task.trip_member_id
    join public.trips t on t.id = assigned_member.trip_id
    where task.id = p_task_id
      and assigned_member.member_status = 'accepted'
      and t.membership_closed = true
      and (
        t.created_by = (select auth.uid())
        or assigned_member.user_id = (select auth.uid())
      )
  );
$$;

create or replace function public.can_delete_trip_member_task(p_task_id bigint)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.trip_member_tasks task
    join public.trip_members assigned_member on assigned_member.id = task.trip_member_id
    join public.trips t on t.id = assigned_member.trip_id
    where task.id = p_task_id
      and task.is_done = false
      and assigned_member.member_status = 'accepted'
      and t.membership_closed = true
      and t.created_by = (select auth.uid())
  );
$$;

create or replace function public.enforce_trip_member_task_rules()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_user_id uuid := (select auth.uid());
  v_leader_id uuid;
  v_assignee_id uuid;
  v_membership_closed boolean;
begin
  if tg_op = 'DELETE' then
    select t.created_by, t.membership_closed, tm.user_id
    into v_leader_id, v_membership_closed, v_assignee_id
    from public.trip_members tm
    join public.trips t on t.id = tm.trip_id
    where tm.id = old.trip_member_id
    for update of t;

    if not found then raise exception 'trip_not_found'; end if;
    if not v_membership_closed then raise exception 'membership_not_closed'; end if;
    if v_leader_id is distinct from v_user_id then raise exception 'leader_only'; end if;
    if old.is_done then raise exception 'task_already_completed'; end if;
    return old;
  end if;

  select t.created_by, t.membership_closed, tm.user_id
  into v_leader_id, v_membership_closed, v_assignee_id
  from public.trip_members tm
  join public.trips t on t.id = tm.trip_id
  where tm.id = new.trip_member_id
    and tm.member_status = 'accepted'
  for update of t;

  if not found then raise exception 'task_assignee_not_active'; end if;
  if not v_membership_closed then raise exception 'membership_not_closed'; end if;

  if tg_op = 'INSERT' then
    if v_leader_id is distinct from v_user_id then raise exception 'leader_only'; end if;
    if new.is_done then raise exception 'task_must_start_pending'; end if;
    new.updated_at := now();
    return new;
  end if;

  if old.is_done then raise exception 'task_already_completed'; end if;

  if v_user_id = v_leader_id then
    if new.is_done is distinct from old.is_done then
      if not (
        v_assignee_id = v_user_id
        and new.is_done = true
        and new.task is not distinct from old.task
        and new.trip_member_id = old.trip_member_id
      ) then
        raise exception 'leader_cannot_complete_other_member_task';
      end if;
    end if;
  elsif v_user_id = v_assignee_id then
    if new.task is distinct from old.task
       or new.trip_member_id is distinct from old.trip_member_id
       or new.is_done is distinct from true then
      raise exception 'assigned_member_can_only_complete_own_task';
    end if;
  else
    raise exception 'task_update_forbidden';
  end if;

  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists enforce_trip_member_task_rules on public.trip_member_tasks;
create trigger enforce_trip_member_task_rules
before insert or update or delete on public.trip_member_tasks
for each row execute function public.enforce_trip_member_task_rules();

drop policy if exists "Users can view trip member tasks" on public.trip_member_tasks;
drop policy if exists "Users can create their own trip tasks" on public.trip_member_tasks;
drop policy if exists "Users can update their own trip tasks" on public.trip_member_tasks;
drop policy if exists "Users can delete their own trip tasks" on public.trip_member_tasks;

create policy "Trip members can view all trip tasks"
on public.trip_member_tasks for select to authenticated
using (public.can_view_trip_member_task(id));

create policy "Trip leaders can create assigned tasks"
on public.trip_member_tasks for insert to authenticated
with check (public.can_create_trip_member_task(trip_member_id));

create policy "Assignees and leaders can update unfinished tasks"
on public.trip_member_tasks for update to authenticated
using (public.can_update_trip_member_task(id))
with check (public.can_update_trip_member_task(id));

create policy "Trip leaders can delete unfinished tasks"
on public.trip_member_tasks for delete to authenticated
using (public.can_delete_trip_member_task(id));

create or replace function public.get_trip_task_context(p_trip_id bigint)
returns jsonb
language plpgsql
stable
security definer
set search_path = ''
as $$
declare
  v_user_id uuid := (select auth.uid());
  v_result jsonb;
begin
  if v_user_id is null then raise exception 'not_authenticated'; end if;

  if not exists (
    select 1 from public.trips t
    where t.id = p_trip_id
      and (
        t.created_by = v_user_id
        or exists (
          select 1 from public.trip_members tm
          where tm.trip_id = t.id
            and tm.user_id = v_user_id
            and tm.member_status = 'accepted'
        )
      )
  ) then raise exception 'trip_not_found_or_forbidden'; end if;

  select jsonb_build_object(
    'trip_id', t.id,
    'trip_name', t.name,
    'membership_closed', t.membership_closed,
    'is_leader', t.created_by = v_user_id,
    'members', coalesce((
      select jsonb_agg(
        jsonb_build_object(
          'trip_member_id', tm.id,
          'user_id', tm.user_id,
          'first_name', p.first_name,
          'last_name', p.last_name,
          'username', p.username,
          'member_type', tm.member_type
        ) order by tm.member_type desc, tm.joined_at
      )
      from public.trip_members tm
      join public.profiles p on p.id = tm.user_id
      where tm.trip_id = t.id and tm.member_status = 'accepted'
    ), '[]'::jsonb),
    'tasks', coalesce((
      select jsonb_agg(
        jsonb_build_object(
          'id', task.id,
          'task', task.task,
          'is_done', task.is_done,
          'trip_member_id', task.trip_member_id,
          'user_id', tm.user_id,
          'first_name', p.first_name,
          'last_name', p.last_name,
          'username', p.username,
          'created_at', task.created_at
        ) order by task.created_at, task.id
      )
      from public.trip_member_tasks task
      join public.trip_members tm on tm.id = task.trip_member_id
      join public.profiles p on p.id = tm.user_id
      where tm.trip_id = t.id
    ), '[]'::jsonb)
  )
  into v_result
  from public.trips t
  where t.id = p_trip_id;

  return v_result;
end;
$$;

revoke all on function public.set_trip_membership_closed(bigint, boolean) from public, anon;
revoke all on function public.get_trip_membership_closed(bigint) from public, anon;
revoke all on function public.enforce_trip_membership_lock() from public, anon;
revoke all on function public.can_view_trip_member_task(bigint) from public, anon;
revoke all on function public.can_create_trip_member_task(bigint) from public, anon;
revoke all on function public.can_update_trip_member_task(bigint) from public, anon;
revoke all on function public.can_delete_trip_member_task(bigint) from public, anon;
revoke all on function public.enforce_trip_member_task_rules() from public, anon;
revoke all on function public.get_trip_task_context(bigint) from public, anon;

grant execute on function public.set_trip_membership_closed(bigint, boolean) to authenticated;
grant execute on function public.get_trip_membership_closed(bigint) to authenticated;
grant execute on function public.can_view_trip_member_task(bigint) to authenticated;
grant execute on function public.can_create_trip_member_task(bigint) to authenticated;
grant execute on function public.can_update_trip_member_task(bigint) to authenticated;
grant execute on function public.can_delete_trip_member_task(bigint) to authenticated;
grant execute on function public.get_trip_task_context(bigint) to authenticated;
