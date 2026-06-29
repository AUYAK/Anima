# Feature: Home Dashboard
Status: Ready

## Goal
Give the user a home screen with their current pet in the topbar so there is a meaningful landing point after login.

## User Stories
- As a user, I want to see my pet in the topbar after login so I know I am in the right place.
- As a user, I want to tap the topbar pet to open its profile quickly.
- As a new user with no pets, I want the home screen to prompt me to add my first pet.

## Acceptance Criteria
- [ ] After login the user lands on the Home screen
- [ ] The topbar shows the current pet's photo and name
- [ ] Tapping the topbar pet navigates to that pet's profile screen
- [ ] "Current pet" is the most recently added pet (or the only pet if there is one)
- [ ] If the user has no pets, the topbar shows a placeholder avatar and the text "Add your first pet"
- [ ] Tapping the placeholder topbar state navigates to the Add Pet screen
- [ ] The rest of the home screen body is empty for now (future features will fill it)

## Screens
- HomeScreen: main screen after login; contains the topbar and an otherwise empty body

## Navigation
- Successful login -> HomeScreen
- HomeScreen topbar (pet exists) -> PetProfileScreen
- HomeScreen topbar (no pet) -> AddPetScreen
- Bottom nav Home tab -> HomeScreen

## Empty / Error States
- No pets: topbar shows placeholder avatar + "Add your first pet" label; body is blank
- Pet photo not set: circular placeholder with a paw icon (same as pet list)

## Out of Scope
- Switching between pets in the topbar (see ideas.md)
- Upcoming events or reminders on the home screen (part of Event Calendar feature)
- Recent photos or activity feed (future iteration)
- Onboarding flow for new users
