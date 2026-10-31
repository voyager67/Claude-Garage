#!/usr/bin/env sh
# One command to go live. Requires git and the GitHub CLI (gh), logged in via `gh auth login`.
#   ./scripts/publish.sh <github-username> "<Your Name>"
# No releases or tags are created.
set -eu
if [ "$#" -ne 2 ]; then
  echo 'Usage: ./scripts/publish.sh <github-username> "<Your Name>"' >&2
  exit 1
fi
USER_NAME="$1"
FULL_NAME="$2"
REPO="claude-garage"
DESC="A startup crew for Claude Code: 13 agents, 20 commands, idea to shipped. Interactive, parallel, MIT."
cd "$(dirname "$0")/.."

command -v git >/dev/null || { echo "git is required" >&2; exit 1; }
command -v gh  >/dev/null || { echo "GitHub CLI (gh) is required: https://cli.github.com" >&2; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "Run: gh auth login" >&2; exit 1; }

echo "==> Personalizing"
./scripts/personalize.sh "$USER_NAME" "$FULL_NAME" >/dev/null
echo "==> Building docs and validating"
python3 scripts/build-docs.py
python3 scripts/validate.py

echo "==> Creating repository"
[ -d .git ] || git init -q -b main
git add -A
git commit -q -m "feat: Claude Garage, a startup crew for Claude Code" || true
gh repo create "$USER_NAME/$REPO" --public --source=. --remote=origin --push --description "$DESC"

echo "==> Topics, homepage and discussions"
gh repo edit "$USER_NAME/$REPO" \
  --homepage "https://$USER_NAME.github.io/$REPO/" --enable-discussions \
  --add-topic claude-code --add-topic claude-code-plugin --add-topic claude-plugin \
  --add-topic claude --add-topic anthropic --add-topic ai-agents --add-topic subagents \
  --add-topic multi-agent --add-topic agentic-workflow --add-topic ai-coding \
  --add-topic developer-tools --add-topic productivity --add-topic workflow \
  --add-topic prompt-engineering --add-topic slash-commands --add-topic cli \
  --add-topic automation --add-topic llm --add-topic open-source

echo "==> GitHub Pages (interactive site)"
gh api -X POST "repos/$USER_NAME/$REPO/pages" -f "source[branch]=main" -f "source[path]=/docs" >/dev/null 2>&1 \
  || echo "   (Pages not enabled automatically; enable it in Settings > Pages: branch main, folder /docs)"

echo "==> Starter issues"
gh label create "good first issue" --color 7057ff --force >/dev/null 2>&1 || true
gh issue create --title "Add /garage:estimate (slice-based time estimates)" --label "good first issue" \
  --body "Create skills/estimate/SKILL.md that estimates time per blueprint slice from git history. See CONTRIBUTING.md." >/dev/null
gh issue create --title "Add /garage:deps (dependency health check)" --label "good first issue" \
  --body "Create skills/deps/SKILL.md that flags outdated or risky dependencies. See CONTRIBUTING.md." >/dev/null
gh issue create --title "Language-specific Gremlin attack packs" --label "good first issue" \
  --body "Propose extra attack checklists (Python, TypeScript, Go) for agents/gremlin.md." >/dev/null

echo ""
echo "Live:  https://github.com/$USER_NAME/$REPO"
echo "Site:  https://$USER_NAME.github.io/$REPO/  (ready in a minute or two)"
echo "Last manual step (30 seconds): Settings > General > Social preview > upload assets/social-preview.png"
echo "Then post using docs/launch-kit.md"
