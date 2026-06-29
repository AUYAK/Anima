ALTER TABLE pets ADD COLUMN gender text CHECK (gender IN ('Male', 'Female', 'Unknown'));

INSERT INTO storage.buckets (id, name, public)
VALUES ('pet-photos', 'pet-photos', true)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Users can upload own pet photos"
  ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (
    bucket_id = 'pet-photos'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

CREATE POLICY "Users can update own pet photos"
  ON storage.objects FOR UPDATE TO authenticated
  USING (
    bucket_id = 'pet-photos'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

CREATE POLICY "Users can delete own pet photos"
  ON storage.objects FOR DELETE TO authenticated
  USING (
    bucket_id = 'pet-photos'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

CREATE POLICY "Pet photos are publicly accessible"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'pet-photos');
