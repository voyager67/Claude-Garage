---
name: blueprint
description: Turn a pitch into a technical blueprint with trade-offs, interfaces, file-level changes and small build slices marked parallel-safe or not. For size L it also creates blind acceptance scenarios. Use after /pitch for M and L work.
argument-hint: "<pitch id, e.g. 001>"
---

# /blueprint: pitch to plan

## Steps
1. Load `.garage/pitches/$ARGUMENTS-*/pitch.md`. If missing, list available pitches and stop. If the pitch is size **S**, say that no blueprint is needed and point to `/garage:sprint`.
2. Read `.garage/rules.md` if it exists. The blueprint must comply, and every conflict must be called out.
3. Delegate to `scout` for existing patterns, the test command and conventions.
4. Delegate to `architect` to write `blueprint.md` next to the pitch. Involve `pixel` for user-facing work and `rigger` for infra or delivery changes.
5. **Size L only:** delegate to `tester` to write blind scenarios to `scenarios/<slice-id>/*.md` (Given / When / Then). Tell the user these are hidden from builders on purpose.
6. Show the approach, the rejected alternative and the slice list. Ask for approval or changes.

## Blueprint must contain
1. **Approach** (what and why, under 10 lines)
2. **Alternatives considered** (at least two, with the reason for rejecting one)
3. **Interfaces and data shapes**
4. **File-level change list**
5. **Risks** and how each is contained
6. **Test strategy** and the exact test command
7. **Rules check** (which house rules apply and how they are met)
8. **Slices**: a table `id | goal | files | depends on | parallel-safe | acceptance check`

## Rules
- Each slice is finishable in about an hour.
- Two slices are parallel-safe only if they touch **disjoint files**.
- No production code in the blueprint, only signatures.

Finish with: `Next: /garage:preflight NNN` (optional quality gate) or `/garage:sprint NNN`
