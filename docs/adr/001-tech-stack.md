# ADR-001: Tech Stack Selection

**Date**: 2026-06-24
**Status**: Accepted

## Context

Building a cross-platform mobile app (iOS + Android) for pet care management.
Constraints: Windows 11 dev machine, existing PostgreSQL, no dedicated server yet.

## Decision

### Mobile: Flutter (Dart)
- Single codebase for iOS + Android
- Excellent UI toolkit for visual consumer apps (photos, animations, calendars)
- Strong development tooling on Windows
- Good offline-first capabilities

### Backend: Supabase (local via Docker Compose)
- Runs on PostgreSQL - matches existing DB constraint
- Provides auth, file storage, REST + Realtime APIs out of the box
- No custom backend code needed for MVP
- Local dev with `supabase start`; migrate to Supabase Cloud or self-hosted later

### Architecture: Feature-first with Clean Architecture layers
Each feature folder contains: `data/`, `domain/`, `presentation/`
Keeps features self-contained and testable independently.

## Consequences

- iOS builds require macOS (use GitHub Actions macOS runner or Codemagic CI)
- Supabase local needs Docker installed
- Dart learning curve if team is JS-heavy (mitigated by Flutter docs quality)
