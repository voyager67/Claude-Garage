---
name: pr
description: Prepare a pull request from your branch. Writes a clear title and description with the why, evidence, risks and a reviewer checklist. Never opens the PR without confirmation.
argument-hint: "[base branch, default main]"
---

# /pr: make it easy to review

## Steps
1. Gather: `git log <base>..HEAD`, `git diff <base>...HEAD --stat`, the linked pitch and any audit or break report.
2. Delegate to `scribe` to write `.garage/pr-draft.md`:
   - **Title:** under 70 characters, imperative
   - **Why:** the problem and the outcome (from the pitch)
   - **What changed:** grouped by area, not by file
   - **Evidence:** test commands and results
   - **Risk and rollback**
   - **Reviewer checklist** and what to look at first
3. Show the draft. If the GitHub CLI is available and the user confirms, run `gh pr create` with the draft. Otherwise print the text to copy.

## Rules
- Do not push or open the PR without explicit confirmation.
- Never include secrets, internal URLs or raw logs.
