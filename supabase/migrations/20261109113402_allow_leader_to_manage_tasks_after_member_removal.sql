-- If recruitment is reopened, a member may be removed while a task still
-- references their membership row. The leader must still be able to reassign
-- that unfinished task to an active member or delete it.
create or replace function private.can_update_trip_member_task(p_task_id bigint)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.trip_member_tasks task
    join public.trip_members assigned_member on assigned_member.id = task.trip_member_id
    join public.trips t on t.id = assigned_member.trip_id
    where task.id = p_task_id
      and t.membership_closed = true
      and (
        t.created_by = (select auth.uid())
        or (
          assigned_member.user_id = (select auth.uid())
          and assigned_member.member_status = 'accepted'
        )
      )
  );
$$;

create or replace function private.can_delete_trip_member_task(p_task_id bigint)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.trip_member_tasks task
    join public.trip_members assigned_member on assigned_member.id = task.trip_member_id
    join public.trips t on t.id = assigned_member.trip_id
    where task.id = p_task_id
      and task.is_done = false
      and t.membership_closed = true
      and t.created_by = (select auth.uid())
  );
$$;

grant execute on function private.can_update_trip_member_task(bigint) to authenticated;
grant execute on function private.can_delete_trip_member_task(bigint) to authenticated;
