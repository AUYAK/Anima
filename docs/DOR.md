# Definition of Ready (DOR)

A feature is ready for development when all items below are checked.
The PM completes this checklist before handing off to dev.

## Checklist

### 1. Goal
- [ ] The purpose of the feature is described in one sentence
- [ ] It is clear which user problem it solves

### 2. User Stories
- [ ] At least one user story in format: "As a [user], I want [action] so that [benefit]"
- [ ] Edge cases are covered (empty state, error state, no data)

### 3. Acceptance Criteria
- [ ] Each criterion is testable (pass/fail)
- [ ] Success scenario is described
- [ ] At least one failure/validation scenario is described

### 4. Screens
- [ ] List of screens involved
- [ ] Navigation flow described (what leads to this screen, where it goes after)
- [ ] Empty state described

### 5. Out of scope
- [ ] What is explicitly NOT part of this feature

---

## Feature file template

```markdown
# Feature: [Name]
Status: Draft | Ready | In Progress | Done

## Goal
[One sentence]

## User Stories
- As a [user], I want [action] so that [benefit]

## Acceptance Criteria
- [ ] ...
- [ ] ...

## Screens
- ScreenName — [brief description]

## Navigation
[What triggers this screen → what happens after]

## Empty / Error States
- Empty: [what the user sees]
- Error: [what the user sees]

## Out of Scope
- ...
```