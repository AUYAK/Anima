# Feature: Localization
Status: Ready

## Goal
Make the app display in the user's language automatically so that Russian-speaking users see Russian and everyone else sees English.

## User Stories
- As a Russian-speaking user, I want the app to be in Russian without changing any settings.
- As an English-speaking user, I want the app to be in English by default.
- As a Belarusian user, I want the app to be in Russian, as it is the closest supported language.

## Acceptance Criteria
- [ ] App detects the device system language on launch
- [ ] If system language is Russian or Belarusian, all app text displays in Russian
- [ ] If system language is anything else, all app text displays in English
- [ ] Language applies to: labels, buttons, placeholders, validation messages, empty states, error messages, toasts
- [ ] All screens built before this feature shipped are translated: Auth, Home Dashboard, Pet Profile
- [ ] All screens built after this feature ships use both languages from the start
- [ ] No in-app language selector is shown to the user
- [ ] Switching device language and restarting the app updates the app language

## Screens
All existing and future screens are affected. No new screens introduced by this feature.

## Navigation
No navigation changes.

## Empty / Error States
All existing empty and error state strings must be translated into Russian.

## Out of Scope
- Manual in-app language switcher
- Languages beyond Russian and English
- Regional date or number format changes
