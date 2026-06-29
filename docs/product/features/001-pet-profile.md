# Feature: Pet Profile
Status: Ready

## Goal
Allow users to add pets to their account and view each pet's profile so they can start tracking care.

## User Stories
- As a user, I want to see a list of all my pets so I can pick which one to manage.
- As a user, I want to add a new pet so I can start recording its events and history.
- As a user, I want to view a pet's profile card so I can see its details at a glance.

## Acceptance Criteria
- [ ] User can see a list of all their pets via the Pets tab in the bottom navigation
- [ ] Each item in the pet list shows: photo (or placeholder), name, species, and age (calculated from date of birth if provided)
- [ ] User can tap a "+" button to open the Add Pet form
- [ ] Add Pet form requires: name (text), species (text)
- [ ] Add Pet form allows optionally: breed, date of birth, photo from camera roll, notes
- [ ] After saving, the new pet appears in the pet list immediately
- [ ] User can tap a pet in the list to open its profile card
- [ ] Pet profile card shows: photo (or placeholder), name, species, breed, date of birth, age, notes
- [ ] If date of birth is provided, age is shown as "X years Y months" or "X months" for young animals
- [ ] Empty pet list shows a friendly message and a prompt to add the first pet
- [ ] If saving a pet fails, the user sees an error message; form stays open with all input preserved
- [ ] Name field shows inline validation if submitted empty: "Name is required"
- [ ] Species field shows inline validation if submitted empty: "Species is required"

## Screens
- PetListScreen: full list of the user's pets; entry point from the Pets tab
- AddPetScreen: form to create a new pet
- PetProfileScreen: read-only view of a single pet's details

## Navigation
- Bottom nav Pets tab -> PetListScreen
- PetListScreen "+" button -> AddPetScreen
- AddPetScreen Save -> back to PetListScreen (new pet visible at top)
- AddPetScreen Cancel -> back to PetListScreen (no change)
- PetListScreen tap on pet card -> PetProfileScreen
- PetProfileScreen back -> PetListScreen

## Empty / Error States
- PetListScreen (no pets): friendly illustration + "You have no pets yet" + "Add your first pet" button
- Pet photo not set: circular placeholder with a generic paw icon
- Add Pet save error: toast message "Something went wrong. Please try again."
- Add Pet name validation: inline error below the field

## Out of Scope
- Editing an existing pet (separate feature)
- Deleting a pet (separate feature)
- Sorting or filtering the pet list
- Multiple photos per pet (covered in Photo Gallery feature)
- Sharing a pet profile
