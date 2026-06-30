# Feature: Photo Gallery
Status: Ready

## Goal
Give users a place to store pet photos and access documents from vet visits, all within the pet profile.

## User Stories
- As a user, I want to browse all photos of my pet in one place.
- As a user, I want to add new photos from my camera or device.
- As a user, I want to access vet documents and analysis results attached to my pet's events.

## Gallery tab structure
The Gallery tab on PetProfileScreen contains two sub-tabs:

| Sub-tab | Content | Default |
|---|---|---|
| Photos | Pet lifestyle photos; uploaded by user | Yes -- opens first |
| Documents | Photos and PDFs attached to events (vet visits, analyses, etc.) | No |

---

## Sub-tab: Photos

### Behavior
- Grid layout, most recent photo first
- Tap any photo to open full-screen view
- Full-screen view: swipe left/right to navigate between photos
- Long press or full-screen view shows delete option
- Upload via "+" button: choose between camera and device gallery

### Acceptance Criteria
- [ ] Photos sub-tab is the default view when Gallery tab opens
- [ ] Photos displayed as a grid, most recent first
- [ ] Tapping a photo opens it full-screen
- [ ] In full-screen view, user can swipe left/right to navigate between photos
- [ ] In full-screen view, user can delete the photo with a confirmation: "Delete this photo?" with Delete and Cancel
- [ ] A "+" button is visible on the Photos sub-tab
- [ ] Tapping "+" shows two options: "Take photo" and "Choose from gallery"
- [ ] After upload, new photo appears at the top of the grid immediately
- [ ] Upload failure shows toast: "Could not upload photo. Please try again."
- [ ] Empty state: illustration + "No photos yet" + "Add your first photo" button

---

## Sub-tab: Documents

### Behavior
Documents are photos and PDFs attached to events (vet visits, grooming, etc.).
They cannot be uploaded directly from this tab -- they are added when creating or editing an event.
This tab is read-only for now.

### Acceptance Criteria
- [ ] Documents sub-tab shows all files attached to this pet's events
- [ ] Each document shows: thumbnail (photo) or PDF icon, event name, event date
- [ ] Tapping a document opens it full-screen (photo) or in a PDF viewer
- [ ] Empty state: "No documents yet. Documents are added when you create an event." with a button "Go to Calendar"
- [ ] No upload or delete action available directly from this tab (managed via events)

### Out of scope for this feature
- Document upload from Documents tab (added together with Event Calendar feature)
- Deleting documents from this tab (managed via the event they belong to)

---

## Screens
- PetProfileScreen Gallery tab: contains Photos and Documents sub-tabs

## Navigation
- PetProfileScreen Gallery tab -> Photos sub-tab (default)
- PetProfileScreen Gallery tab -> Documents sub-tab
- Documents sub-tab empty state "Go to Calendar" button -> Calendar tab (when it exists)
- Full-screen photo: back arrow -> returns to photo grid

## Out of Scope
- Captions on photos
- Photo albums or folders
- Sharing photos externally (logged in ideas.md -- part of the social feature)
- Video support
