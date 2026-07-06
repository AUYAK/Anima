# Feature: Pet Profile Redesign
Status: Ready

## Goal
Transform the pet profile from a data form into a living, emotional profile: the pet's life timeline front and center, reference info one tab away.

## User Stories
- As a pet owner, I want to open my pet's profile and immediately see their life story and what's coming up so that the profile feels alive, not like a form.
- As a pet owner, I want reference info (breed, weight, documents) available but out of the way so that it doesn't clutter the story.
- As a new user with no data yet, I want clear placeholder states so that I know how to start filling the profile.

## Structure
Collapsing hero on top, then two tabs: **Timeline** (default) and **Info**. No section blocks — the timeline IS the profile.

```
┌─────────────────────────────┐
│   [hero photo - 300dp]      │  <- collapses into a compact
│   Name · Species            │     bar on scroll
│   Age · Together · Birthday │
├─────────────────────────────┤
│   Timeline    |    Info     │  <- tabs, Timeline default
├─────────────────────────────┤
│                             │
│   (tab content)             │
│                             │
└─────────────────────────────┘
```

---

## Hero header (above tabs)

- Full-width photo, 300dp expanded (or large paw icon placeholder if no photo)
- Gradient overlay at the bottom; on top of it: pet name (large), species (small, muted)
- Below photo: age ("4 years 2 months"), time together ("With you for 3 years 8 months", from pet created_at), next birthday if DOB set ("Birthday in X days", shown when ≤60 days)
- No streak counter here: consistency lives in Achievements (013) as quest progress
- **Collapsing behavior**: on scroll, hero collapses into a compact app bar — pet name + back arrow + pencil remain visible; expands back when scrolling to top
- Back arrow top-left; pencil top-right → edit mode (feature 010): switches to the Info tab with fields editable, hero stays visible

---

## Tab: Timeline (default)

The pet's life as one continuous vertical road — history below, plans above, anchored on today. Full spec: feature 009. This tab has no blocks or sections of its own — it renders the 009 road and nothing else.

---

## Tab: Info

Top to bottom:

**Photos** (first section)
- Title "Photos" with "See all →" link opening the full Gallery screen (feature 004)
- Grid of 6 most recent photos (2 rows of 3), moments' photos included
- Tapping a photo opens it full-screen
- Empty state: single placeholder cell with "+" icon; tapping opens camera/gallery picker

**Details**
- Fields shown only if filled: Breed, Gender, Date of birth, Weight, Additional info
- Empty fields hidden
- No inline edit controls; editing via pencil in hero (feature 010)

**Lifecycle actions** (bottom of scroll)
- "Passed away" and "Remove pet" buttons per feature 008

---

## Acceptance Criteria

### Hero
- [ ] Full-width hero photo with gradient overlay, name and species on photo
- [ ] Age as "X years Y months" ("X months" for young animals)
- [ ] Time together as "With you for X years Y months"
- [ ] Next birthday shown when DOB set and ≤60 days away
- [ ] No streak counter in the hero
- [ ] Hero collapses to compact bar on scroll; name, back, pencil stay visible
- [ ] Pencil opens edit mode on the Info tab (feature 010)

### Tabs
- [ ] Two tabs: Timeline and Info; Timeline is the default on open
- [ ] Switching tabs preserves scroll position of each tab while on the screen

### Timeline tab
- [ ] Renders the continuous road per feature 009 (AC live there)

### Info tab
- [ ] Photos grid: 6 most recent (moments included), "See all" → Gallery, empty state with "+"
- [ ] Only filled detail fields shown
- [ ] Lifecycle buttons at the bottom of the scroll

---

## Navigation
- PetListScreen tap → PetProfileScreen (Timeline tab)
- Pencil → edit mode on Info tab (feature 010)
- Info tab Photos "See all" → GalleryScreen (feature 004)
- Timeline node taps → per feature 009
- PetProfileScreen back → PetListScreen

## Impact on existing specs
- Replaces the single-scroll section layout from the previous version of this spec: health snapshot cards are removed (upcoming events and vet history are visible on the timeline road; weight trend moves to Growth Tracking 005); the photos strip moves into the Info tab; the timeline strip is gone — the timeline is now a full tab
- Feature 009 timeline renders as a tab here, not a separate screen
- Feature 010 edit mode applies to the Info tab fields
- Feature 008 lifecycle buttons live at the bottom of the Info tab

## Out of Scope
- Breed-specific health insights (future — requires breed intelligence layer)
- Personality tags (future iteration)
- Health score / overall rating
- Sharing the profile externally (part of social feature in ideas.md)
