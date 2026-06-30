# Feature: Edit Pet
Status: Ready

## Goal
Allow users to update any field on a pet's profile directly from the General Info tab without navigating to a separate screen.

## User Stories
- As a user, I want to see which fields I can edit so I don't have to guess.
- As a user, I want to edit a single field without affecting the rest of the profile.
- As a user, I want to save my changes and get confirmation that they were saved.

## Inline editing pattern
Each field on the General Info tab has a small pencil icon on the right side of the row.
Tapping the pencil icon (or anywhere on the field row) makes that field editable inline.
The rest of the fields remain in view mode while one field is being edited.

When any field is in edit state:
- A "Save changes" button appears at the bottom of the General Info tab (above the lifecycle buttons)
- A "Cancel" option dismisses the edit and reverts the field to its previous value
- If the user navigates away with unsaved changes, a dialog appears: "You have unsaved changes. Save or discard?" with Save and Discard buttons

Dev: confirm placement of Save / Cancel controls with PM before building.

## Editable fields
All fields on General Info tab are editable except Age (calculated, never entered manually):

| Field | Edit control |
|---|---|
| Photo | Existing camera icon already handles this |
| Name | Text input |
| Species | Searchable dropdown (same as AddPetScreen) |
| Breed | Searchable dropdown filtered by species |
| Gender | Selector: Male / Female / Unknown |
| Date of birth | Date picker |
| Weight | Numeric input (kg) |
| Additional info | Multi-line text input |

## Acceptance Criteria
- [ ] Every editable field on the General Info tab shows a small pencil icon on the right
- [ ] Tapping the pencil icon or the field row makes that field editable inline
- [ ] Only one field is in edit mode at a time; tapping another field's pencil saves the current pending change first
- [ ] While a field is being edited, a "Save changes" button is visible at the bottom of the tab
- [ ] Tapping "Save changes" saves all pending edits and returns all fields to view mode
- [ ] Tapping "Cancel" reverts the field to its previous value with no changes saved
- [ ] If the user taps back or switches tabs with unsaved changes, a dialog appears: "You have unsaved changes. Save or discard?"
- [ ] After saving, a success toast appears: "Changes saved"
- [ ] If saving fails, a toast appears: "Something went wrong. Please try again." Field stays in edit mode.
- [ ] Name field cannot be saved empty: inline validation "Name is required"
- [ ] Species field cannot be saved empty: inline validation "Species is required"

## Screens
- PetProfileScreen General Info tab: gains pencil icons per field and inline edit state

## Navigation
No new screens. All editing happens inline on PetProfileScreen.

## Empty / Error States
- Save error: toast "Something went wrong. Please try again."
- Unsaved changes on back/tab switch: dialog "You have unsaved changes. Save or discard?" with Save and Discard buttons

## Out of Scope
- Editing the pet's name from the profile header (name is editable via the General Info tab field)
- Bulk edit mode (editing multiple fields simultaneously with a single save)
