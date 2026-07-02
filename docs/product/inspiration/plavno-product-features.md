# Plavno — Product Features

Source: https://plavno-deploy.vercel.app/research/product-features.html
Saved: 2026-07-02

---

## Core Features (13 total, 12 production-ready)

### 1. Onboarding
Initial taste profile via 5-7 question quiz ("Точно").
Questions: cuisine preferences, occasion type, budget, atmosphere.

### 2. Main Feed
Personalized algorithmic stream:
- Premium restaurant cards (horizontal scroll)
- Friend activity ("What friends eat")
- Editorial collections (update by time/season)

### 3. Guide
Full catalog with three status tiers (Platinum / Gold / Purple).
Search + multi-parameter filtering + curated lists.

### 4. Restaurant Card
- Hero image with status badge
- Three-component rating
- Editorial description
- Practical details
- Social signals (friends who've been)
- Booking CTA

### 5. Map
Interactive Moscow map:
- Color-coded status indicators
- Radius filter: 500m – unlimited
- 8 cuisine types
- Price ranges, amenities
- Friends mode (shows where friends have been)

### 6. Check-ins
Visit verification system:
- QR at table: +100 XP
- Entrance QR: +40 XP
- Geolocation: +10 XP

### 7. Booking
Native reservation — no external redirects:
- Calendar availability
- Guest count
- Special requests
- Push confirmations
- Pre-visit reminders

### 8. Profile
Personal dashboard:
- Status progression
- Visit history
- Achievement badges
- Visual taste passport
- Privacy controls
- Referral links

### 9. Friends
Social layer:
- Stories-style circles
- Friend activity feed
- Friend-based restaurant rankings
- Social map view
- Referral mechanics (+100 XP)

### 10. Gamification
- 5 status levels: Novice → Connoisseur → Gourmet → Expert → Legend
- Weekly missions
- 8+ achievement badges
- Dual leaderboards: global + friend-based

### 11. Events
Exclusive gastro-events: chef dinners, tastings, weekend brunches.
Annual Plavno Awards ceremony with status-based access.

### 12. Plavno AI / Artur.AI
Three-question engine:
1. Evening type
2. Cuisine
3. Budget
→ Single result on a "Reveal" screen (not a list)

### 13. Methodology (under review — risk: manipulation)
Rating formula:
- Expert evaluation: 40%
- Community (weighted by verified visits): 35%
- Consistency: 15%
- Service: 10%

Thresholds: Platinum 8.5+ / Gold 7.0+ / Purple 5.5+

---

## Status System

| Level | XP Range | Benefits |
|---|---|---|
| Novice | 0–499 | Base access |
| Connoisseur | 500–1,999 | Expanded profile analytics |
| Gourmet | 2,000–4,999 | Event priority |
| Expert | 5,000–9,999 | Exclusive tastings |
| Legend | 10,000+ | Restaurant selection participation |

---

## Monetization
Commission per booking (restaurant pays) or subscription partnership.
V1 approach: simpler commission-based.

---

## Core User Journey
Onboarding → Content Discovery (Feed / Guide / Map) → Decision (AI or Card) → Conversion (Booking) → Verification (Check-in) → Retention (XP / Friends)

---

## Design Principles
- **Transparency**: Show where recommendations come from (editor / community / personal history)
- **Speed**: Minimal friction to conversion
- **Verification**: Only checked-in visits count toward ratings
- **Social proof**: Friend activity ranks higher than algorithm alone
- **Physical layer**: Events translate digital engagement into real-world community
