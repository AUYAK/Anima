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

| Tag | Icon | Examples |
|---|---|---|
| Прогулка | 🐾 | Morning walk, park visit |
| Игра | 🎾 | Fetch, tug of war, indoor play |
| Еда | 🍖 | Meal, treat, new food |
| Сон | 💤 | Nap, sleeping spot |
| Уход | ✂️ | Grooming, bath, nail trim |
| Ветеринар | 🏥 | Clinic visit, checkup |
| Тренировка | 🎓 | Training session, learned a trick |
| Просто так | 📸 | Any other cute moment |

---

## Add Moment flow

Entry point: center tab bar button (＋) — accessible from any screen.

**Step 1 — Camera / Gallery picker**
Opens immediately on tap. Full-screen camera view with:
- Shutter button (take photo)
- Gallery button (choose from device)
- Recent pet photos strip at bottom (quick reuse)
- × to cancel

**Step 2 — Compose screen**
After photo is selected:
- Photo preview (full width, square crop with drag-to-reposition)
- Caption field: "Что происходит?" — placeholder, optional, multiline
- Activity tag row: horizontal scroll of tag chips, one required
- Pet selector: shows all pets as small avatars, tap to assign — defaults to most recently active
- Timestamp: shows "Сейчас", tap to adjust (date picker)
- Publish button: "Сохранить момент"

**Step 3 — Success**
- Toast: "Момент сохранён 🐾"
- If this moment triggers a streak milestone: full-screen achievement celebration appears (see feature 013)
- Returns to screen the user came from

---

## Where Moments appear
- Pet Profile → Photos section (counts toward photo grid)
- Pet Profile → Timeline section (appears as timeline entry with tag icon)
- Future: social feed (when social is built)

---

## Streak tracking
The system tracks consecutive days with at least one Moment per pet.
- Day counter resets at midnight (device timezone)
- A day counts if ≥1 Moment saved for that pet on that calendar day
- Streak visible on pet profile: "🔥 14 дней подряд"
- Achievement system checks against streak milestones (see feature 013)

---

## Acceptance Criteria

### Navigation
- [ ] Center tab bar shows ＋ icon, accessible from all main screens
- [ ] Tapping ＋ opens camera immediately (no intermediate screen)

### Compose
- [ ] Photo required — cannot save without photo
- [ ] Activity tag required — cannot save without selecting one
- [ ] Caption optional
- [ ] Pet selector defaults to most recently active pet
- [ ] Timestamp defaults to current time, editable via date picker
- [ ] "Сохранить момент" commits the moment

### Post-save
- [ ] Moment appears in pet's Photos section immediately
- [ ] Moment appears in pet's Timeline section
- [ ] Toast "Момент сохранён" shown
- [ ] Achievement check fires after save (see feature 013)

### Streak
- [ ] Current streak count visible on pet profile under hero section
- [ ] Streak shows "🔥 N дней подряд"
- [ ] Streak resets if no moment saved on a calendar day

### Empty / Error
- [ ] Photo upload failure: toast "Не удалось загрузить фото. Попробуй ещё раз."
- [ ] Save failure: screen stays on compose, error toast shown
- [ ] If user taps × on compose with filled content: "Отменить момент?" dialog with Да / Продолжить

---

## Navigation
- Any screen ＋ tap → Camera (full screen)
- Camera photo selected → Compose screen
- Compose "Сохранить" → back to previous screen + toast
- Compose × → dialog → back to previous screen

## Out of Scope
- Video support
- Multiple photos per moment
- Editing a moment after save (future)
- Deleting a moment (future — via gallery)
- Public feed / sharing (future social feature)
- Location tagging
