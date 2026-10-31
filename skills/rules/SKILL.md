---
name: rules
description: Create or update the project's house rules (guardrails) in .garage/rules.md through a short interview. The rules are checked automatically by blueprint, sprint, preflight and audit.
argument-hint: "[add <rule> | review]"
---

# /rules: your project's guardrails

## Steps
1. If `.garage/rules.md` exists and `$ARGUMENTS` is empty, show it and ask whether to add, change or remove rules.
2. If `$ARGUMENTS` starts with `add`, append that rule in the standard format and stop.
3. Otherwise delegate to `scout` to detect the stack, the lint and test setup and obvious conventions.
4. Interview the user with the interactive question tool, **one short round of at most 4 questions**: language and framework constraints, testing expectations, security boundaries, things that must never happen.
5. Write `.garage/rules.md`.

## Rule format
```markdown
# House rules
- **R1 MUST** every public function has a test.
- **R2 NEVER** commit secrets or `.env` files.
- **R3 SHOULD** keep functions under 40 lines.
- **R4 ASK FIRST** before adding a new dependency.
```
Four levels: **MUST**, **NEVER**, **SHOULD**, **ASK FIRST**. Each rule has an id and is one sentence, testable by reading code.

## Enforcement (done by other commands)
`/blueprint` writes a rules check. `/sprint` hands rules to builders. `/preflight rules` and `/audit` report violations by rule id.
