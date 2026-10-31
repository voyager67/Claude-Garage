# Contributing to Claude Garage

Thanks for helping build the crew. Contributions of every size are welcome: typo fixes, sharper prompts, new agents, new commands.

## Ground rules
1. **Narrow agents.** One job per agent. If the description needs "and" twice, split it.
2. **Least privilege.** Give an agent only the tools it needs. Reviewers are read-only.
3. **Short commands.** A command should fit on one screen. Move detail into the agent that does the work.
4. **Artifacts are Markdown.** State lives in `.garage/` as plain text so it can be read, diffed and resumed.
5. **Never act silently.** Commits, tags, pushes, PRs and destructive actions need explicit confirmation.
6. **Be original.** Write your own wording. If you adapt something from another project, add attribution to `NOTICE.md`.

## Workflow
1. Fork and create a branch: `git checkout -b feat/my-change`
2. Make your change.
3. `python3 scripts/build-docs.py` then `python3 scripts/validate.py` (must pass).
4. Open a PR using the template. Describe the problem, not just the diff.

## Adding an agent
Create `agents/<name>.md` with frontmatter `name`, `description`, `tools` and optionally `model`. The `name` must match the filename. Add an icon in `ICONS` in `scripts/build-docs.py`, add a row to the crew table in the README, and update the counts.

## Adding a command
Create `skills/<name>/SKILL.md` with frontmatter `name`, `description` and optionally `argument-hint`. The `name` must match the folder. Add it to `PHASES` in `scripts/build-docs.py`, to the README tables and to the counts.

## Commit style
Conventional commits, for example `feat(agent): add perf-hawk` or `docs: clarify install`.

By contributing you agree that your work is released under the [MIT License](LICENSE).
