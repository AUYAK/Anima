# Feature: Edit Pet
Status: Ready

## Goal
Allow users to update any field on a pet's profile directly from the General Info tab without navigating to a separate screen.

## User Stories
- As a user, I want a clear way to enter edit mode so I know my changes are intentional.
- As a user, I want to edit multiple fields at once and save them all together.
- As a user, I want to cancel editing without saving if I changed my mind.

## Inline editing pattern
A pencil icon sits in the top-right corner of the PetProfileScreen header, visible on all tabs.
Tapping it switches the General Info tab into edit mode -- all fields become editable simultaneously.
The pencil icon is replaced by Save and Cancel in the header.

Tapping Save commits all changes and returns to view mode.
Tapping Cancel discards all changes and returns to view mode.
If the user taps back or switches tabs while in edit mode, a dialog appears: "You have unsaved changes. Save or discard?" with Save and Discard buttons.

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
| Additional info | Multi-line text input |

## Acceptance Criteria
- [ ] A pencil icon is visible in the top-right corner of PetProfileScreen header
- [ ] Tapping the pencil icon switches General Info tab to edit mode; all fields become editable simultaneously
- [ ] In edit mode, the pencil icon is replaced by Save and Cancel in the header
- [ ] Tapping Save commits all changes; success toast appears: "Changes saved"; screen returns to view mode
- [ ] Tapping Cancel discards all changes; screen returns to view mode with original values
- [ ] If user taps back or switches tabs in edit mode, dialog appears: "You have unsaved changes. Save or discard?"
- [ ] Save fails: toast "Something went wrong. Please try again." Screen stays in edit mode.
- [ ] Name cannot be saved empty: inline validation "Name is required"
- [ ] Species cannot be saved empty: inline validation "Species is required"

## Screens
- PetProfileScreen: gains pencil icon in header; General Info tab gains edit mode state

## Navigation
No new screens. All editing happens inline on PetProfileScreen.

## Out of Scope
- Editing the pet's name directly from the profile header (done via edit mode on General Info tab)
- Per-field save (all changes saved together with one Save button)
- Editing weight (weight lives in the measurements table; editing belongs to Growth Tracking feature 005)
