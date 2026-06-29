ALTER TABLE pets
  ADD COLUMN status text NOT NULL DEFAULT 'active'
    CHECK (status IN ('active', 'passed_away', 'removed')),
  ADD COLUMN status_changed_at timestamptz;
