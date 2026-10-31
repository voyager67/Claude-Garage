---
name: pitch
description: Turn a rough idea into a one-page pitch with target user, MVP scope, non-goals, success metric, kill criteria and a size (S, M or L) that picks the lane. Use before writing code for any new feature or product.
argument-hint: "<idea in one sentence> | <pitch id to resume>"
---

# /pitch: idea to one page

Goal: a pitch someone can read in 90 seconds.

## Steps
1. If `$ARGUMENTS` looks like a pitch id (for example `003`), load `.garage/pitches/003-*/pitch.md` and continue it. This is the **resume pattern**: run it again in a fresh conversation any time.
2. Read `.garage/lessons.md` and `.garage/rules.md` if they exist.
3. Delegate to `scout`: what already exists in this repo that overlaps with the idea?
4. Delegate to `pm` to shape scope. Ask the user **at most 3** sharp questions, and only about things nobody can infer. Prefer the interactive question tool with 2 to 4 concrete options each.
5. Delegate to `chief` to size the work (S, M or L) and show the reasoning. The user may override the size.
6. Write `.garage/pitches/NNN-slug/pitch.md` (NNN is the next free number, zero-padded) using the template below.
7. Print a 5-line summary. Finish with the next command for the chosen lane:
   - **S:** `/garage:sprint NNN`
   - **M or L:** `/garage:blueprint NNN`

## Template
```markdown
# <Title>
**Size:** S | M | L  (why)
**User:** who exactly has this problem
**Problem:** one sentence
**Outcome:** what is true when it works

## MVP
- at most 5 bullets

## Non-goals
- at least 3 things we are deliberately not doing

## Success metric
<one number, one deadline>

## Kill criteria
<evidence that would make us stop>

## Open questions
- ...
```

## Rules
- Under 300 words. No tech stack in a pitch.
- Non-goals and kill criteria are mandatory, except for size S where kill criteria may be "n/a".
- Skipped sections are logged as decisions ("skipped: reason"), never silently dropped.
