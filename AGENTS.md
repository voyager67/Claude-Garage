# AGENTS.md

Guidance for AI coding tools (and humans) working on this repository.

## What this repo is
A Claude Code plugin made of Markdown files: `agents/` (subagents), `skills/<name>/SKILL.md` (slash commands), `output-styles/`, plus small helper scripts in `scripts/` and `statusline/`.

## Before you commit
1. `python3 scripts/build-docs.py` regenerates `docs/commands.md`, `docs/agents.md` and `docs/index.html`.
2. `python3 scripts/validate.py` must pass (frontmatter, names, manifests, counts in README).

## Conventions
- Agent `name` equals the filename; skill `name` equals its folder.
- Agents are narrow and use least-privilege tools. Reviewers are read-only.
- Commands are short, step-based and never take irreversible actions without confirmation.
- Adding a command? Also add it to `PHASES` in `scripts/build-docs.py` and to the README tables, and update counts.
- Keep wording original. Anything adapted from other projects needs attribution in `NOTICE.md`.
