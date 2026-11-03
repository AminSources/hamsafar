-- Keep membership status lookup under the caller's RLS permissions.
create or replace function public.get_trip_membership_status(p_trip_id bigint)
returns text language sql stable security invoker set search_path = ''
as $$
  select tm.member_status
  from public.trip_members tm
  where tm.trip_id = p_trip_id and tm.user_id = (select auth.uid())
  limit 1;
$$;
revoke all on function public.get_trip_membership_status(bigint) from public, anon;
grant execute on function public.get_trip_membership_status(bigint) to authenticated;
