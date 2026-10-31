---
name: brainstorm
description: Explore a fuzzy idea before committing to it. Generates conservative, ambitious and unconventional options, compares them and helps you pick one to pitch.
argument-hint: "<topic or problem>"
---

# /brainstorm: think wide, then narrow

## Steps
1. Restate the topic in one sentence. Delegate to `scout` for what already exists.
2. Generate **three distinct options**, not variations of one idea:
   - **Safe:** smallest change that works
   - **Ambitious:** the version you would build with unlimited time
   - **Weird:** a lateral approach that questions an assumption
3. For each: one-line pitch, effort (S, M or L), biggest risk, what you learn quickly.
4. Ask the user to choose or combine, using the interactive question tool with the three options plus "none, keep exploring".
5. Save the result to `.garage/brainstorms/<slug>.md`.
6. Finish with: `Next: /garage:pitch "<chosen option>"`

## Rules
- No code, no stack debates. This is about *what*, not *how*.
- Be honest about weak ideas. A rejected option with a reason is a good outcome.
