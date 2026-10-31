---
name: firefight
description: Fix a bug or incident by root cause. Investigators work in parallel with competing hypotheses and try to disprove each other, then the surviving cause gets a minimal fix and a regression test.
argument-hint: "<symptom, error message or failing test>"
---

# /firefight: find the real cause

## Steps
1. Restate the symptom from `$ARGUMENTS`. Ask for a reproduction only if one cannot be found.
2. **Easy bug** (obvious single cause after a quick look): one `detective` reproduces, finds the cause and proposes the fix.
3. **Tough bug** (unclear, intermittent, or several suspects): launch **two or three `detective` agents in parallel**, each assigned a different hypothesis. Each must:
   - state the hypothesis and the cheapest observation that would **disprove** it
   - run that observation
   - report evidence for and against
4. Compare the reports. Hypotheses that were disproved are dropped. The survivor is the root cause. If more than one survives, run the next cheapest discriminating test.
5. Show the diagnosis first. With the user's go-ahead, delegate the fix to `builder` along with a regression test written first.
6. Re-run the original reproduction to prove it is fixed.
7. Append a line to `.garage/lessons.md`: `When <situation>, <what to do>`.

## Rules
- No fix before a root cause. "It works now" is not a diagnosis.
- Keep the fix minimal. Refactors are a separate pitch (`/garage:tidy`).
