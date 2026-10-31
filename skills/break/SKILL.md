---
name: break
description: Adversarial testing. The gremlin agent attacks recent changes with hostile inputs, edge cases and bad state, and proves each finding with a failing test.
argument-hint: "[pitch id | path | leave empty for the current git diff]"
---

# /break: try to break it

## Steps
1. Determine the target: a pitch id, a path, or by default the current `git diff` against the main branch.
2. Delegate to `gremlin` with the target and the project's test command (ask `scout` if unknown).
3. Gremlin writes a reproducing test for every suspected weakness. Tests that fail on purpose are kept in a clearly named file or marked as expected failures, so the suite stays understandable.
4. Collect results in `.garage/break-report.md` (or beside the pitch).

## Report format
| severity | what breaks | reproduction | one-line fix |
|---|---|---|---|

## Finish
Ask whether to fix blockers now. If yes, hand each blocker to a `builder`, then re-run the failing tests.
