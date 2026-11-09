-- Preserve task cascade deletes when a trip and its member rows are deleted.
-- Also prevent a task from being reassigned to a member of another trip.
create or replace function private.enforce_trip_member_task_rules()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_user_id uuid := (select auth.uid());
  v_leader_id uuid;
  v_assignee_id uuid;
  v_trip_id bigint;
  v_old_trip_id bigint;
  v_membership_closed boolean;
begin
  if tg_op = 'DELETE' then
    select t.created_by, t.id, t.membership_closed, tm.user_id
    into v_leader_id, v_trip_id, v_membership_closed, v_assignee_id
    from public.trip_members tm
    join public.trips t on t.id = tm.trip_id
    where tm.id = old.trip_member_id
    for update of t;

    if not found then return old; end if;
    if not v_membership_closed then raise exception 'membership_not_closed'; end if;
    if v_leader_id is distinct from v_user_id then raise exception 'leader_only'; end if;
    if old.is_done then raise exception 'task_already_completed'; end if;
    return old;
  end if;

  select t.created_by, t.id, t.membership_closed, tm.user_id
  into v_leader_id, v_trip_id, v_membership_closed, v_assignee_id
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

  if new.trip_member_id is distinct from old.trip_member_id then
    select tm.trip_id into v_old_trip_id
    from public.trip_members tm where tm.id = old.trip_member_id;
    if v_old_trip_id is distinct from v_trip_id then
      raise exception 'task_reassignment_must_stay_in_trip';
    end if;
  end if;

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

revoke all on function private.enforce_trip_member_task_rules() from public, anon, authenticated;
