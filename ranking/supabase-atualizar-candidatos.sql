-- Rode no Supabase: SQL Editor > New query > Run
-- Atualiza a lista de candidatos aceitos pela tabela de votos:
--   + camilo-santana
--   + rui-costa-pimenta (substitui rui-costa)
-- Os votos já registrados (flavio-dino, hertz-dias) continuam válidos.

alter table public.votes drop constraint votes_option_id_check;

alter table public.votes add constraint votes_option_id_check check (option_id in (
  'flavio-dino','jones-manoel','haddad','dilma',
  'elias-jabbour','camilo-santana','rui-costa-pimenta','hertz-dias','samara'
));
