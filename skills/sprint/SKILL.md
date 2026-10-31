---
name: sprint
description: Execute a pitch or blueprint. Auto-detects the lane (S, M or L), runs up to three builders in parallel on disjoint slices, checks for drift against the plan, runs blind scenarios for L work and parks scope creep.
argument-hint: "<pitch id> [--timebox 2h]"
---

# /sprint: build it

## Detect the lane
Inspect `.garage/pitches/<id>-*/`:
- only `pitch.md` → **S (Patch):** build straight from the pitch in one to three tasks
- `blueprint.md` → **M (Standard):** build slice by slice in waves
- `blueprint.md` and `scenarios/` → **L (Crew):** waves plus blind scenarios

## Steps
1. Create or resume `sprint.md` beside the pitch with a checkbox per slice or task. Running `/sprint <id>` again always resumes from the unchecked items.
2. Read `.garage/rules.md` and `.garage/lessons.md` if present. Pass the relevant rules to every builder.
3. Ask once: "Commit after each slice? (y/N)". Default is no. Offer a feature branch if on `main`.
4. Group slices into **waves**. A wave contains slices whose dependencies are done. Run slices in parallel only if the blueprint marks them parallel-safe. **Never more than 3 builders at once.**
5. Delegate each slice to a `builder` with: the slice, its acceptance check, the files it may touch and the relevant rules. Builders never see `scenarios/`.
6. After each wave:
   - run the test command
   - **drift check:** compare what changed with the blueprint. Flag scope creep, missing items and contradictions, then ask: update the plan or fix the code?
   - **L only:** `tester` runs the blind scenarios. On failure, send findings (not the scenario text) back to the builder. Retry at most twice, then ask the user.
   - tick finished slices in `sprint.md`
7. Anything out of scope goes into `## Parked` in `sprint.md`. Do not build it.
8. Respect the time-box if given. At the limit, stop and summarize what is left.

## Ownership
If tests fail, fix them. "It was already failing" is not an acceptable report; you touched the codebase, you own the result. The only exception is a failure caused by something external (network, credentials), which you report precisely.

## Finish
Print: slices done, left, parked ideas, test status. Then: `Next: /garage:break <id>` and `/garage:audit`
