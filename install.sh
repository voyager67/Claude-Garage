#!/usr/bin/env sh
# Claude Garage one-line installer:
#   curl -fsSL https://raw.githubusercontent.com/voyager67/claude-garage/main/install.sh | sh
set -eu
REPO_URL="https://github.com/voyager67/claude-garage.git"
command -v git >/dev/null 2>&1 || { echo "git is required." >&2; exit 1; }
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
echo "Fetching Claude Garage..."
git clone --quiet --depth 1 "$REPO_URL" "$TMP/claude-garage"
exec sh "$TMP/claude-garage/scripts/install.sh" "$@"
