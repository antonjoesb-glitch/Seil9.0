-- Conference app schema + RLS policies
-- Project: qhjyykfjpfsfzqmfzatp

begin;

-- Ensure required extension for UUID generation
create extension if not exists pgcrypto;

-- PROFILES
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null default 'Conference User',
  email text not null default '',
  organization text not null default 'Conference Participant',
  role text not null default 'Attendee',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Keep updated_at fresh
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_profiles_updated_at on public.profiles;
create trigger set_profiles_updated_at
before update on public.profiles
for each row execute procedure public.set_updated_at();

alter table public.profiles enable row level security;

drop policy if exists "profiles_select_own" on public.profiles;
create policy "profiles_select_own"
on public.profiles
for select
to authenticated
using (auth.uid() = id);

drop policy if exists "profiles_insert_own" on public.profiles;
create policy "profiles_insert_own"
on public.profiles
for insert
to authenticated
with check (auth.uid() = id);

drop policy if exists "profiles_update_own" on public.profiles;
create policy "profiles_update_own"
on public.profiles
for update
to authenticated
using (auth.uid() = id)
with check (auth.uid() = id);

-- AGENDA ITEMS
create table if not exists public.agenda_items (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  speaker text not null default 'TBA',
  room text not null default 'Main Hall',
  start_at timestamptz not null,
  description text not null default '',
  created_at timestamptz not null default now()
);

alter table public.agenda_items enable row level security;

-- Conference schedule readable by any logged-in user (including anonymous auth users).
drop policy if exists "agenda_select_authenticated" on public.agenda_items;
create policy "agenda_select_authenticated"
on public.agenda_items
for select
to authenticated
using (true);

-- Optional admin-only write policy placeholder:
-- create policy "agenda_write_admin_only"
-- on public.agenda_items
-- for all
-- to authenticated
-- using (exists (
--   select 1
--   from public.profiles p
--   where p.id = auth.uid() and p.role = 'Admin'
-- ))
-- with check (exists (
--   select 1
--   from public.profiles p
--   where p.id = auth.uid() and p.role = 'Admin'
-- ));

commit;

-- Seed sample agenda records (run once, optional)
insert into public.agenda_items (title, speaker, room, start_at, description)
values
  ('Inaugural Keynote', 'Chief Guest', 'Grand Auditorium', now() + interval '1 hour', 'Opening session for IPS Conference'),
  ('Thermal Efficiency Panel', 'Industry Leaders', 'Hall B', now() + interval '3 hours', 'Discussion on reliability and optimization')
on conflict do nothing;
