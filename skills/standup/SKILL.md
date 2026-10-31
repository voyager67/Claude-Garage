---
name: standup
description: Instant status report from git history and .garage state. What shipped, what is in progress, what is blocked, and what to do next.
---

# /standup: where are we?

## Steps
1. Read `git log --since="2 days ago" --oneline` and `git status --short`.
2. Read any `sprint.md` files under `.garage/pitches/` for unchecked slices and parked items.
3. Print at most 10 lines:
   - **Shipped:**
   - **In progress:**
   - **Blocked or risky:**
   - **Do next:** one concrete command, for example `/garage:sprint 002`

Keep it short. This is a stand-up, not a report.
