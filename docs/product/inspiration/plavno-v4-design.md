# Plavno v4 (Маршрут) — Full Design Reference

Source: https://plavno-deploy.vercel.app/prototype/v4-marshrut.html
Analysed from screenshots: 2026-07-04

---

## Color Palette

| Token | Value | Used for |
|---|---|---|
| Background | ~#F2EDE6 | All screens — warm cream/beige, not white |
| Surface | #FFFFFF | Cards, modals |
| Text primary | ~#0D0D0D | Titles, names |
| Text secondary | ~#8C8C8C | Meta, subtitles, muted labels |
| Button primary | #000000 | Main CTA buttons |
| Amber accent | ~#C4892A | Active states, check-in counts, "все →" links, secondary info, active progress bars |
| Purple accent | ~#6941C6 | Achievements card, ФИОЛЕТОВЫЙ tier, feature icons |
| ПЛАТИНА tier bg | ~#8A9BAD | Gray-blue muted card |
| ЗОЛОТО tier bg | ~#8B6914 | Warm brown/amber card |
| ФИОЛЕТОВЫЙ tier bg | ~#7B3FA0 | Purple card |
| Green success | ~#22C55E | Checkmarks, completed achievements, active friends |
| Orange trending | ~#E85D04 | Trend badge "+340%", active mission badges |
| Dark green (Stories) | ~#0D2818 | Story/check-in full-screen background |

**Key insight**: The background is NOT white — it's a warm cream. All cards sit on this warm base. This creates warmth without going dark.

---

## Typography

- **No custom typeface visible** — uses a clean system-style geometric sans (likely Inter or SF Pro)
- Section headers: uppercase, letter-spaced, small (~11px), muted gray — e.g. "РЕДАКЦИЯ ВЫБИРАЕТ", "ТРЕНДОВЫЕ ⚡"
- Restaurant/feature names: semi-bold, ~18–20px
- Meta line: regular, ~13px, separator dots "Нео-русская · РРРР · Пресня"
- Status badge text: uppercase, small, white
- Body/descriptions: ~14px, gray

---

## Screen-by-Screen Breakdown

### Onboarding (5 screens)

**Screen 1 — Welcome**
- Full cream bg, centered layout
- Icon: rounded square container (~64px), muted gray bg, outline icon inside
- Title: 2-line, bold, large
- Subtitle: gray, smaller
- Gap at bottom → two buttons stacked
- Primary: full-width, black, rounded pill
- Secondary: text-only, no border, gray

**Screen 2 — "Оценки, которые нельзя купить"**
- Dot progress indicator at top (pill shape, amber = active, gray = inactive)
- Purple rounded square icon
- Feature card embedded mid-screen: dark purple/navy bg, "АКТ ИНСПЕКЦИИ" label, scores shown as 3 chips side by side (Кухня 9.2 / Сервис 9.5 / Атмосфера 9.8), "2 визита · инкогнито" pill + "ПЛАТИНА" badge
- 3 feature rows: dark rounded square icon + amber/gold text description
- Pропустить button is visibly grayed out (can't skip critical screens)

**Screen 3 — "Три уровня признания"**
- 3 full-width tier cards, rounded, each with own bg color
  - ПЛАТИНА: gray-blue bg, muted look, ◈ icon
  - ЗОЛОТО: warm brown bg, ☆ icon
  - ФИОЛЕТОВЫЙ: purple bg, ⚡ icon
- Each card: icon left, tier name (bold, white), count (muted white), description below

**Screen 4 — "Всё для выбора вечера"**
- 3 feature cards with colored circle icon on left
  - Purple circle: "Плавно AI — ваш помощник" with 3-line description
  - Green circle: "Карта лучших мест"
  - Amber circle: "Чекины и достижения"
- Cards: white bg with very subtle border, rounded

**Screen 5 — Account creation**
- Lock icon (same style as welcome)
- 3 auth buttons: all outlined (border, no fill), icon + text, stacked
- Legal text tiny at bottom
- "Войти позже, просто посмотреть →" — hyperlink style, dismissible

---

### Main Feed (Гид)

**Header**
- Title "Гид" bold large, city "Москва" with 📍 pin below (smaller, gray)
- Top right: search 🔍 + notification bell with red badge (number)
- No AppBar chrome, title is part of content scroll

**Hero carousel**
- Full-width card, 16:9 photo, dark gradient overlay from bottom
- Tag badge top-left: "ДЕГУСТАЦИЯ" — small pill, dark purple bg, white text
- Date/time next to badge
- Title large white bold, 2 lines
- Bottom strip: "Restaurant · STATUS · price · N вин" + green "● Открыто" dot
- Dot pagination below card (amber = active)

**Section titles**
- Format: "РЕДАКЦИЯ ВЫБИРАЕТ" or "ТРЕНДОВЫЕ ⚡"
- All-caps, tiny, letter-spaced, dark gray
- Left-aligned, full width

**Restaurant cards (2-column grid)**
- Photo top (square or slightly taller)
- Friend avatars overlaid on photo, bottom-left: small circles + label "были здесь" / "хочет сюда"
- Below photo: status badge (ПЛАТИНА = muted, ЗОЛОТО = gold amber text), name bold, cuisine below in gray

**Trending cards**
- Same 2-column grid
- Orange trend badge overlay "+340%"
- Below photo: status, name, check-in count in amber "247 чекинов за неделю"

**New in Guide (full-width)**
- Full-width card, photo left (~40%), text right
- Name + status pill right-aligned on name line
- Cuisine · district · price below
- Amber accent text: editorial note or opening date

**Floating "Чекин" button**
- Fixed at bottom above tab bar
- Full-width dark pill, ✓ icon + "Чекин" white text
- Sits above tab bar

**"Артур" AI button**
- Bottom-right corner, circular
- Photo avatar with "СПРОСИ АРТУРА" label wrapping around it (arc text)
- Partially overlaps content

---

### Map (Карта)

- True full-screen map, no cream bg visible
- Dark pill search bar at top, full-width, "Ресторан, район, кухня..." placeholder + filter icon right
- Toggle chips below search: "Рестораны" (selected = dark/filled) | "Друзья" (outlined)
- Map pins:
  - Dark drop pins with fork-knife icon inside: restaurants
  - Dark drop pins with crown inside: Platinum
  - Gold star pins: Gold tier
  - Purple outline pins: Violet tier
  - Friend circles: colored initials avatar (КМ green, ДВ brown, МК green, ИС pink/magenta)
  - Friend name label floating below avatar
- Standard zoom +/- bottom right

---

### Friends (Друзья)

**Header row**
- Stories-style friend circles: colored border (green = active/recent, gray = inactive)
- Initials avatar, name below
- First circle appears empty/add-new

**Referral card**
- Dark brown/charcoal card, full-width, rounded
- "РЕФЕРАЛЬНАЯ ПРОГРАММА" label small uppercase
- "Пригласи друга →" bold
- Two side-by-side gold stats: "+100 чекинов тебе" | "+100 другу при входе"

**Top Restaurants section**
- "ТОП РЕСТОРАНОВ" title + "по чекинам друзей" right-aligned amber
- Horizontal scroll cards with photo, friend check-in count chip "4 чекина" overlaid

**Activity feed**
- Entry: avatar circle + name + verb + place + time
- Secondary line: "С [friend] · 30 мин назад"
- "Открыть →" amber link + 👍 reaction count

---

### Stories (Check-in)

- Full dark green background (~#0D2818)
- Progress bar segments at top (similar to Instagram Stories)
- Top left: avatar + name + time · restaurant name
- Top right: × close
- Center: large avatar placeholder
- Text message centered, white, large-ish
- Bottom: location pill "📍 Savva" — dark pill with shadow, rounded

---

### Restaurant Detail

**Header**
- Hero photo full-width (no overlay text)
- ← back (white circle bg), ♡ heart (white circle bg), ⋯ more (white circle bg) — floating over photo
- Below photo: horizontal tab bar
  - "Обзор" (active, amber underline) | "Впечатления · 247" | "Фото" | "Новости · 2"

**Info section**
- Name + "ПЛАТИНА" on same line right-aligned
- Meta: cuisine · price tier · district, gray
- "● Открыто · до 00:00 · 📍 2.4 км" — green dot
- 4 circular icon buttons in row: colored backgrounds, white icon, label below (Сегодня, Атмосфе..., Шеф, Вид)

**Editorial review**
- Left border accent (thick vertical amber/brown bar)
- "ОЦЕНКА ПЛАВНО ГИД 2026" small label
- Body text with key words bold/colored
- Rating large: "9.5 из 10 · по 6 критериям"

---

### Profile

**Header**
- Avatar (colored initials circle) + camera icon badge overlay
- Name bold
- "6 ачивок из 26 → Reward Hub" with thin purple progress bar under name

**Stats row**
- 3 columns: Чекина | Ачивок | Друзей
- Numbers large amber, label below small gray
- Dot indicator on Ачивок (new activity)

**Achievements card**
- Dark purple full-width card
- "ДОСТИЖЕНИЯ" small label + "6 из 26" large
- "Следующая: Душа компании" on right
- Progress bar (thin, lighter purple)
- Filter tabs: "По месту · По юзеру · По друзьям"
- "20 открыто" gray right

**Favourites / Want to visit**
- Section title + count + "Все →" amber
- 2-column photo cards

**Profile menu list**
- Icon (colored, themed) + title + subtitle + > chevron
- "Reward Hub" item has purple star + purple text = highlighted/special
- "Задания недели" has orange badge "2"
- Grouped by visual separation (space or divider)

---

### Achievements Screen

**Header**: "Достижения · 6 / 26" with back arrow

**Filter chips** (scrollable horizontal)
- "Все" active = black filled
- Others: outlined, gray

**Summary banner**
- Trophy icon + "6 ачивок получено из 26 доступных · 5 категорий"
- Progress bar

**Achievement rows**
- Section: "По месту 1/5", "По юзеру 1/6", "По друзьям 2/5"
- Each item: emoji/colored icon + name bold + description gray + status right
  - Completed: green ✅ checkmark circle
  - In-progress: colored progress bar (amber or green, thin, under item)
    - Shows "2/5" or "1/3" in amber in description
  - Locked: gray icon (desaturated), gray text, 🔒 icon right

**Achievement examples (full list)**

*По месту (5):*
1. Знакомое лицо — 2 визита в один ресторан ✅
2. Постоянный гость — 5 визитов в один ресторан (2/5) 🔑
3. Хозяин стола — 3 больших чека в одном ресторане 🔒
4. Верный гость — 4 разных недели в одном ресторане 🔒
5. Свой человек — 10 визитов в один ресторан 🔒

*По юзеру (6):*
1. Первый шаг — Первый чекин ✅
2. Гурман — Большой чек в 3 разных ресторанах (1/3)
3. Ценитель — Большой чек в 10 разных ресторанах 🔒
4. Завсегдатай — «Знакомое лицо» в 5 ресторанах 🔒
5. Знаток — «Постоянный гость» в 5 ресторанах 🔒
6. Инсайдер Плавно — «Свой человек» в 3 ресторанах 🔒

*По друзьям (5):*
1. Не один — Первый друг в Плавно ✅
2. По наводке — Чекин в ресторане, где друг уже бывал ✅
3. Одна волна — Чекин в одном ресторане с другом в один день 🔒
4. Гастропара — 5 совместных визитов с одним другом (2/5)
5. Проводник — Пригласил 3 друзей 🔒

---

## Component Patterns Summary

| Component | Pattern |
|---|---|
| Primary button | Full-width, black, ~16px radius, white text |
| Secondary button | Text-only, no border |
| Outlined button | Border, no fill (auth buttons) |
| Section title | All-caps, ~11px, letter-spaced, gray |
| "Все →" link | Right-aligned, amber colored |
| Status badge | Small pill, white text, colored bg |
| Progress bar (in-progress) | Amber, thin ~3px |
| Progress bar (social) | Green, thin ~3px |
| Achievement checkmark | Green filled circle, white ✓ |
| Achievement locked | 🔒 right-side icon, item text grayed out |
| Friend avatar | Colored circle with initials, colored border for active |
| Notification badge | Red circle, white number, top-right |
| Floating CTA | Full-width dark pill, fixed above tab bar |
| AI button | Circular, bottom-right corner |
| Editorial card | Left border accent + label + body |
| Tab bar (detail) | Text tabs, amber underline for active |
| Filter chips | "Active = dark filled" / "Inactive = outlined" |
| Story bg | Dark green, not black |

---

---

### Notifications (Уведомления)

- Title + "Прочитать всё" amber link right-aligned
- Time groups: "НОВЫЕ" / "СЕГОДНЯ" / "РАНЕЕ" — same all-caps section label style
- Each item: colored themed icon (rounded square, ~36px) + bold title + gray description + time
- Unread indicator: small amber dot on the right edge of the row
- Icon is thematically matched (green ✓ for booking, ⚡ for new guide entry, 👥 for friends, 🏆 for achievements)

---

### Settings (Настройки)

**Structure — 3 groups:**

*АККАУНТ*
- Name (with amber color on surname) + "Вкусовой профиль" — both have > chevron

*УВЕДОМЛЕНИЯ — toggle switches*
- "Новые в гиде" ON
- "Достижения" ON
- "Чекины друзей" OFF (gray)
- "События" ON

*КОНФИДЕНЦИАЛЬНОСТЬ*
- Privacy items: title + amber subtitle showing current value ("Только друзья", "Все пользователи") + > chevron
- "«Никогда больше» скрыта" — toggle + description below
- "Показывать в «Рядом»" — toggle + description below

*О ПРИЛОЖЕНИИ*
- "О гиде", "Условия использования" — standard rows

**Destructive action**: "Выйти из аккаунта" — red text, full-width, no icon, at bottom

---

### Geolocation Permission (Check-in flow)

- Centered layout on cream bg
- Large colored circle icon (~80px) with subtle glow/pulse effect — green, location pin inside
- Title "Где вы сейчас?" bold
- Explanation: gray body + smaller "Используем только в момент чекина." trust note
- Primary: black pill "📍 Разрешить геолокацию"
- Secondary: outlined/text "Найти ресторан вручную"

**Pattern**: Permission screens always explain WHY + offer a fallback. Never force.

---

### Check-in List

- Green success banner at top: "Хамовники, Москва — Геолокация определена · обновлено только что" + "Обновить" amber link
- Search bar below banner
- Section "РЯДОМ С ВАМИ"
- List items: small square photo (thumbnail) + name bold + status colored + cuisine · district + distance right-aligned
  - Very close: green "67 м рядом"
  - Further: gray "230 м", "450 м", "1.1 км"

---

### Плавно AI — Intro Screen (dark, separate design language)

**Completely different visual language — dark, immersive, character-driven**

- Full dark background (~#0D0D0D)
- AI avatar: illustrated character, circular, purple/violet glow ring
- Name "Плавно AI" bold white
- "Персональный гид" subtitle gray
- Gold pill badge: "⭐ 20+ лет в ресторанном бизнесе"
- Body text with inline highlights: amber for "Золото", purple for "Фиолетовый"
- Feature cards: dark surface (~#1A1A1A), colored icon left (pink brain, teal search), description right
- Primary CTA: large amber/gold pill button — "Поговорить с Плавно AI"
- Secondary: "Ответить текстом →" small link (voice is default, text is fallback)

---

### Плавно AI — Voice Interface

- Deep purple-indigo background (different from intro — ~#1A1040)
- "● AI-гид · Плавно Гид" small status label top center
- × close button top-left (circle, not full-screen back)
- AI avatar center: large circular, concentric dark rings as glow/pulse around it
- Name + "Расскажите, что планируете" below avatar
- Small muted hint: "Я подберу лучшее место специально для вас"
- Bottom action row: red × cancel circle (left) + large purple "Начать разговор" pill (right, ~70% width)

---

### Плавно AI — 3-Question Flow (dark)

**All 3 questions share the same layout:**
- Dark background (consistent with voice screen)
- < back + amber progress bar top right showing "1/3", "2/3", "3/3" (not dots)
- AI avatar (smaller) top center
- Question text: large, white, bold, centered
- Subtitle hint: small, gray, italic-style ("скажите или выберите вариант")
- **Primary input: large amber/gold circle mic button** — voice is the primary action
- "НАЖМИТЕ И ГОВОРИТЕ" label below mic
- "ИЛИ ВЫБЕРИТЕ" divider
- **Options: full-width dark cards**, slightly lighter than bg, emoji icon left + text right

**Question 1**: "Что за вечер планируете?"
Options: 💞 Романтический ужин / 👥 Встреча с друзьями / 💼 Бизнес-встреча / 🎂 Особый повод / 🌙 Просто поужинать

**Question 2**: "Что сейчас хочется?"
Options: ❤️ Что-то сытное и тёплое / 🌿 Лёгкое, свежее, сезонное / 🌶️ Азиатское, острое, яркое / 🍝 Итальянское, уютное / 🎲 Удиви меня

**Question 3**: "Бюджет на человека?"
Options: ₽₽ до 5 000 (amber hint "Хороший ресторан") / ₽₽₽ 5 000–20 000 / ₽₽₽₽ от 20 000 / ✨ Неважно (amber hint "Главное — место")

**Key UX insight**: Options are written in the user's voice ("Что-то сытное и тёплое"), not feature labels ("Мясная кухня"). This makes selection feel like thinking out loud, not filling a form.

---

### Плавно AI — Reveal Screen

**The most distinct screen in the entire app — ceremonial moment**

- Full dark background (~#0D0D0D to slightly warmer dark brown)
- "ПЛАВНО AI РЕКОМЕНДУЕТ" — small gray all-caps centered at top
- Status badge: "ПЛАТИНА" — small amber/gold text
- Restaurant name: **LARGE SERIF FONT** — completely different from app's sans-serif everywhere else. This is intentional — the reveal feels like a poster, a moment
- Meta: gray, smaller — "Паназиатская · Пресня · 16 этаж"
- Editorial card: dark brown surface, left amber bar accent, 2-line rationale ("Именно то, что нужно для этого вечера")
- **Two buttons stacked:**
  - Primary: **AMBER/GOLD filled** pill — "Забронировать столик" with dark text — the ONLY screen where the primary button is gold, not black
  - Secondary: dark outlined — "Посмотреть ресторан"

**Design logic**: Black button = utility. Gold button = the moment you've been guided to. The color signals "this is special."

---

### Booking Screen (Бронирование)

- Standard cream bg, back to normal app feel
- Restaurant preview: small square image + name + cuisine · district card at top
- Form fields:
  - **Дата**: full-width input with calendar icon, date format
  - **Время**: pill chips — selected chip has dark border (not filled), unselected gray: "19:00" | "19:30" | "20:00" | "20:30" | "21:00"
  - **Количество гостей**: − | 2 | + stepper (minimal, just number + buttons)
  - **Повод (необязательно)**: multi-select pill chips, outlined: "День рождения" | "Годовщина" | "Бизнес" | "Свидание"
  - **Комментарий**: text area, gray placeholder "Аллергии, особые пожелания..."

---

## Anima Adaptation Notes

| Plavno pattern | Anima adaptation |
|---|---|
| Cream background | Use same warm cream — much better than pure white for pet photos |
| Section titles all-caps muted | "ПОСЛЕДНИЕ ФОТО", "СОБЫТИЯ", "О ПИТОМЦЕ" |
| Achievement system | Pet care milestones: "Первая прививка", "Год вместе", "5 фото загружено" |
| Achievement locked/in-progress states | Same pattern: gray locked, colored progress bar |
| Stories check-in (dark green) | Same pattern for "milestone moments" (birthday, first vet visit) |
| Floating CTA pill | On pet profile: "Добавить событие" fixed above tab bar |
| Referral card (dark, stats) | Invite friends card: "Поделись профилем питомца" |
| Editorial review block (left border) | Breed info block with vet-sourced content |
| Hero carousel with event badge | Upcoming events carousel on home screen |
| Friend avatars on photo ("были здесь") | Other users' pets on shared locations (future social) |
| Map with friend circles | Vet clinics + friend pets map (future) |
| Trend badge "+340%" | Не применимо напрямую |
| "по чекинам друзей" sort | "по активности" sort in pet list |
| Notification groups НОВЫЕ/СЕГОДНЯ/РАНЕЕ | Same pattern for pet event notifications |
| Typed notification icons | Vet = green cross, birthday = cake, vaccine = shield |
| Settings privacy items with amber current-value subtitle | "Профиль питомца видят: Только я / Все" |
| Destructive action = red text at bottom of settings | "Удалить питомца" — same treatment |
| Permission screen: large colored icon + glow + fallback | Geolocation, camera, notifications — always explain WHY |
| Check-in list: green success banner at top | After any success action: green banner with "обновлено только что" |
| AI intro: dark immersive + character + trust badge | Future Anima AI: "Ветеринарный помощник — 15 лет практики" |
| AI voice: concentric ring glow around avatar | Voice-first input with visual breathing/listening state |
| AI questions in user's voice | "Что-то беспокоит?" not "Выберите симптом" |
| AI reveal: SERIF font for the answer | When showing a course/vet recommendation — serif name = ceremony |
| AI reveal: GOLD button only for this moment | Green button for "Запланировать визит" on the AI result |
| Booking: time chips (not dropdown) | Vet appointment time slots as chips |
| Booking: occasion chips | Reason for visit: "Плановый осмотр" / "Вакцинация" / "Беспокойство" |
| Booking: free text comment | "Опишите симптомы или пожелания" |
