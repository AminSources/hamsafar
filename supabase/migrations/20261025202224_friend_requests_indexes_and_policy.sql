-- Index the friend request relationship columns and simplify request SELECT policies.
create index if not exists friend_requests_sender_id_idx
  on public.friend_requests(sender_id);
create index if not exists friend_requests_receiver_id_idx
  on public.friend_requests(receiver_id);
create index if not exists friendships_friend_id_idx
  on public.friendships(friend_id);

drop policy if exists "Users can view received friend requests"
  on public.friend_requests;
drop policy if exists "Users can view sent friend requests"
  on public.friend_requests;

create policy "Users can view their own friend requests"
on public.friend_requests
for select
to authenticated
using (
  (select auth.uid()) = receiver_id
  or (select auth.uid()) = sender_id
);
