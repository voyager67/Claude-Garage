#!/usr/bin/env sh
# Claude Garage interactive installer (standalone, short command names).
#   ./scripts/install.sh                 interactive
#   ./scripts/install.sh --yes           defaults, no questions (user scope, no extras)
#   ./scripts/install.sh --project       install into ./.claude instead of ~/.claude
#   ./scripts/install.sh --statusline    also set up the statusline
#   ./scripts/install.sh --uninstall     remove what this installer added
set -eu

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="$HOME/.claude"
MODE="install"
ASSUME_YES=0
WANT_STATUSLINE=""
WANT_TEAMS=""

for arg in "$@"; do
  case "$arg" in
    --project)    TARGET="$(pwd)/.claude" ;;
    --uninstall)  MODE="uninstall" ;;
    --yes|-y)     ASSUME_YES=1 ;;
    --statusline) WANT_STATUSLINE="y" ;;
    -h|--help)    sed -n '2,8p' "$0"; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

bold() { printf '\033[1m%s\033[0m\n' "$1"; }
ask() { # ask "question" default(y|n) -> sets REPLY_YN
  if [ "$ASSUME_YES" = "1" ] || [ ! -r /dev/tty ]; then REPLY_YN="$2"; return; fi
  printf '%s [%s] ' "$1" "$( [ "$2" = y ] && echo 'Y/n' || echo 'y/N' )" > /dev/tty
  read -r ans < /dev/tty || ans=""
  case "$ans" in y|Y|yes) REPLY_YN=y ;; n|N|no) REPLY_YN=n ;; *) REPLY_YN="$2" ;; esac
}

if [ "$MODE" = "uninstall" ]; then
  for f in "$REPO_ROOT"/agents/*.md; do rm -f "$TARGET/agents/$(basename "$f")"; done
  for d in "$REPO_ROOT"/skills/*/; do rm -rf "$TARGET/skills/$(basename "$d")"; done
  for f in "$REPO_ROOT"/output-styles/*.md; do rm -f "$TARGET/output-styles/$(basename "$f")"; done
  rm -rf "$TARGET/garage"
  bold "Claude Garage removed from $TARGET"
  echo "If you enabled the statusline or agent teams, edit $TARGET/settings.json to remove them."
  exit 0
fi

bold "Claude Garage installer"
echo "Target: $TARGET"
if [ "$TARGET" = "$HOME/.claude" ] && [ "$ASSUME_YES" = "0" ] && [ -r /dev/tty ]; then
  ask "Install for this project only (./.claude) instead of all projects?" n
  [ "$REPLY_YN" = "y" ] && TARGET="$(pwd)/.claude" && echo "Target: $TARGET"
fi
[ -z "$WANT_STATUSLINE" ] && { ask "Set up the Garage statusline (directory, branch, pitch progress, cost)?" n; WANT_STATUSLINE="$REPLY_YN"; }
[ -z "$WANT_TEAMS" ] && { ask "Enable experimental Agent Teams in settings?" n; WANT_TEAMS="$REPLY_YN"; }

mkdir -p "$TARGET/agents" "$TARGET/skills" "$TARGET/output-styles"
cp "$REPO_ROOT"/agents/*.md "$TARGET/agents/"
for d in "$REPO_ROOT"/skills/*/; do
  mkdir -p "$TARGET/skills/$(basename "$d")"
  cp -R "$d". "$TARGET/skills/$(basename "$d")/"
done
cp "$REPO_ROOT"/output-styles/*.md "$TARGET/output-styles/"

if [ "$WANT_STATUSLINE" = "y" ] || [ "$WANT_TEAMS" = "y" ]; then
  mkdir -p "$TARGET/garage"
  cp "$REPO_ROOT/statusline/garage-statusline.py" "$TARGET/garage/"
  python3 - "$TARGET" "$WANT_STATUSLINE" "$WANT_TEAMS" <<'PY'
import json, os, shutil, sys
target, want_status, want_teams = sys.argv[1], sys.argv[2] == "y", sys.argv[3] == "y"
path = os.path.join(target, "settings.json")
data = {}
if os.path.exists(path):
    shutil.copy(path, path + ".garage-backup")
    try:
        data = json.load(open(path, encoding="utf-8"))
    except Exception:
        print("settings.json is not valid JSON; leaving it untouched.")
        sys.exit(0)
if want_status:
    if "statusLine" in data:
        print("A statusLine is already configured; leaving it alone.")
    else:
        data["statusLine"] = {"type": "command", "command": f"python3 {os.path.join(target, 'garage', 'garage-statusline.py')}"}
if want_teams:
    data.setdefault("env", {})["CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS"] = "1"
json.dump(data, open(path, "w", encoding="utf-8"), indent=2)
print("Updated settings.json (backup: settings.json.garage-backup)")
PY
fi

echo ""
bold "Claude Garage installed."
echo "Restart Claude Code, then try:"
echo "  /garage-init     set up your project"
echo "  /guide           not sure where to start? It asks, then recommends"
echo "  /pitch \"your idea\""
echo "Tip: /output-style  then choose Garage Rush or Garage Mentor."
