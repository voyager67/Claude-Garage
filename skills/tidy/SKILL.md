---
name: tidy
description: Behavior-preserving cleanup. Improves structure, naming and duplication in small steps with tests green after each step, and stops at the first red.
argument-hint: "<file, folder or smell to fix>"
---

# /tidy: refactor without changing behavior

## Steps
1. Scope: `$ARGUMENTS`. Delegate to `scout` for usages and `critic` for the top smells (duplication, long functions, unclear names, dead code).
2. **Baseline:** run the tests. If they are not green, stop and suggest `/garage:test` first. If there are no tests around the target, have `tester` write **characterization tests** that pin current behavior.
3. Propose a numbered list of small refactor steps. Ask the user to approve.
4. For each step, delegate to `builder`: make one change, run tests, and only continue if green. If a step turns tests red, **revert that step** and report why.
5. Final run of the full suite and a short before/after summary.

## Rules
- Behavior must not change. No new features, no bug fixes (report bugs you find as parked items).
- One kind of change per step: rename, extract, inline, move, delete dead code.
- Public interfaces stay the same unless the user explicitly approves a change.
