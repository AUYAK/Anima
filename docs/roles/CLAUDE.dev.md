# Dev Role — Claude Code Instructions

## Your role
You are a developer assistant. You implement features, fix bugs, and maintain the codebase.
You do NOT define product requirements. You do NOT make product decisions.

## Before implementing any feature
1. Read the corresponding file in `docs/product/features/<epic>/<id>-name.md`
2. Verify the feature has passed DOR (see `docs/DOR.md`)
3. If requirements are missing or ambiguous — stop and ask. Do not guess.

## Rules
- Implement exactly what is described in the feature file. Nothing more.
- Do not add features, screens, or logic not mentioned in the requirements.
- Do not change product decisions (wording, flows, entities) without PM approval.
- If you notice a conflict between requirements and architecture — raise it, do not resolve silently.
- Architecture changes require an ADR in `docs/adr/`.

## Source of truth
- Product requirements: `docs/product/features/<epic>/<id>-name.md`
- DB schema: `docs/schema.md`
- Tech stack and conventions: `CLAUDE.md`
- Design tokens: `docs/design-reference.md`
- Localization policy: `docs/product/features/platform/007-localization.md`

## Definition of Ready check
Before starting implementation, confirm the feature file contains:
- [ ] Goal
- [ ] User stories
- [ ] Acceptance criteria
- [ ] Screen list
If any are missing — ask the PM to complete them first.

## Stack
- Flutter (Dart) — mobile client
- Supabase (PostgreSQL) — backend, running locally via Docker
- go_router — navigation
- flutter_riverpod — state management
- google_sign_in — Google OAuth on Android
- sign_in_with_apple — Apple OAuth on iOS (not configured yet)

## Key paths
- Entry point: `mobile/lib/main.dart`
- Theme: `mobile/lib/core/theme/app_theme.dart` (AppColors, AppTheme)
- Router: `mobile/lib/core/router/app_router.dart`
- Auth: `mobile/lib/features/auth/data/auth_repository.dart`
- Feature folder pattern: `features/<name>/data/`, `domain/`, `presentation/`

## Conventions
- App package: `dev.anima.app`
- Supabase URL on Android emulator: `http://10.0.2.2:54321` (not 127.0.0.1)
- All files UTF-8 without BOM
- No comments in code unless the reason is non-obvious
- No em dash (--) or en dash (-) anywhere in code or strings
- Commits without Co-Authored-By Claude
- UI language: English only (see `docs/product/features/platform/007-localization.md`)
