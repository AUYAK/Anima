ALTER TABLE public.pets DROP CONSTRAINT IF EXISTS pets_status_check;
ALTER TABLE public.pets ADD CONSTRAINT pets_status_check
  CHECK (status IN ('active', 'passed_away', 'removed', 'hard_deleted'));
