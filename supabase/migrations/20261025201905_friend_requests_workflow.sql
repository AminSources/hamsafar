-- Request Friends workflow for Hamsafar.
-- Only pending requests are displayed in the UI. Rejected/cancelled rows stay
-- in the database as history and never appear in the pending RPC results.

drop function if exists public.respond_to_friend_request(uuid, boolean);
drop function if exists public.cancel_friend_request(uuid);
drop function if exists public.get_pending_friend_request_profiles(text);
drop function if exists public.search_friend_profiles(text);

create unique index if not exists friend_requests_unique_pending_pair
on public.friend_requests (
  least(sender_id, receiver_id),
  greatest(sender_id, receiver_id)
)
where status = 'pending';

create function public.search_friend_profiles(p_query text)
returns table (
  id uuid,
  username text,
  first_name text,
  last_name text,
  avatar_icon text,
  bio text,
  rate numeric,
  trip_count integer,
  relation_status text
)
language sql
stable
security definer
set search_path = ''
as $$
  select p.id, p.username, p.first_name, p.last_name, p.avatar_icon,
         p.bio, p.rate, p.trip_count,
         case
           when exists (
             select 1 from public.friendships f
             where (f.user_id = auth.uid() and f.friend_id = p.id)
                or (f.user_id = p.id and f.friend_id = auth.uid())
           ) then 'friends'
           when exists (
             select 1 from public.friend_requests r
             where r.sender_id = auth.uid() and r.receiver_id = p.id
               and r.status = 'pending'
           ) then 'outgoing_pending'
           when exists (
             select 1 from public.friend_requests r
             where r.sender_id = p.id and r.receiver_id = auth.uid()
               and r.status = 'pending'
           ) then 'incoming_pending'
           else 'none'
         end as relation_status
  from public.profiles p
  where auth.uid() is not null
    and length(trim(coalesce(p_query, ''))) >= 2
    and p.id <> auth.uid()
    and p.username ilike ('%' || trim(p_query) || '%')
  order by p.username
  limit 30;
$$;

create or replace function public.send_friend_request(p_receiver_id uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_sender_id uuid := auth.uid();
begin
  if v_sender_id is null then raise exception 'not_authenticated'; end if;
  if p_receiver_id is null or p_receiver_id = v_sender_id then
    raise exception 'invalid_receiver';
  end if;
  if not exists (select 1 from public.profiles p where p.id = p_receiver_id) then
    raise exception 'receiver_not_found';
  end if;
  if exists (
    select 1 from public.friendships f
    where (f.user_id = v_sender_id and f.friend_id = p_receiver_id)
       or (f.user_id = p_receiver_id and f.friend_id = v_sender_id)
  ) then raise exception 'already_friends'; end if;
  if exists (
    select 1 from public.friend_requests r
    where r.status = 'pending'
      and r.sender_id = p_receiver_id and r.receiver_id = v_sender_id
  ) then raise exception 'incoming_request_exists'; end if;

  begin
    insert into public.friend_requests(sender_id, receiver_id, status)
    values (v_sender_id, p_receiver_id, 'pending');
  exception when unique_violation then
    raise exception 'request_already_pending';
  end;
end;
$$;

create function public.respond_to_friend_request(
  p_other_user_id uuid,
  p_accept boolean
)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_user_id uuid := auth.uid();
  v_request_id bigint;
begin
  if v_user_id is null then raise exception 'not_authenticated'; end if;
  if p_other_user_id is null or p_other_user_id = v_user_id then
    raise exception 'invalid_request_user';
  end if;

  select r.id into v_request_id
  from public.friend_requests r
  where r.sender_id = p_other_user_id
    and r.receiver_id = v_user_id
    and r.status = 'pending'
  for update;

  if not found then raise exception 'pending_incoming_request_not_found'; end if;

  update public.friend_requests
  set status = case when p_accept then 'accepted' else 'rejected' end,
      responded_at = now()
  where id = v_request_id and status = 'pending';

  if p_accept then
    insert into public.friendships(user_id, friend_id)
    values (p_other_user_id, v_user_id), (v_user_id, p_other_user_id)
    on conflict (user_id, friend_id) do nothing;
  end if;
end;
$$;

create function public.cancel_friend_request(p_other_user_id uuid)
returns void
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_user_id uuid := auth.uid();
begin
  if v_user_id is null then raise exception 'not_authenticated'; end if;
  if p_other_user_id is null or p_other_user_id = v_user_id then
    raise exception 'invalid_request_user';
  end if;

  update public.friend_requests
  set status = 'cancelled', responded_at = now()
  where sender_id = v_user_id
    and receiver_id = p_other_user_id
    and status = 'pending';

  if not found then raise exception 'pending_outgoing_request_not_found'; end if;
end;
$$;

create function public.get_pending_friend_request_profiles(p_direction text)
returns table (
  id uuid,
  username text,
  first_name text,
  last_name text,
  avatar_icon text,
  bio text,
  rate numeric,
  trip_count integer
)
language plpgsql
stable
security definer
set search_path = ''
as $$
begin
  if auth.uid() is null then raise exception 'not_authenticated'; end if;
  if p_direction not in ('incoming', 'outgoing') then raise exception 'invalid_direction'; end if;

  if p_direction = 'incoming' then
    return query
    select p.id, p.username, p.first_name, p.last_name, p.avatar_icon,
           p.bio, p.rate, p.trip_count
    from public.friend_requests r
    join public.profiles p on p.id = r.sender_id
    where r.receiver_id = auth.uid() and r.status = 'pending'
    order by r.created_at desc;
  else
    return query
    select p.id, p.username, p.first_name, p.last_name, p.avatar_icon,
           p.bio, p.rate, p.trip_count
    from public.friend_requests r
    join public.profiles p on p.id = r.receiver_id
    where r.sender_id = auth.uid() and r.status = 'pending'
    order by r.created_at desc;
  end if;
end;
$$;

-- Mutations must use the validated functions above rather than direct table writes.
revoke all on table public.friend_requests from anon, authenticated;
grant select on table public.friend_requests to authenticated;

revoke all on function public.search_friend_profiles(text) from public, anon;
revoke all on function public.send_friend_request(uuid) from public, anon;
revoke all on function public.respond_to_friend_request(uuid, boolean) from public, anon;
revoke all on function public.cancel_friend_request(uuid) from public, anon;
revoke all on function public.get_pending_friend_request_profiles(text) from public, anon;

grant execute on function public.search_friend_profiles(text) to authenticated;
grant execute on function public.send_friend_request(uuid) to authenticated;
grant execute on function public.respond_to_friend_request(uuid, boolean) to authenticated;
grant execute on function public.cancel_friend_request(uuid) to authenticated;
grant execute on function public.get_pending_friend_request_profiles(text) to authenticated;
