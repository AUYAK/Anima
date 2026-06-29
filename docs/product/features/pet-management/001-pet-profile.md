# Feature: Pet Profile
Status: Ready

## Goal
Allow users to add pets to their account and view each pet's profile so they can start tracking care.

## User Stories
- As a user, I want to see a list of all my pets so I can pick which one to manage.
- As a user, I want to add a new pet so I can start recording its events and history.
- As a user, I want to view a pet's profile card so I can see its details at a glance.

## Pet profile fields

| Field | Required | Notes |
|---|---|---|
| Photo | No | From camera roll; paw icon placeholder if not set |
| Name | Yes | |
| Species | Yes | Searchable dropdown with seed data; custom text allowed if not in list |
| Breed | No | Searchable dropdown filtered by selected species; custom text allowed if not in list |
| Gender | No | Options: Male, Female, Unknown |
| Date of birth | No | |
| Age | No | Calculated from date of birth; not entered by user |
| Weight | No | Numeric with unit (kg); saved as the first Growth Tracking entry for this pet |
| Additional info | No | Free text; Dev: maps to existing notes field |

## Acceptance Criteria
- [ ] User can see a list of all their pets via the Pets tab in the bottom navigation
- [ ] Each item in the pet list shows: photo (or placeholder), name, species, and age (if date of birth is set)
- [ ] User can tap a "+" button to open the Add Pet form
- [ ] Add Pet form requires: name, species
- [ ] Add Pet form allows optionally: photo from camera roll (real upload), breed, gender, date of birth, weight, additional info
- [ ] Species field is a searchable dropdown: user can scroll the list or type to filter; selecting a value from the list saves that value; typing something not in the list saves the custom text directly
- [ ] Breed field behaves the same as species but its list is filtered based on the selected species; if species is a custom value, breed field accepts free text only
- [ ] Gender field is a selector with three options: Male, Female, Unknown
- [ ] Weight field accepts a number; unit is kg; saved as the first Growth Tracking entry for this pet
- [ ] After saving, the new pet appears in the pet list immediately
- [ ] User can tap a pet in the list to open its profile card
- [ ] Pet profile card shows all fields that were filled in; empty optional fields are hidden
- [ ] If date of birth is provided, age is shown as "X years Y months" or "X months" for young animals
- [ ] Empty pet list shows a friendly message and a prompt to add the first pet
- [ ] If saving a pet fails, the user sees an error message; form stays open with all input preserved
- [ ] Name field shows inline validation if submitted empty: "Name is required"
- [ ] Species field shows inline validation if submitted empty: "Species is required"

## Species and breed seed data
Dev: species and breeds must be stored in the database (not hardcoded in the app) so we can add more without a new release. Suggested structure: a `species` table and a `breeds` table with a species reference. Populate with seed data at migration time.

Starter species list (expand as needed): Cat, Dog, Rabbit, Parrot, Hamster, Guinea pig, Turtle, Fish, Snake, Ferret, Chinchilla, Lizard, Frog, Hedgehog.

Breeds should cover at minimum the most common species (cat and dog). Dog breeds alone number 300+; seed with the most popular 50-100 to start.

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
- Add Pet species validation: inline error below the field

## Out of Scope
- Editing an existing pet (separate feature)
- Deleting a pet (separate feature)
- Sorting or filtering the pet list
- Multiple photos per pet (covered in Photo Gallery feature)
- Sharing a pet profile
- Weight history chart (covered in Growth Tracking feature)
