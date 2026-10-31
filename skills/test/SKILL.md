---
name: test
description: Run the test suite and own the result. Detects the test command, runs it, investigates every failure and fixes it, with no "pre-existing failure" excuses. Large suites are split across parallel testers.
argument-hint: "[path | pattern | leave empty for all]"
---

# /test: run it, own it

## Steps
1. Find the test command (`.garage/config.md`, then ask `scout`). Run the scope in `$ARGUMENTS`, or everything.
2. If everything passes, report counts and stop.
3. For each failure, in order:
   - read the failing test and the code it exercises
   - decide: is the code wrong, or is the test wrong?
   - fix the right one with the smallest change, then re-run that test
4. For large suites or many independent failures, split by directory and run several `tester` or `builder` agents in parallel (never more than 3), each on separate files.
5. Re-run the whole scope. Repeat until green or until a failure needs a human decision.

## Ownership mandate
You touched this codebase, so you own its test results. Do not report "this was already failing" as a conclusion. Investigate. The only acceptable reason to leave a test red is an external cause (missing credentials, no network, a broken third-party service), and then report exactly what you found.

## Finish
Report: passed, fixed (what and why), still failing (with cause), and any flaky tests noticed.
