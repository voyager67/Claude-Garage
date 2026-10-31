---
name: launch
description: Pre-release checklist and release writing. Verifies tests, docs and version, drafts the changelog and release notes, and never tags or pushes without confirmation.
argument-hint: "[patch | minor | major]"
---

# /launch: ship it

## Steps
1. **Gate checks**: run the test command; check for uncommitted changes; run `/garage:audit` logic if it was not run on this branch.
2. Delegate to `scribe`:
   - verify README commands and examples against the code
   - add a changelog entry (Keep-a-Changelog style) from commits since the last tag
   - draft release notes: headline, what is new, upgrade notes
3. Suggest the semantic version bump (or use `$ARGUMENTS`) and explain why.
4. Present the checklist below with pass or fail for each item.
5. **Ask for confirmation** before any version bump, tag or push. Never do these silently.

## Checklist
- [ ] Tests pass
- [ ] No secrets in the diff
- [ ] README and examples verified
- [ ] Changelog updated
- [ ] Version bumped
- [ ] Release notes drafted
- [ ] Known risks listed in the notes
