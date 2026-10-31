---
name: preflight
description: Quality gate for a pitch and blueprint before building. Scores them for completeness, consistency and correctness (testability), and optionally checks house-rule compliance. Advisory, never blocking.
argument-hint: "<pitch id> [rules]"
---

# /preflight: check the plan before you build

## Steps
1. Load the pitch and blueprint for `$ARGUMENTS` (and `scenarios/` for size L).
2. Delegate review to `critic` (and `pm` for the pitch). Score each of the three Cs:
   - **Complete:** all sections filled, slices have acceptance checks, risks named
   - **Consistent:** pitch, blueprint and scenarios do not contradict each other; non-goals are respected
   - **Correct:** every requirement is testable and achievable; slice dependencies make sense
3. If `rules` is passed (or `.garage/rules.md` exists), list each rule with pass, fail or n/a.
4. Print a scorecard with a short fix list. Example:
   ```
   Complete   ██████░░░░  3/5  missing risks for S4
   Consistent █████████░  4/5  S2 touches a non-goal
   Correct    ███████░░░  3/5  metric has no measurement method
   ```
5. Finish with the next step. Preflight is **advisory**: the user decides whether to proceed.
