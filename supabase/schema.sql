create extension if not exists "pgcrypto";

create table if not exists public.pf_profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null default 'Atleta PulseForge',
  sex char(1) not null check (sex in ('M', 'F')) default 'M',
  age int not null default 28,
  weight_kg numeric(5,2) not null default 80.0,
  height_cm numeric(5,1) not null default 178.0,
  activity_factor numeric(4,3) not null default 1.550,
  goal_offset_kcal int not null default -250,
  protein_per_kg numeric(3,2) not null default 2.00,
  streak_days int not null default 0,
  encrypted_vault_blob jsonb,
  updated_at timestamptz not null default now()
);

alter table public.pf_profiles enable row level security;
create policy "Users manage own profile" on public.pf_profiles for all using (auth.uid() = id);
