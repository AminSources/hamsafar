-- Move internal authorization helpers away from the exposed public API schema.
create schema if not exists private;
revoke all on schema private from public, anon, authenticated;
grant usage on schema private to authenticated;

drop policy if exists "Trip members can view all trip tasks" on public.trip_member_tasks;
drop policy if exists "Trip leaders can create assigned tasks" on public.trip_member_tasks;
drop policy if exists "Assignees and leaders can update unfinished tasks" on public.trip_member_tasks;
drop policy if exists "Trip leaders can delete unfinished tasks" on public.trip_member_tasks;

drop trigger if exists enforce_trip_member_task_rules on public.trip_member_tasks;
drop trigger if exists enforce_trip_membership_lock on public.trip_members;

do $$
declare
  v_def text;
  v_name text;
  v_oid oid;
begin
  foreach v_name in array array[
    'can_view_trip_member_task',
    'can_create_trip_member_task',
    'can_update_trip_member_task',
    'can_delete_trip_member_task',
    'enforce_trip_member_task_rules',
    'enforce_trip_membership_lock'
  ]
  loop
    select p.oid into v_oid
    from pg_proc p
    join pg_namespace n on n.oid = p.pronamespace
    where n.nspname = 'public' and p.proname = v_name;

    if v_oid is not null then
      v_def := pg_get_functiondef(v_oid);
      v_def := replace(v_def, 'FUNCTION public.' || v_name, 'FUNCTION private.' || v_name);
      execute v_def;
    end if;
  end loop;
end;
$$;

create trigger enforce_trip_membership_lock
before insert or update or delete on public.trip_members
for each row execute function private.enforce_trip_membership_lock();

create trigger enforce_trip_member_task_rules
before insert or update or delete on public.trip_member_tasks
for each row execute function private.enforce_trip_member_task_rules();

create policy "Trip members can view all trip tasks"
on public.trip_member_tasks
for select to authenticated
using (private.can_view_trip_member_task(id));

create policy "Trip leaders can create assigned tasks"
on public.trip_member_tasks
for insert to authenticated
with check (private.can_create_trip_member_task(trip_member_id));

create policy "Assignees and leaders can update unfinished tasks"
on public.trip_member_tasks
for update to authenticated
using (private.can_update_trip_member_task(id))
with check (private.can_update_trip_member_task(id));

create policy "Trip leaders can delete unfinished tasks"
on public.trip_member_tasks
for delete to authenticated
using (private.can_delete_trip_member_task(id));

grant execute on function private.can_view_trip_member_task(bigint) to authenticated;
grant execute on function private.can_create_trip_member_task(bigint) to authenticated;
grant execute on function private.can_update_trip_member_task(bigint) to authenticated;
grant execute on function private.can_delete_trip_member_task(bigint) to authenticated;

revoke all on function private.enforce_trip_member_task_rules() from public, anon, authenticated;
revoke all on function private.enforce_trip_membership_lock() from public, anon, authenticated;

drop function if exists public.can_view_trip_member_task(bigint);
drop function if exists public.can_create_trip_member_task(bigint);
drop function if exists public.can_update_trip_member_task(bigint);
drop function if exists public.can_delete_trip_member_task(bigint);
drop function if exists public.enforce_trip_member_task_rules();
drop function if exists public.enforce_trip_membership_lock();
