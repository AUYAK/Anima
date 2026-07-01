# Feature: Home Dashboard
Status: Ready

## Goal
Give the user a home screen with all their pets visible in the topbar, sorted by activity, so they can quickly jump to any pet.

## User Stories
- As a user, I want to see all my pets in the topbar after login so I can navigate to any of them quickly.
- As a user, I want the most active pet shown first so I see what is most relevant.
- As a new user with no pets, I want the home screen to prompt me to add my first pet.

## Topbar design
The topbar is a horizontally scrollable row of pet avatars, styled similarly to Instagram Stories:
- Each avatar is a circular photo (or paw icon placeholder if no photo set)
- Pet name displayed below the avatar
- Avatars are larger than a standard icon -- prominent enough to be a key navigation element
- Row scrolls horizontally if the user has many pets
- Sorted left to right by most recently updated (most recent on the left)
- Dev: sort by `updated_at` desc; add `updated_at` column to pets table via migration if not present; will switch to notification-based sorting when push notifications are shipped (see todo.md)

The stories row sits at the very top of the screen with no AppBar above it -- same pattern as Instagram. HomeScreen has no AppBar for now. Actions (notifications, settings) will be added to an AppBar when future features require them.

## Acceptance Criteria
- [ ] After login the user lands on the Home screen
- [ ] The topbar shows all the user's pets as a horizontal scrollable row of avatars
- [ ] Each avatar shows the pet's photo (or paw icon placeholder) with the pet's name below it
- [ ] Pets are sorted left to right by most recently updated, most recent on the left
- [ ] Tapping any pet avatar navigates to that pet's profile screen
- [ ] If the user has no pets, the topbar shows a single placeholder avatar with the label "Add your first pet"
- [ ] Tapping the placeholder navigates to the Add Pet screen
- [ ] The rest of the home screen body is empty for now (future features will fill it)

## Screens
- HomeScreen: main screen after login; contains the topbar row and an otherwise empty body

## Navigation
- Successful login -> HomeScreen
- HomeScreen pet avatar tap -> PetProfileScreen for that pet
- HomeScreen placeholder tap (no pets) -> AddPetScreen
- Bottom nav Home tab -> HomeScreen

## Empty / Error States
- No pets: single placeholder avatar + "Add your first pet"; body is blank
- Pet photo not set: circular paw icon placeholder

## Out of Scope
- Notification badge count on avatars (logged in todo.md -- needs notification infrastructure first)
- Social sharing or viewing other users' pets (logged in ideas.md)
- Upcoming events or reminders on the home screen (part of Event Calendar feature)
- Onboarding flow for new users
