---
name: garage-init
description: One-time setup. Creates the .garage workspace, seeds lessons.md, detects the test command, and offers house rules plus an optional output style.
---

# /garage-init: open the garage

## Steps
1. Create `.garage/pitches/` and `.garage/lessons.md` (with a one-line header) if they do not exist.
2. Detect the project's test command and write `.garage/config.md` with `test: <command>`. Ask the user if it is ambiguous.
3. Offer, using the interactive question tool: create house rules now (`/garage:rules`), skip, or later.
4. Offer to append the snippet below to `CLAUDE.md`. **Ask first. Never overwrite existing content.**
5. Suggest committing `.garage/` so the lessons become shared memory, or adding it to `.gitignore` if the user prefers private plans.
6. Mention the optional output styles (`garage-rush`, `garage-mentor`) and the statusline from the README.
7. Finish with: `Try: /garage:guide` or `/garage:pitch "<your idea>"`

## CLAUDE.md snippet
```markdown
## Garage house rules
- Pitch before code for anything larger than a bug fix.
- Smallest correct diff. Tests first when a framework exists.
- Never claim success without a command that proves it.
- Out-of-scope ideas go to the Parked list, not into the diff.
- Read .garage/lessons.md and .garage/rules.md before non-trivial work.
```
