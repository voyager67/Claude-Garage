# Security Policy

Claude Garage is a collection of Markdown prompts plus a few small scripts. Prompts can change what an AI agent does, so please report anything that could cause unsafe behavior, for example an instruction that skips a confirmation, exposes secrets, or runs destructive commands.

## Reporting
Use GitHub's **private vulnerability reporting** (Security tab, then Report a vulnerability). Please do not open a public issue for security problems. You can expect an acknowledgement within a few days.

## Scope
- Agent, command and output-style instructions in `agents/`, `skills/` and `output-styles/`
- `install.sh`, `scripts/*.sh`, `scripts/*.py`, `statusline/garage-statusline.py`

## Design principles
- Least-privilege tools per agent; reviewers are read-only
- No commits, tags, pushes or PRs without explicit confirmation
- The installer only copies files into `.claude/`, backs up `settings.json` before editing it, never overwrites an existing statusline, and asks before enabling anything
- The one-line installer only runs `git clone` of this repository, then the local installer. Read `install.sh` before piping to a shell
