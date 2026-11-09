create index if not exists trip_activities_user_id_idx
  on public.trip_activities (user_id);

create index if not exists trip_activities_subject_user_id_idx
  on public.trip_activities (subject_user_id);
