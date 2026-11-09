-- Automatically activate trips when their departure time arrives.
-- Also expose a leader-only RPC for starting a trip manually.

create extension if not exists pg_cron with schema pg_catalog;

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
      updated_at = now()
  where status = 'preparing'
    and departure_at <= now();

  get diagnostics v_updated_count = row_count;
  return v_updated_count;
end;
$$;

-- The scheduled job runs under the postgres role.
revoke all on function public.activate_departed_trips() from public, anon, authenticated;

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
      updated_at = now()
  where id = p_trip_id
    and created_by = (select auth.uid())
    and status = 'preparing';

  if not found then
    raise exception 'trip_not_found_or_not_preparing';
  end if;
end;
$$;

revoke all on function public.start_trip(bigint) from public, anon;
grant execute on function public.start_trip(bigint) to authenticated;

do $$
declare
  v_job_id bigint;
begin
  for v_job_id in
    select jobid from cron.job where jobname = 'activate-departed-trips'
  loop
    perform cron.unschedule(v_job_id);
  end loop;
end;
$$;

select cron.schedule(
  'activate-departed-trips',
  '* * * * *',
  $$select public.activate_departed_trips();$$
);
