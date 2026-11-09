-- Allow a signed-in prospective member to inspect the public trip's
-- membership status without exposing member details or task data.
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

  select t.membership_closed into v_closed
  from public.trips t
  where t.id = p_trip_id;

  if not found then raise exception 'trip_not_found'; end if;
  return v_closed;
end;
$$;

revoke all on function public.get_trip_membership_closed(bigint) from public, anon;
grant execute on function public.get_trip_membership_closed(bigint) to authenticated;
