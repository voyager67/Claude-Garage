---
name: retro
description: Short retrospective that turns what just happened into durable lessons. Writes actionable "when X, do Y" rules to .garage/lessons.md that every other command reads.
argument-hint: "[pitch id | leave empty for recent work]"
---

# /retro: compound your learning

## Steps
1. Read recent `git log`, the sprint file, the break report, the audit verdict and the parked list.
2. Delegate to `pm` to answer: What went well? What cost us time? What surprised us? What would we change?
3. Distill **at most 5** lessons. Each must be an actionable rule: **When <situation>, do <action>**. Not a feeling.
4. Append them to `.garage/lessons.md` with today's date. Skip any lesson already present.
5. If a lesson is really a hard rule, offer to promote it with `/garage:rules add`.
6. Show the user the new rules.

## Rules
- Blameless. Talk about the process, never about people.
- Prune: if a lesson in the file is now wrong or obsolete, propose removing it.
