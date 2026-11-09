drop policy if exists "Trip members can create activities"
  on public.trip_activities;

revoke insert on table public.trip_activities
  from public, anon, authenticated;

notify pgrst, 'reload schema';
