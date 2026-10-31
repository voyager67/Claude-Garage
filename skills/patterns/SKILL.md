---
name: patterns
description: Discover the conventions and recurring patterns already in a codebase and turn them into documented patterns and suggested house rules. Use to learn how a team really writes code.
argument-hint: "[area, for example 'error handling' or 'api routes']"
---

# /patterns: learn how this codebase thinks

## Steps
1. Scope: `$ARGUMENTS` or the whole repo. Delegate to `scout` to sample representative files, and to `architect` to name the patterns.
2. For each pattern found write: **name, where it appears (file paths), the rule of thumb, one short example, and any deviations**.
3. Save to `.garage/patterns.md`.
4. Suggest up to 5 patterns worth turning into house rules, and offer: `/garage:rules add "<rule>"`.

## Rules
- Report what the code *does*, not what you wish it did.
- Cite file paths. Say "inconsistent" when the codebase disagrees with itself.
