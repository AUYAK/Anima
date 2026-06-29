-- profiles: insert handled by trigger (security definer), so authenticated only needs select/update
GRANT SELECT, UPDATE ON public.profiles TO authenticated;

-- user-owned tables
GRANT SELECT, INSERT, UPDATE, DELETE ON public.pets TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.events TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.photos TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.measurements TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.course_progress TO authenticated;

-- courses are public read
GRANT SELECT ON public.courses TO authenticated;
GRANT SELECT ON public.courses TO anon;
