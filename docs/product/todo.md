# To Do

Things that need to happen but are not being worked on right now. Add items freely.

---

## Apple Sign-In
- **Status:** Not done
- **Why it matters:** Apple requires Sign in with Apple on any app that offers third-party social login (Google). Rejection risk if missing at App Store submission.
- **What is needed:** Apple Developer account, then dev wires up the existing Sign in with Apple package.
- **Owner:** Dev (once Apple Developer account is available)

## Active / Inactive tabs in Pets screen (Phase 2 of Pet Lifecycle)
- **Status:** Not done
- **Why it matters:** Pets with status passed_away or removed need somewhere to live. Phase 2 of 008-pet-lifecycle.md specifies the Active / Inactive tab structure and hard delete flow.
- **What is needed:** 008-pet-lifecycle.md Phase 2 to be picked up by dev.
- **Owner:** Dev

## Notification badge on pet avatars in topbar
- **Status:** Not done
- **Why it matters:** Each pet avatar in the home screen topbar should show an unread notification count badge.
- **What is needed:** Push notification infrastructure to exist first; then badge count pulled from unread notifications per pet.
- **Owner:** Dev (after notifications are shipped)

## Privacy Policy
- **Status:** Not done
- **Why it matters:** Required by both App Store and Google Play. Must be a publicly accessible URL linked in the store listing.
- **What is needed:** Write a privacy policy covering data collected (account info, pet data, photos), storage location, and deletion rights. Host it publicly.
- **Owner:** To be decided
