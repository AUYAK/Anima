# Product Ideas Backlog

Ideas that are not ready to spec but worth remembering. Review during roadmap planning.

---

## Pet switcher in topbar

**Context:** Home screen topbar currently shows the most recently viewed pet (photo + name).
**Idea:** Make the topbar a scrollable row of pet avatars so the user can switch the active pet directly from the home screen without going to the Pets tab.
**Why it was deferred:** Scope. First ship single-pet topbar, validate the pattern, then extend.
**Trigger to revisit:** When users with 2+ pets report friction switching between pets.

---

## Notification / event badge on topbar pet

**Context:** Home screen topbar shows current pet photo + name.
**Idea:** Add a small badge counter on the pet avatar showing the number of upcoming events or unread reminders for that pet.
**Why it was deferred:** Scope. Badge count requires the Event Calendar feature to exist first.
**Trigger to revisit:** After Event Calendar is shipped and reminders are live.

---

## Push notification: weight update reminder

**Context:** Weight is recorded as a measurement entry tied to a pet. Users may forget to update it.
**Idea:** Send a push notification if no weight measurement has been logged for a pet in more than 30 days. Something like "Time to weigh Max -- it has been a month since the last update."
**Why it was deferred:** Requires Growth Tracking and push notification infrastructure to exist first.
**Trigger to revisit:** After Growth Tracking and event reminders are shipped.

---

## Memorial / tribute screen for passed away pets

**Context:** When a pet is marked as passed away, their status is stored and they move to the Inactive tab.
**Idea:** A dedicated memorial screen for passed away pets -- a beautiful, read-only view of their photos, key milestones, and a personal note from the owner. Something that feels like a tribute, not just a profile.
**Why it was deferred:** Requires the Inactive tab (Phase 2 of Pet Lifecycle) and Photo Gallery to exist first.
**Trigger to revisit:** After Pet Lifecycle Phase 2 and Photo Gallery are shipped.

---
