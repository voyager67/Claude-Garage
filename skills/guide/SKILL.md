---
name: guide
description: Interactive command finder. Asks what you want to do, checks the state of your .garage workspace, recommends the right command and offers to start it. Use whenever you are unsure what to run.
---

# /guide: tell me where to go

## Steps
1. Quickly check state: does `.garage/` exist? any pitches with unchecked sprint items? uncommitted changes?
2. Ask with the interactive question tool: **"What are you trying to do?"**
   - Build something new
   - Fix something broken
   - Understand or improve existing code
   - Check work before merging or shipping
3. Ask one follow-up based on the answer (2 to 4 options), for example for "Build something new": *Not sure yet / Know what I want / Small change*.
4. Recommend the exact command and why, in two lines. Use this map:
   | Situation | Command |
   |---|---|
   | Fuzzy idea | `/garage:brainstorm` |
   | Clear idea, new work | `/garage:pitch` |
   | Planned, ready to build | `/garage:sprint` |
   | Something is broken | `/garage:firefight` |
   | New to the repo | `/garage:recon`, then `/garage:patterns` |
   | Messy code | `/garage:tidy` |
   | Tests are red | `/garage:test` |
   | Before merging | `/garage:audit`, then `/garage:pr` |
   | Docs are stale | `/garage:docs` |
   | Not set up yet | `/garage:garage-init` |
5. Offer to start it right away with the user's words as the argument.

If `.garage/` shows work in progress, mention it first: "You have pitch 002 half built. Resume with `/garage:sprint 002`?"
