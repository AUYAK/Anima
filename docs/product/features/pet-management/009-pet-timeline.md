# Feature: Pet Timeline
Status: Ready

## Goal
The pet's life as one continuous vertical road — history below, plans above, anchored on today — rendered as the default tab of the pet profile.

## User Stories
- As a pet owner, I want to scroll through my pet's history as one continuous story so that I can relive our journey.
- As a pet owner, I want upcoming and suggested activities on the same road as history so that planning and remembering live in one place.
- As a pet owner, I want the app to add milestone entries automatically (birthday, "one year together") so that special dates are part of the story even if I forget to log them.

---

## Core principles

**Gallery is the archive. Timeline is the story.** Only deliberate entries appear here: moments, activities, milestones. Photos uploaded directly to the gallery never appear on the timeline.

**One continuous road, no blocks.** A single vertical line runs the full length of the feed; every entry is a node attached to it. No card sections, no zone headers — visually one uninterrupted path from the first day ("Joined Anima", the very bottom) through today and into planned future. Whether the future part is empty or full, the road reads as one element.

**Every node is tappable.**

---

## Node types

| Node | Visual | Zone | Tap action |
|---|---|---|---|
| Placeholder | ◌ dashed outline | Future | Opens planning flow (003) |
| Planned activity | ○ outline, date/time | Future | Activity details / edit (003) |
| Completed activity | ✓ filled, report attached | Past | Activity details with report (003) |
| Moment | ● photo thumbnail | Past | Full-screen photo viewer |
| Milestone | ★ accent icon | Past | Bottom sheet with details |

### Activity lifecycle (the key loop)

```
◌ placeholder            ○ planned              ✓ completed
"Time to plan            "Vet visit             "Vet visit · done,
 a vet visit"      →      Jul 15, 14:00"   →     report attached"
 (care rule fires)        (user set details)     (user marked done,
                                                  moves into history)
```

A node never disappears — it changes state and travels down the road into history.

**Placeholders** come from recurring care rules (defined with feature 003), e.g. "vet visit yearly": if no vet activity in the last 12 months and none planned → a placeholder node appears in the future part. If nothing is due and nothing is planned, the future part is simply empty — the road starts at today.

---

## Screen anatomy

```
      ╎                              <- road continues up as plans grow
      ◌  Time to plan a vet visit    <- placeholder (dashed)
      ╎
      ○  Vaccine · Jul 15, 14:00     <- planned (outline)
      ╎
   ── today ──                       <- opens here
      │
      ●  [photo] Walk · "First snow" <- moment
      │
      ✓  Vet visit · Jul 2           <- completed activity
      │        June 2026             <- month label along the road
      ★  1 year together             <- milestone (accent)
      │
      ●  ...
      │
      🏠 Joined Anima                <- start of the journey, end of road
```

- Opens anchored on "today"; scroll down = history, scroll up = future
- Future part: planned activities and placeholders, nearest to today closest to the marker; dashed road segment above today
- Past part: reverse chronological; solid road segment
- Month labels along the road (small, muted — not section headers)
- "Joined Anima" milestone is always the oldest node
- 2+ moments on the same day: stacked node with "+N" badge; tap expands into individual nodes inline

---

## Acceptance Criteria

### Road
- [ ] Single continuous vertical line the full length of the feed; every entry is a node on it
- [ ] Opens with the "today" marker visible without scrolling
- [ ] Future part above today (dashed segment), history below (solid segment)
- [ ] Empty future: road starts at today — no placeholder block, no gap
- [ ] "Joined Anima" is always the last (oldest) node
- [ ] Month labels rendered along the road, not as separating blocks

### Nodes
- [ ] Moments render as photo nodes with tag + caption + time
- [ ] Milestones render as accent nodes, visually distinct
- [ ] 2+ moments on one day collapse into a stacked node "+N"; tap expands inline
- [ ] Every node is tappable: moment → full-screen viewer, milestone → bottom sheet
- [ ] Gallery-only photos do NOT appear on the timeline

### Milestones
- [ ] Birthday milestone yearly from DOB (skipped if DOB not set)
- [ ] Anniversary milestone yearly from pet created_at
- [ ] No milestones dated before the pet joined the app

### Activities (Phase 2, with 003)
- [ ] Placeholder node appears when a care rule is due and nothing is planned
- [ ] Placeholder tap → planning flow; planned node shows date/time
- [ ] Completing an activity moves its node below today with report attached
- [ ] Planned/completed/placeholder nodes tappable → details

---

## Screens
- No separate screen: the timeline renders inside the Timeline tab of PetProfileScreen (feature 011)
- Full-screen photo viewer (shared with gallery) opens from moment nodes

## Navigation
- PetProfileScreen → Timeline tab (default) → the road
- Moment node tap → photo viewer → back to the road
- Placeholder / planned / completed node tap → activity flow (003, Phase 2)

## Empty / Error States
- Empty (no entries at all): the road still renders with two nodes — "today" marker and "Joined Anima" — plus a hint "Grom's story starts here. Add a moment." (＋ flow, 012)
- Load error: "Couldn't load the timeline" + Retry

---

## Phasing

**Phase 1 (now, after 012):** the road inside the Timeline tab — moments + auto-milestones + today marker. No future part yet (003 doesn't exist): road starts at today.

**Phase 2 (with 003):** future part — placeholders from care rules, planned activities, activity lifecycle (placeholder → planned → completed with report). The 003 spec must define: activity states, care rules, planning flow, completion flow with attachments.

**Phase 3 (with 013):** "Title unlocked" milestone nodes.

---

## Impact on existing specs
- Feature 011: timeline is the default profile tab; the previous "timeline strip" section is gone
- Feature 003 (when specced): must define recurring care rules and the placeholder → planned → completed lifecycle used here
- Replaces the "biography tab" concept from 001-pet-profile.md

## Dependencies
- Feature 012 (Moments) — main content source; build after 012
- Feature 003 (Event Calendar / Activities) — future part (Phase 2)
- Feature 013 (Achievements) — title milestones (Phase 3)

## Out of Scope
- Gallery photos on the timeline (gallery = archive, timeline = story)
- "Convert a gallery photo into a moment" bridge (future iteration)
- Editing or deleting entries from the timeline
- Filters (revisit after Phase 2 if the road gets noisy)
- Comments, reactions, social feed
- Rich road visuals (curves, illustrations, themed segments — future design pass; v1 is a clean straight vertical road)
