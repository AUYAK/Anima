# Feature: Achievements & Titles
Status: Ready

## Goal
Reward users for real care and consistency with a WoW-style achievement system: accumulating points, unlocking titles, and displaying one chosen title on their profile.

## Core concepts

**Очки достижений (Achievement Points)**
Every achievement has a point value. Points accumulate into a global score shown on the user's profile. This is a permanent, ever-growing number — never resets.

**Достижения (Achievements)**
Discrete milestones across 5 categories. Each has: name, description, icon, point value, unlock condition, progress tracking where applicable.

**Звания (Titles)**
Special achievements that grant a displayable title. User can earn many titles but shows only one at a time — chosen from their collection. Title appears under the user's name on their profile.

---

## Achievement categories

### 🐾 Вместе (Together) — time-based milestones
| Achievement | Condition | Points |
|---|---|---|
| Первый день | Завёл питомца | 10 |
| Месяц вместе | 30 дней с питомцем | 25 |
| Полгода вместе | 180 дней | 50 |
| Год вместе | 365 дней | 100 |
| Три года вместе | 1095 дней | 200 |
| Пять лет вместе | 1825 дней | 500 |

### 📸 Летописец (Memory) — moments and photos
| Achievement | Condition | Points |
|---|---|---|
| Первый момент | Сохранил первый момент | 10 |
| Фотограф | 10 моментов | 20 |
| Хроникёр | 50 моментов | 50 |
| Архивариус | 200 моментов | 100 |

### 🔥 Постоянство (Streaks) — consecutive day logging
| Achievement | Condition | Points | Title unlocked |
|---|---|---|---|
| Первая неделя | 7 дней подряд | 25 | — |
| Месяц без пропуска | 30 дней подряд | 75 | «Постоянный» |
| Сто дней | 100 дней подряд | 150 | «Верный хозяин» |
| Год подряд | 365 дней подряд | 500 | «Легенда» |

### 💉 Забота (Health) — health and care events
| Achievement | Condition | Points | Title unlocked |
|---|---|---|---|
| Первый визит | Записал первый визит к ветеринару | 15 | — |
| Здоровый питомец | 3 записанных вет-визита | 30 | — |
| Образцовый хозяин | Полная история прививок (3+) | 75 | «Образцовый хозяин» |
| На контроле | Визит к вету каждые 12 месяцев (2 года подряд) | 100 | — |

### 🎓 Знания (Learning) — courses
| Achievement | Condition | Points |
|---|---|---|
| Первый урок | Завершил первый курс | 20 |
| Студент | Завершил 3 курса | 50 |
| Эксперт | Завершил 10 курсов | 150 |

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
| Ветеран | 5 лет с питомцем |
| Мастер ухода | Завершил 10 курсов |
| ⭐ Любимчик редакции | Мета-ачивка: закрыть все 5 категорий |

Default title: none (field empty until first title unlocked).

---

## Achievement unlock flow

When an achievement is unlocked — immediately after the triggering action:

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
- Filter chips: Все | Вместе | Летописец | Постоянство | Забота | Знания
- Summary: total points + count
- Each item: icon + name + description + points + status
  - Unlocked: green checkmark + unlock date
  - In progress: progress bar with "N / M" count in amber
  - Locked: gray icon, gray text, lock icon right
- Title achievements have crown icon and show equipped badge if active

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
- [ ] All 5 category filters work
- [ ] Unlocked items show date
- [ ] In-progress items show progress bar + count
- [ ] Locked items shown grayed

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
