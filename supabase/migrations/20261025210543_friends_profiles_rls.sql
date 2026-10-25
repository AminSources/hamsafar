-- Allow authenticated users to read only their own profile and profiles of confirmed friends.
-- The friendships table stores both directions; the predicate supports either direction.
create policy "Users can view confirmed friends profiles"
on public.profiles
for select
to authenticated
using (
  exists (
    select 1
    from public.friendships f
    where (f.user_id = (select auth.uid()) and f.friend_id = profiles.id)
       or (f.friend_id = (select auth.uid()) and f.user_id = profiles.id)
  )
);

-- Friend profile payloads include availability and tool selections. Keep those
-- rows private except to the owner and confirmed friends.
create policy "Users can view confirmed friends availability"
on public.user_availability
for select
to authenticated
using (
  user_id = (select auth.uid())
  or exists (
    select 1
    from public.friendships f
    where (f.user_id = (select auth.uid()) and f.friend_id = user_availability.user_id)
       or (f.friend_id = (select auth.uid()) and f.user_id = user_availability.user_id)
  )
);

create policy "Users can view confirmed friends tools"
on public.user_tools
for select
to authenticated
using (
  user_id = (select auth.uid())
  or exists (
    select 1
    from public.friendships f
    where (f.user_id = (select auth.uid()) and f.friend_id = user_tools.user_id)
       or (f.friend_id = (select auth.uid()) and f.user_id = user_tools.user_id)
  )
);
