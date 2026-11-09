-- Profile preferences: availability and user-owned equipment.
-- Both RPCs are SECURITY INVOKER and rely on existing ownership RLS policies.

drop policy if exists "Authenticated users can add tools" on public.tools;
create policy "Authenticated users can add tools"
on public.tools for insert to authenticated
with check (true);

create or replace function public.replace_user_availability(
  p_days text[],
  p_time_from time without time zone,
  p_time_to time without time zone
)
returns void
language plpgsql
security invoker
set search_path = ''
as $$
declare
  v_user_id uuid;
begin
  v_user_id := auth.uid();
  if v_user_id is null then
    raise exception 'Authentication is required';
  end if;

  if p_time_from is null or p_time_to is null or p_time_from >= p_time_to then
    raise exception 'Invalid availability time range';
  end if;

  if exists (
    select 1
    from unnest(coalesce(p_days, array[]::text[])) as requested(day_code)
    where requested.day_code is null
       or requested.day_code not in ('sat', 'sun', 'mon', 'tue', 'wed', 'thu', 'fri')
  ) then
    raise exception 'One or more weekday values are invalid';
  end if;

  delete from public.user_availability where user_id = v_user_id;

  insert into public.user_availability (user_id, day_of_week, time_from, time_to)
  select v_user_id, selected.day_code, p_time_from, p_time_to
  from (
    select distinct requested.day_code
    from unnest(coalesce(p_days, array[]::text[])) as requested(day_code)
  ) as selected;
end;
$$;

revoke all on function public.replace_user_availability(text[], time without time zone, time without time zone) from public, anon;
grant execute on function public.replace_user_availability(text[], time without time zone, time without time zone) to authenticated;

create or replace function public.save_user_tools(p_tools jsonb)
returns void
language plpgsql
security invoker
set search_path = ''
as $$
declare
  v_user_id uuid;
  v_item jsonb;
  v_name text;
  v_tool_id bigint;
  v_is_available boolean;
  v_seen_names text[] := array[]::text[];
begin
  v_user_id := auth.uid();
  if v_user_id is null then
    raise exception 'Authentication is required';
  end if;

  if p_tools is null or jsonb_typeof(p_tools) <> 'array' then
    raise exception 'Tools payload must be a JSON array';
  end if;

  for v_item in select value from jsonb_array_elements(p_tools)
  loop
    v_name := nullif(btrim(v_item ->> 'name'), '');
    if v_name is null then
      raise exception 'Tool title cannot be empty';
    end if;

    if lower(v_name) = any(v_seen_names) then
      raise exception 'Duplicate tool title: %', v_name;
    end if;
    v_seen_names := array_append(v_seen_names, lower(v_name));

    v_is_available := coalesce((v_item ->> 'is_available')::boolean, true);

    insert into public.tools (name) values (v_name)
    on conflict (name) do nothing;

    select id into v_tool_id from public.tools where name = v_name;
    if v_tool_id is null then
      raise exception 'Could not resolve tool catalogue entry';
    end if;

    insert into public.user_tools (user_id, tool_id, is_available)
    values (v_user_id, v_tool_id, v_is_available)
    on conflict (user_id, tool_id)
    do update set is_available = excluded.is_available;
  end loop;
end;
$$;

revoke all on function public.save_user_tools(jsonb) from public, anon;
grant execute on function public.save_user_tools(jsonb) to authenticated;
