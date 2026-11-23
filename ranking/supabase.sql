-- Rode no Supabase: SQL Editor > New query > Run

create table public.votes (
  id         bigint generated always as identity primary key,
  option_id  text not null check (option_id in (
    'flavio-dino','jones-manoel','haddad','dilma',
    'elias-jabbour','camilo-santana','rui-costa-pimenta','hertz-dias','samara'
  )),
  created_at timestamptz not null default now()
);

alter table public.votes enable row level security;

-- Qualquer pessoa pode inserir um voto, mas não pode ler, alterar nem apagar.
revoke all on public.votes from anon, authenticated;
grant insert on public.votes to anon;
create policy "anyone can vote" on public.votes
  for insert to anon with check (true);

-- O ranking público mostra só a contagem por opção. A view roda com os
-- direitos do dono, então não é preciso liberar leitura da tabela.
create view public.ranking as
  select option_id, count(*)::int as votes
  from public.votes
  group by option_id;

grant select on public.ranking to anon;
