# Architecture

Garage is deliberately simple: Markdown files that Claude Code already knows how to load.

```
skills/<name>/SKILL.md   Slash commands (orchestrators). Short, step-based.
agents/<name>.md         Subagents (workers). Narrow job, least-privilege tools.
output-styles/*.md       Personality and communication styles.
statusline/              Optional one-line status script.
.garage/                 Per-project state, written by commands, read by commands.
scripts/                 install, publish, personalize, build-docs, validate.
```

## Design choices
1. **Commands orchestrate, agents work.** Commands decide the order; agents do one job well.
2. **Least privilege.** Only `builder` changes production code. `tester`, `gremlin`, `scribe` and `rigger` write only tests, docs or infra.
3. **Lanes by size.** `chief` sizes work S, M or L; `/sprint` detects the lane from the artifacts on disk, so no hidden state is needed.
4. **Blind scenarios.** For size L, acceptance scenarios are written by `tester` and withheld from builders, so tests measure behavior, not a checklist.
5. **Parallel only when safe.** Parallelism requires disjoint files and is capped at three agents.
6. **State on disk.** Plain Markdown survives context resets and is reviewable in pull requests.
7. **Confirmation for irreversible actions.** Commits, tags, pushes and PRs are never silent.
8. **Learning loop.** `/retro` writes rules to `lessons.md`; `/rules` writes guardrails to `rules.md`; the planning and building commands read both.
9. **One source of truth.** Reference docs and the site are generated from the frontmatter, and CI fails if they drift.
