# Product Principles

Most pet apps are a database with a UI on top: entities → forms → lists → filters → dashboards. The user is asked to work as a data-entry operator, and every screen offers 5–7 equal actions with no answer to "what should I do right now?".

Anima competes on simplicity. Simplicity is NOT "few features" — it is **few decisions per moment**. Instagram has hundreds of features, yet at any moment it expects exactly one thing from you.

Every new feature spec must pass the five principles below (checked in DOR).

---

## 1. One screen — one job — one primary action

Every screen answers one question or serves one task, with one clearly primary CTA.

**Litmus test:** if a screen has two equally-weighted primary actions, the screen is designed wrong — split it or demote one.

## 2. Never ask what we can infer

Pet, date, time, defaults — the app fills them in; the user only provides what only the user knows.

**Litmus test:** for every input field ask "could the app know this?" If yes, it's a default the user can override, not a question.

## 3. Content over chrome

Photos and the road, not cards, widgets, and dashboards. The pet's life is the interface.

**Litmus test:** if a section can be replaced by a photograph or a node on the road — replace it.

## 4. Depth is opt-in

Complexity (achievements journal, detail fields, measurement history) lives one tap away from a surface — never on it.

**Litmus test:** removing the deep view must not break the primary flow of the surface it hangs off.

## 5. New features don't create new surfaces

Anima has three primary surfaces, each with one job:

| Surface | Job |
|---|---|
| Home | the feed — what's happening |
| ＋ (center tab) | capture — save a moment |
| Pet Profile | the road — the pet's life, past and planned |

Everything new lands as a node type on the road, a moment tag, a quest in achievements, or a detail behind an existing surface. A new top-level screen or tab requires an explicit, deliberate product decision — it is never the default answer.

**Litmus test:** if the spec's navigation section adds a top-level entry point, stop and redesign.

---

## Applied examples (July 2026)

- Health snapshot cards removed from the pet profile — the road shows the same facts as nodes (principle 3)
- Streak counter removed from the hero — consistency lives in the achievements journal as quest progress (principle 4)
- Moment compose: pet, date, and time are prefilled defaults; only photo and tag are real questions (principle 2)
- Timeline, gallery, and info collapsed into one profile with two tabs instead of section blocks (principles 1, 5)
