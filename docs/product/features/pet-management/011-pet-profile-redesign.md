# Feature: Pet Profile Redesign
Status: Ready

## Goal
Transform the pet profile from a data form into a living, emotional profile that shows the pet's story at a glance.

## Structure
Single scrollable page. No tabs. Each section has a "see all" link that opens a dedicated full-screen view.

```
┌─────────────────────────────┐
│   [hero photo - full width] │
│   Name · Species            │  <- overlay on photo
│   Age · Together X years    │
├─────────────────────────────┤
│  Health snapshot (3 cards)  │
├─────────────────────────────┤
│  Photos  ──────────── all → │
│  [ ] [ ] [ ] [ ] [ ] [ ]    │
├─────────────────────────────┤
│  Timeline ─────────── all → │
│  · March — vet visit         │
│  · January — birthday        │
├─────────────────────────────┤
│  Breed · Gender · Weight     │  <- info, below fold
│  Additional info             │
└─────────────────────────────┘
```

---

## Section: Hero header

- Full-width photo of the pet (or large paw icon placeholder if no photo)
- Gradient overlay at the bottom of the photo
- On top of gradient: pet name (large), species (small, muted)
- Below photo: two stats inline
  - Age: "4 years 2 months"
  - Time together: "With you for 3 years 8 months" (calculated from pet created_at)
- Pencil icon (edit mode) in top-right corner of the header
- Back arrow top-left

---

## Section: Health snapshot

Three compact cards in a horizontal row:

| Card | Content | Color logic |
|---|---|---|
| Next event | Title + days remaining | Green if >30d, Yellow if 7-30d, Red if <7d or overdue |
| Last vet visit | X months ago | Green if <6mo, Yellow if 6-12mo, Red if >12mo |
| Weight trend | +/- X kg vs previous | Neutral; no color logic |

If no events exist yet: cards show placeholder state "No events yet" with a subtle "Add" link.
Dev: Health snapshot depends on Event Calendar (003). For now show placeholder cards with static text.

---

## Section: Photos

- Title "Photos" with "See all →" link on the right
- Grid of 6 most recent photos (2 rows of 3)
- Tapping "See all →" opens the full Gallery screen (feature 004)
- Tapping a photo opens it full-screen
- Empty state: single placeholder cell with "+" icon; tapping opens camera/gallery picker

---

## Section: Timeline

- Title "Timeline" with "See all →" link on the right
- Last 3 events from the pet's timeline, most recent first
- Each entry: icon + event title + date
- Tapping "See all →" opens the full Timeline screen (feature 009)
- Dev: Timeline section depends on Pet Timeline (009). For now show placeholder: "No history yet. Start by adding an event."

---

## Section: Info

- Displayed below the fold (user scrolls to see it)
- Fields shown only if filled in: Breed, Gender, Date of birth, Weight, Additional info
- Empty fields hidden (same rule as current spec)
- No edit controls here; editing done via pencil icon in header

---

## Acceptance Criteria

### Hero
- [ ] Full-width hero photo with gradient overlay
- [ ] Pet name and species displayed on photo
- [ ] Age shown as "X years Y months" or "X months" for young animals
- [ ] Time together shown as "With you for X years Y months"
- [ ] Next birthday shown if date of birth is set: "Birthday in X days" (hidden if DOB not set)
- [ ] Pencil icon in top-right opens edit mode (feature 010)

### Health snapshot
- [ ] Three cards visible: Next event, Last vet visit, Weight trend
- [ ] Color coding applied per rules above
- [ ] Placeholder state shown if no data exists

### Photos
- [ ] 6 most recent photos shown in a 2x3 grid
- [ ] "See all" navigates to full Gallery screen
- [ ] Empty state shows "+" cell

### Timeline
- [ ] Last 3 events shown
- [ ] "See all" navigates to full Timeline screen
- [ ] Placeholder shown if no events exist

### Info
- [ ] Info section visible below fold
- [ ] Only filled fields are shown

---

## Navigation
- PetListScreen tap → PetProfileScreen (this redesigned screen)
- PetProfileScreen pencil → edit mode (feature 010)
- PetProfileScreen Photos "See all" → GalleryScreen (feature 004)
- PetProfileScreen Timeline "See all" → TimelineScreen (feature 009)
- PetProfileScreen back → PetListScreen

## Impact on existing specs
- Replaces the three-tab structure (General Info / Gallery / Timeline) defined in 001-pet-profile.md
- Gallery and Timeline become full-screen views accessed from this profile, not tabs
- Feature 004 (Photo Gallery) and 009 (Pet Timeline) specs remain valid as full-screen views

## Out of Scope
- Breed-specific health insights (future -- requires breed intelligence layer)
- Personality tags (future iteration)
- Health score / overall rating
- Sharing the profile externally (part of social feature in ideas.md)
