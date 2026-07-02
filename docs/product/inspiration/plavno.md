# Plavno — Product & Design Reference

Source: https://plavno-deploy.vercel.app/
Saved: 2026-07-02
Type: Russian restaurant guide app. Used as inspiration for design language, product strategy, and feature patterns — not as a direct copy.

---

## Design language

### Visual style (Prototype v5 "Dark" — most relevant iteration)
- **Theme**: Dark background, not white — creates premium feel
- **Accent color**: Purple (#7C3AED range) — confident, non-standard for apps in this category
- **Card radius**: 20px — noticeably round, modern
- **Layout**: Masonry grids and portrait-oriented cards — more visual than tabular
- **Typography**: Diatype — geometric, editorial weight; applied at large sizes for pet names/headers in Anima context
- **Photography**: Full-bleed hero images on cards — content first, chrome minimal

### UI patterns worth borrowing
- **Stories-style circles** at top of feed (friend activity / pet avatars) — already using this pattern in our topbar
- **Reveal screen**: AI gives one result, not a list — single focused outcome
- **Status badge on card**: Small colored pill overlaid on hero image (Platinum / Gold / Purple) → adapt as pet health status or milestone badge
- **Horizontal scroll collections** inside a vertical feed — photos strip, upcoming events strip
- **Dark gradient overlay** on hero photo with text on top — exactly what we're building in feature 011
- **Progress circles** (not bars) for XP/milestones — feels more premium than progress bars
- **"X общих Y" counter**: "3 общих ресторана" between friends → for Anima: "same breed" or "same city" social signal
- **Amenity tag strip**: inline dots "Терраса · Панорама · Дресс-код" → adapt as pet trait tags "Active · Indoor · Vaccinated"
- **Check-in velocity on card**: "247 чекинов за неделю" → for courses: "87 owners completed this week"
- **Content-first + quiz-second** (template-3): feed with events/discoveries as home, quiz accessible but not forced
- **3-question quiz, always**: never more than 3 questions for AI recommendation — every AI template uses exactly 3

---

## Product patterns to adapt for Anima

### 1. Taste profile quiz → Pet profile onboarding
Plavno runs a 5-7 question quiz at onboarding to build a taste profile, then re-runs it each session.
**Anima adaptation**: A "getting to know your pet" flow when adding a first pet — 3-4 questions beyond basic fields (activity level, indoor/outdoor, allergies). Feeds into personalized care reminders.

### 2. Gamification — XP + status tiers
5 status levels (Novice → Legend) with XP earned for actions (check-ins, reviews).
**Anima adaptation**:
- XP for: adding vet visits, completing vaccine schedules, uploading photos, completing training courses
- Status levels: "New owner" → "Caring owner" → "Devoted owner" → "Champion owner"
- Achievement badges: "First vaccine", "1 year together", "10 photos uploaded", "Full health record"
- Drives retention without being annoying — tie badges to real milestones, not arbitrary tasks

### 3. Check-in system → Vet visit verification
Plavno rewards QR check-ins at restaurants with XP.
**Anima adaptation**: After adding a vet event, mark it "completed" and attach a photo/document — this becomes the pet's verified health record. More trustworthy than self-reported data.

### 4. Friends + social layer
Friends list, activity feed ("what friends are eating"), friend-based restaurant rankings.
**Anima adaptation**: Already in ideas.md — share pet profile, see friends' pets. The "friend activity feed" pattern (small card: avatar + action + time) is clean and worth using when we build social.

### 5. Visual "passport"
Profile shows a "visual taste passport" — a summary card of the user's preferences.
**Anima adaptation**: Pet passport — one-screen printable/shareable summary: photo, name, species, breed, DOB, vet info, vaccine status. Could be a sharable card (PNG export). Perfect viral growth mechanic.

### 6. Artur.AI — three-question recommendation engine
Asks: evening type → cuisine → budget → shows one result on a "Reveal" screen.
**Anima adaptation**: "What does my pet need today?" — 3 questions (symptom type, pet age, recent vet visit) → one focused recommendation (course, reminder, vet visit prompt). Better than a search bar for non-expert owners.

### 7. Editorial + community dual authority
40% expert panel + 35% community (weighted by verified visits) + 25% other.
**Anima adaptation**: For courses/care guides — some authored by vets (expert), some by experienced owners (community-verified). Rating per course weighted by completion rate + user votes.

---

## Strategic insights applicable to Anima

### The Michelin gap
Michelin left Russia in 2022, leaving a premium authority vacuum. Plavno is filling that gap.
**Parallel**: There's no "trusted pet care authority" app in the CIS market. Premium, vet-backed content + expert curation is a real gap. Anima can own it.

### Retention problem: 4-7% DAU/MAU for guides vs 60%+ for delivery
Plavno acknowledges restaurant guides have terrible retention.
**Lesson**: Event/reminder mechanics are Anima's biggest retention lever — upcoming vaccine in 3 days is a push notification reason to open the app. Much better than "browse content."

### Social proof beats algorithms for trust
Plavno: "58% of users distrust purely algorithmic reviews."
**Lesson**: When we add courses, show "87 owners of Labrador Retrievers completed this." When we add reminders, show "Vets recommend every 12 months." Human/expert authority anchors trust.

### Gen Z discovery on TikTok/Instagram (56% of 18-35)
Plavno's risk: users find places via social, not via their app.
**Lesson**: Make Anima content shareable and beautiful enough that pet owners post it. Pet passport card, birthday card, "1 year with Grom" milestone card — these are the Instagram moments that drive installs.

---

## What NOT to copy

- **Dark theme**: Cool for a restaurant guide, wrong primary theme for a pet app — pets, photos, warmth. Use as optional dark mode, not default.
- **Purple accent**: Doesn't match Anima's nature/green brand (see design-reference.md for our palette)
- **Diatype typeface**: Licensing cost, wrong tone. Our current reference uses system fonts + geometric sans.
- **Booking/commission model**: Restaurants pay Plavno. Not applicable. Anima stays free.
- **Gamification as core mechanic**: XP works for Plavno because going to restaurants is inherently fun. For pet care, gamification should be supportive (badges for milestones), not the main value driver — the main value is genuine care and memory.
