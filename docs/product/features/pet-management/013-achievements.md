# Feature: Achievements & Titles
Status: Ready

## Goal
Reward users for real care and consistency with a WoW-style achievement system: accumulating points, unlocking titles, and displaying one chosen title on their profile.

## Core concepts

**Очки достижений (Achievement Points)**
Every achievement has a point value. Points accumulate into a global score shown on the user's profile. This is a permanent, ever-growing number — never resets.

**Достижения (Achievements)**
Discrete milestones across 5 categories. Each has: name, description, icon, point value, unlock condition, progress tracking where applicable.

**Линейки (Chains)**
Achievements that measure the same metric form a chain and unlock strictly in sequence (7 → 30 → 100 → 365 days). A chain renders as ONE row on the Achievements screen: earned tiers checked with dates, current tier with progress, future tiers grayed. Tiers have no individual names, but each chain has ONE description line (shown once, in the chain's detail sheet) explaining what it tracks — a tier is labeled by its value + unit ("30 days", "50 moments"), never a bare "Tier: N". Most achievements live in chains; conditions that don't scale stay as singles.

**Realism rule:** every tier must be reachable through active, ongoing use within a plausible timeframe — not pure calendar waiting. Milestones measuring elapsed time (not user effort) are capped at 1 year; anything beyond that is not a believable "achievement" for an app this young and reads as demotivating rather than aspirational. Effort-based chains (streaks, moments, visits, courses) can go further because they reward sustained active behavior, not passive time.

**Звания (Titles)**
Special achievements that grant a displayable title. User can earn many titles but shows only one at a time — chosen from their collection. Title appears under the user's name on their profile.

**Scope: per-user, not per-pet.** Achievements, points, and titles belong to the user, not to an individual pet — consistent with points/title living on the user profile (see Profile integration below). For metrics based on pet data (time together, moments, streaks), the tracked value is the **max across all the user's pets** for that metric — e.g. "days together" progresses using whichever pet has been in Anima longest. Chain descriptions must stay pet-agnostic ("Дней в Anima", not "...с {pet}") since the leading pet can differ per metric and per user. A per-pet achievement breakdown is a possible future feature, not this one.

---

## Achievement categories

### 🐾 Вместе (Together)
**Chain — время с питомцем** (from pet created_at). Capped at 1 year per the realism rule above — elapsed-time tiers beyond that aren't a real achievement yet for an app this young; revisit once we have users who've stayed 2+ years.

Description (shown once in the chain sheet): "Дней в Anima"

| Tier | Points | Title |
|---|---|---|
| 1 день | 10 | — |
| 7 дней | 15 | — |
| 30 дней | 25 | — |
| 90 дней | 40 | — |
| 180 дней | 60 | — |
| 365 дней | 100 | «Ветеран» |

### 📸 Летописец (Memory)
**Chain — моментов сохранено.** Description: "Моментов сохранено"

| Tier | Points | Title |
|---|---|---|
| 1 | 10 | — |
| 10 | 20 | — |
| 50 | 50 | — |
| 200 | 100 | «Летописец» |

### 🔥 Постоянство (Streaks)
**Chain — дней подряд** (≥1 moment per calendar day, max across pets). Description: "Дней подряд с моментом"

| Tier | Points | Title |
|---|---|---|
| 7 | 25 | — |
| 30 | 75 | «Постоянный» |
| 100 | 150 | «Верный хозяин» |
| 365 | 500 | «Легенда» |

**Single:**
| Achievement | Condition | Points | Title |
|---|---|---|---|
| Инфлюенсер | 30 дней подряд с тегом «Прогулка» | 75 | «Инфлюенсер» |

### 💉 Забота (Health)
**Chain — записанных вет-визитов.** Description: "Визитов к ветеринару записано"

| Tier | Points | Title |
|---|---|---|
| 1 | 15 | — |
| 3 | 30 | — |
| 10 | 75 | — |

**Singles:**
| Achievement | Condition | Points | Title |
|---|---|---|---|
| Образцовый хозяин | Полная история прививок (3+) | 75 | «Образцовый хозяин» |
| На контроле | Визит к вету каждые 12 месяцев (2 года подряд) | 100 | — |

### 🎓 Знания (Learning)
**Chain — курсов завершено.** Description: "Курсов завершено"

| Tier | Points | Title |
|---|---|---|
| 1 | 20 | — |
| 3 | 50 | — |
| 10 | 150 | «Мастер ухода» |

---

## Titles (Звания)

Titles appear under the username on the profile: "Алексей · *Инфлюенсер*"

| Title | How to unlock |
|---|---|
| Постоянный | 30-дневный streak |
| Верный хозяин | 100-дневный streak |
| Инфлюенсер | 30 дней подряд с тегом «Прогулка» |
| Легенда | 365-дневный streak |
| Образцовый хозяин | Полная история прививок |
| Летописец | 200 моментов загружено |
| Ветеран | 1 год с питомцем в Anima |
| Мастер ухода | Завершил 10 курсов |
| ⭐ Любимчик редакции | Мета-ачивка: закрыть все 5 категорий |

Default title: none (field empty until first title unlocked).

---

## Achievement unlock flow

When an achievement is unlocked — immediately after the triggering action.

**Multi-tier rule:** if several tiers of one chain unlock at once (e.g. "Вместе" computed on app update), celebrate only the highest tier; lower tiers are granted silently with their dates.

**Minor achievement (< 100 points)**
Toast-style notification from top: icon + name + "+25 очков" — 3 seconds, tappable to open full achievement screen.

**Major achievement / Title unlock**
Full-screen celebration modal:
- Dark background (same as AI reveal screen — this is a ceremonial moment)
- Achievement icon large, animated (scale in)
- Achievement name in large text
- Point value: "+100 очков"
- If title unlocked: "Новое звание разблокировано: «Верный хозяин»" + option to equip immediately
- CTA: "Отлично!" dismisses

---

## Profile integration

On the user profile screen:

**Achievement score**: visible prominently, e.g. "1 240 очков"
**Active title**: shown under name — tappable to change
**Achievement progress card**: shows total unlocked / total available, progress bar, "Открыть →" to full screen

**Achievements screen** (from Profile):
- Summary: total points + unlocked count
- **Chain rows** — one row per chain: icon + chain name + tier track on a single line
  - Earned tiers: filled, checkmark
  - Current tier: progress "45/100" in amber
  - Future tiers: grayed
  - Tap → bottom sheet: chain description at the top, then every tier labeled by value + unit ("30 days", not "Tier: 30") with points, earned date ("30 days — unlocked Jul 3"), attached title if any, and current progress toward the next tier
- **Single achievements** — icon + name + description + points + status (unlocked with date / in progress with bar / locked gray)
- Tiers and singles that grant a title show a crown icon; equipped title shows a badge
- Filter chips: Все | Вместе | Летописец | Постоянство | Забота | Знания

**Titles screen** (from Profile → "Моё звание"):
- Grid of unlocked titles as cards
- Active title has checkmark / highlighted border
- Tap any to equip immediately
- Locked titles shown grayed with "Как получить →"

---

## Pet profile integration

None. Consistency is a quest condition, not a counter: streak progress lives on the Achievements screen as an in-progress item with a progress bar ("Месяц без пропуска: 18/30"), WoW-style. No permanent streak counter anywhere on the pet profile — a naked day counter is a guilt mechanic and off-brand.

---

## Acceptance Criteria

### Unlock
- [ ] Achievement fires immediately after qualifying action
- [ ] Minor toast shown for < 100 point achievements
- [ ] Full-screen modal for major achievements and title unlocks
- [ ] Modal has "Надеть звание" option if title unlocked
- [ ] Points added to profile total immediately

### Profile
- [ ] Total achievement points visible on profile
- [ ] Active title shown under username (empty if none chosen)
- [ ] Achievement card shows progress toward next unlock
- [ ] Tap card opens full achievements screen

### Achievements screen
- [ ] Chains render as one row: earned tiers checked, current tier shows progress "N/M", future tiers grayed
- [ ] Chain detail sheet shows the chain's one-line description at the top
- [ ] Every tier is labeled by value + unit (e.g. "30 days", "50 moments") — never a bare "Tier: N"
- [ ] Chain tap opens detail sheet: per-tier points, earned dates, current progress
- [ ] Tiers unlock strictly in sequence; several at once → only highest celebrated
- [ ] Single achievements show status: unlocked with date / progress bar / locked gray
- [ ] All 5 category filters work
- [ ] No chain has an elapsed-time tier beyond 1 year

### Titles screen
- [ ] All unlocked titles shown as selectable cards
- [ ] Only one active at a time
- [ ] Equip updates profile immediately

### Streak (via Moments feature)
- [ ] No streak counter on the pet profile
- [ ] Streak increments on first moment of each calendar day (internal)
- [ ] Streak resets if day missed
- [ ] Streak milestones trigger achievements; progress visible on Achievements screen

---

## Dependencies
- Feature 012 (Moments) — streak tracking requires moments
- Feature 006 (Courses) — learning achievements require course completion
- Feature 003 (Event Calendar) — health achievements require event logging

## Out of Scope
- Global leaderboards (too social, not right now)
- Friends-based achievements (future social feature)
- Achievement points affecting any functionality (purely cosmetic + identity)
- Streak freeze / grace day (future — keeps it simple for now)
