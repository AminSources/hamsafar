create policy "Users can remove their friendships"
on public.friendships
for delete
to authenticated
using (
  (select auth.uid()) = user_id
  or (select auth.uid()) = friend_id
);

create or replace function public.remove_friend(p_friend_id uuid)
returns void
language plpgsql
set search_path = ''
as $function$
declare
  v_user_id uuid := auth.uid();
  v_deleted_rows integer;
begin
  if v_user_id is null then
    raise exception 'not_authenticated';
  end if;

  if p_friend_id is null or p_friend_id = v_user_id then
    raise exception 'invalid_friend';
  end if;

  delete from public.friendships f
  where (f.user_id = v_user_id and f.friend_id = p_friend_id)
     or (f.user_id = p_friend_id and f.friend_id = v_user_id);

  get diagnostics v_deleted_rows = row_count;

  if v_deleted_rows = 0 then
    raise exception 'friendship_not_found';
  end if;
end;
$function$;

revoke all on function public.remove_friend(uuid) from public;
revoke all on function public.remove_friend(uuid) from anon;
grant execute on function public.remove_friend(uuid) to authenticated;
