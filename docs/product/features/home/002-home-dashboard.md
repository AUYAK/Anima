# Feature: Home Feed
Status: Ready

## Goal
Home shows the life of all the user's pets as one card feed of moments, with the pets topbar for jumping to any pet's profile.

## User Stories
- As a user, I want to open the app and immediately see the latest moments of my pets so that Home feels alive, not like a menu.
- As a user, I want to see all my pets in the topbar so that I can jump to any of them quickly.
- As a new user with no content, I want Home to tell me what to do first.

---

## Topbar (shipped in v1 — unchanged)

Horizontally scrollable row of the user's pet avatars.
- Circular photo (or paw icon placeholder), pet name below
- Sorted by most recently updated, most recent on the left
- Tap avatar → that pet's profile
- No pets: single placeholder avatar "Add your first pet" → Add Pet screen
- Sits at the very top; HomeScreen has no AppBar

## Feed (v2 — this spec)

Below the topbar: a vertical feed of moment cards from **all** the user's pets, newest first (by taken_at).

**Moment card:**
```
┌─────────────────────────────┐
│ (🐕) Grom · 2h ago          │   <- pet avatar (small) + name + relative time
│ ┌─────────────────────────┐ │
│ │                         │ │
│ │        [PHOTO]          │ │   <- rounded, full card width
│ │                         │ │
│ └─────────────────────────┘ │
│ 🐾 Walk                     │   <- tag chip
│ "First snow this year!"     │   <- caption, if any
└─────────────────────────────┘
```

- Tap card → full-screen photo viewer (shared with gallery/road)
- Pull-to-refresh
- Lazy loading as the user scrolls
- Relative time: "2h ago", "yesterday", then date

The card format is deliberately universal: the same card will later carry friends' moments and discovery posts without redesign (see Future).

---

## Acceptance Criteria

### Topbar (regression — must keep working)
- [ ] All pets shown as avatar row, sorted by most recently updated
- [ ] Avatar tap → pet profile; no-pets placeholder → Add Pet

### Feed
- [ ] Moments of all the user's pets shown as cards, newest first
- [ ] Card shows pet avatar + name + relative time, photo, tag, caption (if any)
- [ ] Card tap opens full-screen photo viewer
- [ ] Pull-to-refresh reloads the feed
- [ ] Feed paginates (no full-table load)
- [ ] New moment saved via ＋ appears in the feed on return

### Empty / Error
- [ ] Has pets, no moments: illustration + "Save your first moment" hint pointing at the ＋ tab
- [ ] No pets: topbar placeholder + body prompt to add a pet (existing behavior)
- [ ] Load failure: "Couldn't load the feed" + Retry

---

## Screens
- HomeScreen — topbar + feed (no new screens; full-screen viewer is shared)

## Navigation
- Login → HomeScreen
- Avatar tap → PetProfileScreen
- Card tap → photo viewer → back
- Bottom nav Home tab → HomeScreen

## Simplicity check (principles.md)
1. One job: Home shows what's happening; one primary action — scroll
2. Nothing asked of the user at all
3. Content over chrome: photos are the screen
4. Depth opt-in: viewer and pet profiles behind one tap
5. No new surfaces: fills the existing empty Home body

## Future (recorded, not specced)
- v2 social: friends' moments in the same feed, same card + owner name (requires accounts linking, privacy flag on moments, moderation)
- v3 discovery: posts from strangers with the same breed between friend posts — solves social cold start; breed is a natural community axis
- Notification badges on topbar avatars (needs push infrastructure)

## Out of Scope
- Likes, comments, sharing
- Friends / discovery content (see Future)
- Filtering the feed by pet (tap the pet's avatar for their road instead)
- "Due today" activities strip on Home (revisit with 003)
- Onboarding flow
