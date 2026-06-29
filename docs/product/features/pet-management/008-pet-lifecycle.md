# Feature: Pet Lifecycle
Status: Draft

## Goal
Allow users to reflect the real status of their pet — active, passed away, or removed — without losing data, and give them full control to permanently delete that data later if they choose.

## Pet statuses

| Status | Meaning | Triggered by |
|---|---|---|
| Active | Current pet, shown in main list | Default on creation |
| Passed away | Pet has died; data preserved | "My pet passed away" on PetProfileScreen |
| Removed | Pet rehomed or added by mistake; data preserved | "Remove from my pets" on PetProfileScreen |
| Hard deleted | All data permanently erased | Delete action in Inactive tab (future) |

Dev: pets table needs a `status` column (active / passed_away / removed) and a `status_changed_at` timestamp.

## User Stories
- As a user whose pet has died, I want to mark them as passed away so they no longer appear in my active list but I keep all their history.
- As a user who no longer has a pet, I want to remove them from my list without worrying I am deleting memories.
- As a user, I want to permanently delete all data for a pet if I decide I never want to see it again.
- As a user who tapped the wrong button, I want to undo the action immediately so my pet is restored to active.
- As a user, I want to see a confirmation message after an action so I know it completed successfully.

## Acceptance Criteria

### Phase 1 (this feature)
- [ ] PetProfileScreen shows two buttons at the bottom: "My pet passed away" and "Remove from my pets"
- [ ] "My pet passed away" shows a confirmation dialog: "Are you sure? [PetName] will be moved out of your active pets. All their history is kept." with Confirm and Cancel
- [ ] Confirming sets status to passed_away; pet disappears from the active pets list immediately
- [ ] After confirming "passed away": success popup appears with message "[PetName] has been moved to Inactive. All their history is safe." with a close button
- [ ] "Remove from my pets" shows a confirmation dialog: "Remove [PetName] from your list? You can still find them in your Inactive pets." with Confirm and Cancel
- [ ] Confirming sets status to removed; pet disappears from the active pets list immediately
- [ ] After confirming "remove": success popup appears with message "[PetName] has been removed from your active pets." with a close button
- [ ] Both success popups include an "Undo" button that restores the pet to active status and closes the popup
- [ ] Undo is only available from the success popup; once the popup is dismissed it is gone
- [ ] Neither action deletes any data (photos, events, measurements are all preserved)

### Phase 2 (future -- Inactive tab)
- [ ] Pets screen gains a second tab: Active | Inactive
- [ ] Inactive tab shows all pets with status passed_away or removed
- [ ] Each inactive pet shows a label indicating its status ("Passed away" or "Removed")
- [ ] Each inactive pet has a "Restore to active" button that sets status back to active and moves the pet back to the Active tab
- [ ] Restoring shows a success popup: "[PetName] is back in your active pets!"
- [ ] From Inactive, user can permanently delete a pet; tapping delete shows a confirmation dialog with the text: "Permanently remove [PetName]? All photos, events, and history will be deleted. This cannot be undone." with a text input requiring the user to type the pet name, and buttons "Delete permanently" and "Cancel"
- [ ] On confirm, success popup shows: "[PetName] has been removed."
- [ ] Hard delete removes all associated data visible to the user: pet record, events, photos, measurements
- [ ] Dev: even hard delete is a soft delete in the database -- data is flagged as deleted, not physically removed. The user-facing language says permanent; the DB implementation preserves data for safety.

## Button design
Both buttons are pinned to the bottom of the screen as a fixed footer, full width, stacked vertically. They stay in place regardless of how much content is above, and remain visible even as the profile grows with more fields.

- "My pet passed away" -- ghost button, neutral dark color; not red, this is an emotional moment not a destructive action
- "Remove from my pets" -- ghost button, red (#BE4B37); signals a more permanent-feeling decision

## Screens
- PetProfileScreen: gains two buttons at the bottom (Phase 1)
- PetListScreen: gains Active / Inactive tabs (Phase 2)

## Navigation
- PetProfileScreen "My pet passed away" -> confirmation dialog -> back to PetListScreen (active tab)
- PetProfileScreen "Remove from my pets" -> confirmation dialog -> back to PetListScreen (active tab)
- PetListScreen Inactive tab -> list of inactive pets -> PetProfileScreen (read-only, no lifecycle buttons shown)
- PetProfileScreen (inactive pet) -> hard delete option in menu or at bottom

## Empty / Error States
- Active tab empty: same as current PetListScreen empty state ("You have no pets yet")
- Inactive tab empty: "No inactive pets" (no action needed)
- Status change fails: toast "Something went wrong. Please try again." Pet status unchanged.

## Out of Scope
- Exporting pet data before deletion
- Memorial / tribute screen for passed away pets (future idea)
