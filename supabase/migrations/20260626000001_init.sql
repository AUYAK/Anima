-- profiles: extends auth.users
create table public.profiles (
  id          uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  avatar_url  text,
  created_at  timestamptz default now()
);
alter table public.profiles enable row level security;
create policy "owner" on public.profiles for all using (auth.uid() = id);

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer as $$
begin
  insert into public.profiles(id) values (new.id);
  return new;
end;
$$;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- pets
create table public.pets (
  id         uuid primary key default gen_random_uuid(),
  owner_id   uuid not null references public.profiles(id) on delete cascade,
  name       text not null,
  species    text not null,
  breed      text,
  dob        date,
  photo_url  text,
  notes      text,
  created_at timestamptz default now()
);
alter table public.pets enable row level security;
create policy "owner" on public.pets for all using (auth.uid() = owner_id);

-- events
create table public.events (
  id               uuid primary key default gen_random_uuid(),
  pet_id           uuid not null references public.pets(id) on delete cascade,
  type             text not null check (type in ('vaccine','grooming','birthday','vet','other')),
  title            text not null,
  event_date       timestamptz not null,
  notes            text,
  reminder_enabled boolean default false,
  reminder_offset  interval,
  created_at       timestamptz default now()
);
alter table public.events enable row level security;
create policy "owner" on public.events for all
  using (exists (select 1 from public.pets where pets.id = events.pet_id and pets.owner_id = auth.uid()));

-- photos
create table public.photos (
  id         uuid primary key default gen_random_uuid(),
  pet_id     uuid not null references public.pets(id) on delete cascade,
  url        text not null,
  caption    text,
  taken_at   timestamptz,
  created_at timestamptz default now()
);
alter table public.photos enable row level security;
create policy "owner" on public.photos for all
  using (exists (select 1 from public.pets where pets.id = photos.pet_id and pets.owner_id = auth.uid()));

-- measurements
create table public.measurements (
  id          uuid primary key default gen_random_uuid(),
  pet_id      uuid not null references public.pets(id) on delete cascade,
  weight_kg   numeric,
  height_cm   numeric,
  measured_at timestamptz not null,
  notes       text
);
alter table public.measurements enable row level security;
create policy "owner" on public.measurements for all
  using (exists (select 1 from public.pets where pets.id = measurements.pet_id and pets.owner_id = auth.uid()));

-- courses
create table public.courses (
  id          uuid primary key default gen_random_uuid(),
  title       text not null,
  description text,
  species     text,
  content     jsonb,
  created_at  timestamptz default now()
);
alter table public.courses enable row level security;
create policy "read_all" on public.courses for select using (true);

-- course_progress
create table public.course_progress (
  id           uuid primary key default gen_random_uuid(),
  user_id      uuid not null references public.profiles(id) on delete cascade,
  course_id    uuid not null references public.courses(id) on delete cascade,
  progress     jsonb default '{}',
  completed_at timestamptz,
  unique(user_id, course_id)
);
alter table public.course_progress enable row level security;
create policy "owner" on public.course_progress for all using (auth.uid() = user_id);