# Feature: Moments
Status: Ready

## Goal
Give users a fast way to log daily life with their pet — a photo, optional text, and an activity tag. Moments feed the pet's timeline, the gallery, and the achievement streak system.

## User Stories
- As a pet owner, I want to quickly capture a photo and tag it so that I can log a moment without interrupting my time with my pet.
- As a pet owner, I want to see my daily streak so that I feel motivated to log something every day.
- As a pet owner with multiple pets, I want to assign a moment to the right pet so that each pet's history stays separate.

## What is a Moment
A Moment is the atomic unit of pet content in Anima:
- Photo (required)
- Caption (optional, free text)
- Activity tag (required, choose one)
- Pet (required, defaults to most recently active)
- Timestamp (auto, current time — editable)
- Privacy: private by default

A Moment is NOT an event (no reminder, no date scheduling). It's a record of something that just happened or is happening now.

---

## Activity tags

| Key | Label (EN) | Label (RU) | Icon | Examples |
|---|---|---|---|---|
| walk | Walk | Прогулка | 🐾 | Morning walk, park visit |
| play | Play | Игра | 🎾 | Fetch, tug of war, indoor play |
| food | Food | Еда | 🍖 | Meal, treat, new food |
| sleep | Sleep | Сон | 💤 | Nap, sleeping spot |
| care | Care | Уход | ✂️ | Grooming, bath, nail trim |
| vet | Vet | Ветеринар | 🏥 | Clinic visit, checkup |
| training | Training | Тренировка | 🎓 | Training session, learned a trick |
| other | Just because | Просто так | 📸 | Any other cute moment |

UI shows English labels (per 007 conventions); RU labels reserved for future localization. `key` is the stored value. No tag is pre-selected — the user must actively choose one.

---

## Add Moment flow

Entry point: center tab bar button (＋) — accessible from any screen.

**Step 1 — Camera / Gallery picker**
Tapping ＋ opens the system camera immediately (no intermediate screen).
- Behind it: a minimal fallback screen with "Choose from gallery" and × to cancel
- Cancelling the camera lands the user on the fallback screen
- Custom in-app camera and recent-photos strip: out of scope for v1

**Step 2 — Compose screen**
After photo is selected:
- Photo preview (full width, as taken — grids crop to square at display time)
- Caption field: "What's happening?" — placeholder, optional, multiline
- Activity tag row: horizontal scroll of tag chips, one required, none pre-selected
- Pet selector: shows all pets as small avatars, tap to assign — defaults to the pet currently selected in the home topbar
- Timestamp: shows "Now", tap to adjust (date picker, no future dates)
- Publish button: "Save moment"
- × top-left: if anything is filled in, "Discard moment?" dialog (Discard / Keep editing)

**Step 3 — Success**
- Toast: "Moment saved 🐾"
- If this moment triggers a streak milestone: full-screen achievement celebration appears (see feature 013)
- Returns to screen the user came from

---

## Where Moments appear
- Pet Profile → Photos section (counts toward photo grid)
- Pet Profile → Timeline section (appears as timeline entry with tag icon)
- Future: social feed (when social is built)

---

## Streak tracking (internal)
The system tracks consecutive days with at least one Moment per pet — as an input for achievement quests (013), not as a visible counter.
- Day counter resets at midnight (device timezone)
- A day counts if ≥1 Moment saved for that pet on that calendar day
- NOT displayed on the pet profile or anywhere as a standalone counter — consistency surfaces only as quest progress on the Achievements screen (013)
- Achievement system checks against streak milestones (see feature 013)

---

## Acceptance Criteria

### Navigation
- [ ] Center tab bar shows ＋ icon, accessible from all main screens
- [ ] Tapping ＋ opens camera immediately (no intermediate screen)

### Compose
- [ ] Photo required — cannot save without photo
- [ ] Activity tag required — no tag pre-selected; save blocked until one is chosen
- [ ] Caption optional, placeholder "What's happening?"
- [ ] Pet selector defaults to the pet currently selected in the home topbar
- [ ] Timestamp defaults to current time, editable via date picker (no future dates)
- [ ] "Save moment" commits the moment
- [ ] All UI strings in English (per 007 conventions)

### Post-save
- [ ] Moment appears in pet's Photos section immediately
- [ ] Moment appears in pet's Timeline section
- [ ] Toast "Moment saved 🐾" shown
- [ ] Achievement check fires after save (see feature 013)

### Streak (internal)
- [ ] No streak counter rendered anywhere in the UI
- [ ] Streak computed per pet: consecutive calendar days with ≥1 moment
- [ ] Streak resets if no moment saved on a calendar day

### Empty / Error
- [ ] Photo upload failure: toast "Couldn't upload the photo. Try again."
- [ ] Save failure: screen stays on compose, error toast shown
- [ ] If user taps × on compose with filled content: "Discard moment?" dialog with Discard / Keep editing
- [ ] User has no pets: tapping ＋ shows "Add a pet first" and opens the Add Pet screen

---

## Navigation
- Any screen ＋ tap → Camera (full screen)
- Camera photo selected → Compose screen
- Compose "Сохранить" → back to previous screen + toast
- Compose × → dialog → back to previous screen

## Out of Scope
- Custom in-app camera UI + recent-photos strip (v1 uses system camera)
- Square crop / drag-to-reposition (grids crop at display time)
- Video support
- Multiple photos per moment
- Editing a moment after save (future)
- Deleting a moment (future — via gallery)
- Public feed / sharing (future social feature)
- Location tagging
