# Plavno — Prototypes (Full Detail)

Source: https://plavno-deploy.vercel.app/prototype/
Saved: 2026-07-02

---

## v1 — Редакция (Editorial)

**Philosophy**: Editorial authority over community. No user ratings, no social features. Ratings cannot be purchased.

**Design language**:
- Light/white background
- Purple/violet accents for tier badges
- Metallic symbols for status: ◈◆✦
- Generous whitespace, card-based, clean hierarchy
- Typography: clean modern sans-serif with size variation
- Three status tiers: Платина / Золото / Фиолетовый

**Features**:
- "Лучший ход" quiz: 4 questions (companion type, mood/atmosphere, budget, cuisine) → restaurant recommendation
- Bottom tabs: Гид (Guide) | Карта (Map) | Профиль (Profile)
- Header shows city + season context ("Москва · Весна 2025")

**Notable venues shown**: White Rabbit (Platinum), Savva (Gold), Chicha (Purple)

---

## v2 — Навигатор (Navigator) v0.3

**Philosophy**: Full-featured social platform. Most feature-complete early iteration.

**Design language**:
- Light backgrounds, white surfaces
- Gold/orange + purple accents
- Status badges with distinct colors
- Card-based layouts, modal overlays
- Bottom tabs: Гид | Карта | Профиль | Друзья

**Onboarding**:
- Apple ID / VKontakte / email sign-up
- Referral system: +100 XP per invited user
- Methodology explanation during onboarding

**Arthur AI**:
- 3-question flow: who's dining → mood → budget
- Conversational, character-based (Arthur persona)
- Returns personalized result, not a list

**Restaurant cards**:
- 6-dimension ratings: cuisine, service, atmosphere, interior, price/quality, wine list
- "Стол сейчас" — real-time table availability (updates every 5 min)
- Photo galleries + dish ratings

**Check-in system**:
- Gold: ₽30,000+ receipt → +100 XP
- Silver: any receipt QR → +40 XP
- Bronze: geolocation → +10 XP

**Gamification**:
- Level names: Ценитель → Гурман → Сомелье → Знаток → Мастер
- Weekly missions + bonus XP
- Achievement badges: "Первый шаг", "Исследователь", "Полиглот вкуса"
- Leaderboards: by XP or check-in count

**Social**:
- Friend network + activity feeds
- "Где были мои друзья" map overlay
- Public/private collections
- Story sharing tied to restaurants

**Booking**: Native reservations, no external redirects. Calendar availability + guest count + special requests.

---

## v3 — Атлас (Atlas)

**Philosophy**: Hybrid — editorial design + social. 41 screens.

**Design language**: Similar to v2 but more polished. Light backgrounds.

**Bottom tabs**: Гид | Карта | Друзья | Профиль

**Additional features vs v2**:
- Dish-level ratings and dietary indicators on menus
- Staff profiles (head chef background + achievements)
- "Маршрут дня" — curated daily route
- "Рядом с вами" — proximity-based section
- "Скоро в гиде" — restaurants pending 2nd inspection

**Notification center**: Booking confirmations, achievement unlocks, friend activity, new restaurant additions

**Content sections**:
- "Новые в гиде" — recently inspected venues
- Curated editorial collections
- Trending restaurants with check-in velocity ("⚡ +340%")

---

## v4 — Маршрут (Route)

**Philosophy**: Most developed iteration. Desktop + mobile.

**Bottom tabs**: Гид | Карта | Друзья | Профиль | (Comments)

**New features vs v3**:
- 26 total achievement badges across categories (location, user, friends, top restaurants, events)
- Map with animated check-in history
- Restaurant news and seasonal updates
- Deep linking to specific restaurants
- Closed community model: invitation codes (e.g., "PLAVNO-A3K9")
- Expanded taste profile: cuisines / occasions / priorities / frequency / neighborhoods / beverages / dietary restrictions

---

## v5 — Тёмный (Dark) ← **most relevant for design reference**

**Philosophy**: Premium mobile-first. Dark theme creates exclusive feel.

**Design language**:
- Background: ~#1A1A1A (deep dark gray/black)
- Status accents: Platinum → white/silver, Gold → amber/yellow, Purple → violet
- Card radius: visibly rounded (20px estimated)
- Typography: bold sans-serif headlines, regular body, ~18px/14px hierarchy
- Hero images with gradient overlays
- Progress circles for achievements (not bars)
- Two-column card grids

**Specific UI patterns**:
- Hero image → gradient overlay → text on top (name, cuisine, status badge)
- Swipeable horizontal card stacks in friends section
- Notification badges with counts
- Live status: "● онлайн" green dot
- Check-in count on cards: "247 чекинов за неделю"
- Amenity tags inline: "Панорама · Терраса · Живая музыка · Дресс-код"
- Friend card: "3 общих ресторана" (common restaurants counter)

**Onboarding**: 5-step taste profile personalization

**58 screens total**

---

## AI Prototypes

### ai-quiz-mobile — Артур AI (mobile)
- Simple 3-question mobile flow
- Shows "Подходит: 103" counter as restaurants are filtered
- Branding: "Артур AI | Плавно Гид"

---

### ai-template-1 — Swipe (Tinder-style)
- Home feed with editorial content ("Майские открытия", natural wine bars, oysters)
- Swipe mechanic: 12 binary questions
  - Вправо = да (right = yes)
  - Влево = нет (left = no)
  - Вниз = не важно (down = skip/neutral)
- District picker with map or neighborhood preset
- Processing screen: "Анализирую 103 ресторана → подбираю по предпочтениям → ранжирую по совместимости"
- Single restaurant reveal with alternatives

---

### ai-template-2 — Step wizard (7 steps)
**Most complete quiz flow**:
1. Occasion: романтический ужин / с друзьями / деловой / праздник / просто поесть
2. District: Moscow neighborhood or skip
3. Format: поесть / выпить / и то и другое / кальян
4. Cuisine: Japanese / Italian / мясо+огонь / seafood / Georgian / Russian-author
5. Ambiance: терраса / панорама / тихо/интимно / шумно / Michelin / натуральное вино / скрытые места
6. Budget: < ₽2,000 / ₽2,000–5,000 / ₽5,000+ / неважно
7. Intuition filter: final refinement

Results: single recommendation with rationale + explore alternatives

**Bottom nav**: Гид | Карта | Друзья | Моё

---

### ai-template-3 — Feed + wizard (8 steps)
**Home screen has content first**:
- Events feed: master class, chef's table dinner, chef collab, wine tasting
- Quick filters: романтический ужин / компания / деловой / особый повод
- Weekly discoveries: new / trending / hidden

**Quiz flow** (8 steps): same structure as template-2 but adds:
- Special needs step: children, shisha, non-touristy
- Results: "анализирую 103 ресторана" loading + explanation of choice

---

## Design Patterns Summary (across all versions)

| Pattern | Where | Notes |
|---|---|---|
| Dark hero + gradient + text overlay | v5, v3+ | Name, type, status badge on photo |
| 3-question AI → single reveal | All versions | Always 3 questions, never a list |
| Stories-style circles at top | v2+ | Friend/social layer |
| Progress circles for XP | v5 | Not bars — circles feel more premium |
| Rounded card radius | v5 | ~20px, prominent |
| "X общих Y" (common counter) | v5 | "3 общих ресторана" — social proof |
| Status badge on card | All | Color pill overlaid on hero image |
| Amenity tag strip | v3+ | Inline dots: "Терраса · Панорама" |
| Swipeable horizontal stacks | v5 | Friends section |
| Check-in count on card | v3+ | Weekly velocity metric |
