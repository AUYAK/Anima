# Feature: Activities
Status: Ready

## Goal
Let users track one-time and repeating care activities (vet visits, treatments, grooming) with the simplest possible setup — activities live as nodes on the pet's road, there is no calendar screen.

## User Stories
- As a pet owner, I want to set up "vet visit once a year" in seconds so that the app remembers care schedules for me.
- As a pet owner, I want suggested common activities so that I don't have to invent what to track.
- As a pet owner, I want to mark an activity done, optionally with a photo, so that it becomes part of the pet's history.

---

## Core model

**Activity = title + icon + schedule.**
- Schedule is either **one-time** (a date) or **repeating** (Daily / Weekly / Monthly / Every 3 months / Yearly)
- A repeating activity shows only its **next occurrence** on the road — never the whole future series
- Completing an activity moves a ✓ node into history (optionally with note + photo as the report); a repeating activity then shows its next occurrence
- A completed one-time activity is done — no new node

## Suggested templates (the defaults)

| Template | Icon | Default recurrence |
|---|---|---|
| Vet checkup | 🏥 | Yearly |
| Vaccination | 💉 | Yearly |
| Deworming | 🪱 | Every 3 months |
| Flea & tick | 🛡️ | Monthly |
| Grooming | ✂️ | Monthly |
| Medication | 💊 | Daily |

Custom activity: free-text title, generic 📌 icon. Templates are universal — no species logic in v1.

---

## Add flow — one bottom sheet, three questions

**Entry points:**
1. "＋ Plan" — small text button pinned at the top of the road (future part)
2. Tapping a suggestion node → sheet opens prefilled from the template

**The sheet:**
1. **What** — row of template chips + "Custom" (reveals a text field). Template tap prefills title, icon, recurrence.
2. **Repeat** — chips: Once | Daily | Weekly | Monthly | Every 3 months | Yearly
3. **When** — first/next date (date picker, defaults to today). Optional "Add time" link reveals a time picker; dates without time are the norm.

Primary button: "Save". Node appears on the road immediately.

---

## On the road (implements 009 Phase 2)

- **Planned node ○**: icon + title + date (+ time if set) + countdown ("in 3 days"); future part, nearest to today closest to the marker
- **Suggestions ◌** (the "what to track" message): when the pet has **zero planned activities**, the future part shows up to 3 template suggestion nodes (dashed) with hint copy: *"Add activities you want to track — vet visits, treatments, grooming"*. As soon as one activity exists, suggestions disappear; templates remain inside the add sheet.
- **Overdue**: due date passed without completion → node stays just above "today" with an amber "Overdue" label; still tappable to complete
- **Completed node ✓**: lands in history at completion time; tap → details with report

## Activity details & completion

Tap a planned node → bottom sheet: title, icon, schedule, next date.
- **Mark done** (primary) → same sheet switches to confirm state: optional note + optional photo, "Done" button → ✓ node in history; repeating activity spawns its next occurrence
- **Edit** — change title, date, recurrence
- **Delete** — confirmation: "Delete this activity? Its history stays." Past completions remain on the road.

Completing an activity fires the achievement check (013, Забота category).

---

## Acceptance Criteria

### Add
- [ ] Sheet opens from "＋ Plan" and from suggestion nodes
- [ ] Template tap prefills title, icon, and recurrence
- [ ] Custom title possible via "Custom" chip
- [ ] Recurrence options: Once, Daily, Weekly, Monthly, Every 3 months, Yearly
- [ ] Date defaults to today; time optional and hidden behind "Add time"
- [ ] Save creates the activity; planned node appears on the road immediately

### Road
- [ ] Planned node shows icon + title + date + countdown
- [ ] Repeating activity shows only its next occurrence
- [ ] Suggestions (max 3) shown only when the pet has zero planned activities
- [ ] Overdue node styled amber, stays above "today", tappable

### Completion
- [ ] "Mark done" moves a ✓ node into history with completion timestamp
- [ ] Optional note and photo attached to the completion
- [ ] Repeating activity spawns next occurrence on completion
- [ ] Achievement check fires on completion (013)

### Edit / Delete
- [ ] Edit changes title, date, recurrence of future occurrences
- [ ] Delete asks for confirmation; past completions stay in history

### Empty / Error
- [ ] Zero activities: suggestion nodes + hint copy in the future part
- [ ] Save failure: toast "Couldn't save. Try again.", sheet stays open

### SoonScreen
- [ ] Lists upcoming activities across all pets, nearest first, each row shows which pet
- [ ] Overdue rows styled amber, same as the road
- [ ] Row tap opens the same details/complete sheet used on the road
- [ ] Empty state: "Nothing planned yet" + "Plan something" → add sheet
- [ ] No calendar grid or month view anywhere on this screen

---

## Screens
- No new screens for planning/completing. Two bottom sheets (add, details/complete) over the Timeline tab (feature 011/009).
- **SoonScreen** — repurposes the existing bottom-nav "Calendar" tab (tab stays, per the earlier navigation decision to keep the tab bar as-is; only its content changes since there is deliberately no calendar screen)

## SoonScreen (the "Calendar" tab)

A flat list of upcoming planned activities across **all** the user's pets, nearest first — the cross-pet view the per-pet road can't give.

- Row: pet avatar (small) + activity icon + title + date/countdown; overdue rows styled amber, same as on the road
- Tap a row → same details/complete bottom sheet as on the road
- Grouped loosely by "Overdue" / "This week" / "Later" — no calendar grid, no month view
- Empty (nothing planned for any pet): illustration + "Nothing planned yet" + "Plan something" button → opens the add sheet (asks which pet first if the user has more than one)

## Navigation
- Road "＋ Plan" / suggestion node → add sheet → Save → back to road
- Planned node tap (road or SoonScreen) → details sheet → Mark done / Edit / Delete → back to where it opened from
- Bottom nav "Calendar" tab → SoonScreen

## Simplicity check (principles.md)
1. One job per sheet: add sheet plans, details sheet completes — one primary action each
2. Defaults: template prefills everything except the date; date defaults to today
3. Content over chrome: no calendar screen — the road is the schedule
4. Depth opt-in: details, note, photo, time — all behind a tap
5. No new surfaces: everything renders on the existing road; SoonScreen repurposes the existing "Calendar" tab rather than adding one

## Out of Scope
- Push notifications / reminders (separate Platform spec; the road shows what's due)
- Calendar screen or month view — deliberately never
- Custom recurrence ("every 2 weeks", specific weekdays)
- Smart care rules (auto-suggesting "no vet visit in 12 months") — v2 of suggestions
- Species-specific template sets
- Editing or deleting individual past completions
- Attaching documents (PDFs) to completions — photos only for now

## Dependencies
- Feature 009 (Timeline) Phase 1 — the road must exist to render activity nodes
- Feature 013 — achievement hook on completion (stub already in code)
