---
name: audit
description: Adaptive parallel review before merge. Security, quality and tests are always reviewed; concurrency, dependencies, UI and infrastructure specialists join automatically when the diff calls for them. Returns one ranked verdict.
argument-hint: "[base branch, default main]"
---

# /audit: review before you merge

## Steps
1. Compute the change set: `git diff <base>...HEAD` (default base `main`). If it is empty, say so and stop.
2. Read `.garage/rules.md` if present and check compliance.
3. Launch these **in parallel**:
   - `sentinel`: security
   - `critic`: quality and design drift (against the blueprint if one exists)
   - `tester`: coverage gaps for the changed code
4. Add specialists **only when the diff warrants it**:
   | If the diff contains | Add |
   |---|---|
   | async code, threads, queues, locks | `gremlin` with a concurrency focus |
   | dependency or lockfile changes | `sentinel` with a supply-chain focus |
   | UI, templates, styles | `pixel` for accessibility and states |
   | CI, Dockerfile, infra, env config | `rigger` |
5. Merge all reports into one de-duplicated, ranked list:
   - **Blocker:** must fix before merge
   - **Should fix**
   - **Nit**
6. Give a verdict: `SHIP`, `FIX FIRST` or `RETHINK`, with a one-sentence reason.

## Rules
- Every finding names a file and line and has a suggested fix.
- Do not edit code during an audit.
- Praise at least one thing that is genuinely good.
