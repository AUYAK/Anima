# Anima — Pet Care App

## Roles
- **Dev chat** (VS Code + Claude Code): read `docs/roles/CLAUDE.dev.md` before starting work
- **Product chat** (Claude Desktop or VS Code): read `docs/roles/CLAUDE.product.md` before starting work
- Feature requirements live in `docs/product/features/<epic>/` — devs read, PMs write
- DOR checklist and feature template: `docs/DOR.md`

## What this is
Mobile app (iOS + Android) for pet care management.
One user account -> many pets (any species/breed).
Features: event calendar (vaccines, grooming, birthdays), photo gallery, growth tracking, training courses.
Free, no monetization for now.

## Tech stack
- **Mobile**: Flutter (Dart)
- **Backend/DB**: Supabase (PostgreSQL under the hood), local via Docker Compose
- **Auth**: Supabase Auth (email/password + Google Sign-In on Android; Apple Sign-In planned)
- **Storage**: Supabase Storage (pet photos)

## Project structure
```
anima/
├── mobile/          # Flutter app
│   ├── lib/
│   │   ├── core/    # theme, router, di, constants
│   │   ├── features/
│   │   │   ├── auth/
│   │   │   ├── pets/
│   │   │   ├── events/
│   │   │   ├── gallery/
│   │   │   ├── measurements/
│   │   │   └── courses/
│   │   └── shared/  # widgets, utils
│   └── test/
├── supabase/
│   └── migrations/  # SQL migration files
└── docs/
    ├── adr/              # Architecture Decision Records
    ├── schema.md         # DB schema reference
    ├── design-reference.md  # Figma design tokens
    └── product/
        ├── roadmap.md
        ├── todo.md
        └── features/           # Feature specs (PMs write, devs read)
            ├── pet-management/ # 001-pet-profile.md
            ├── home/           # 002-home-dashboard.md
            ├── platform/       # 007-localization.md
            ├── health-and-care/
            ├── gallery/
            └── learning/
```

## How to run
```bash
# Start local Supabase
cd supabase && supabase start

# Run Flutter app
cd mobile && flutter run
```

## Data model (key tables)
- `profiles` — user profile (extends Supabase auth.users)
- `pets` — pet records (name, species, breed, dob, photo_url, owner_id)
- `events` — calendar events (pet_id, type, title, date, notes, reminder_enabled)
- `photos` — pet photo gallery (pet_id, url, taken_at, caption)
- `measurements` — growth tracking (pet_id, weight_kg, height_cm, measured_at)
- `courses` — training/care courses (title, species, content)
- `course_progress` — user progress through courses (user_id, course_id, completed_at)

## Key conventions
- All DB timestamps in UTC
- pet `species` is a free-text field + optional enum hint (no hard-coding species)
- Events with `reminder_enabled=true` trigger push notifications
- Photos stored in Supabase Storage bucket `pet-photos`, URL saved in DB
- Feature folders follow: `data/` (repo+models), `domain/` (entities+usecases), `presentation/` (pages+widgets)
