---
name: recon
description: Map an unfamiliar codebase in one page, including structure, entry points, how to run and test, conventions and gotchas. Use when joining or inheriting a project.
argument-hint: "[subdirectory or focus area]"
---

# /recon: understand before you touch

## Steps
1. Delegate to `scout` (scope: `$ARGUMENTS` if given, otherwise the whole repo).
2. Write `.garage/recon.md`, at most one page:
   - **What it is** (2 lines)
   - **Layout** (top-level folders and their jobs)
   - **Entry points**
   - **Run and test commands**
   - **Conventions**
   - **Hot spots and gotchas**
3. Show the user a 5-line summary and the file path.

## Rules
- Cite file paths. Say "unclear" instead of guessing.
