#!/usr/bin/env sh
# Replace placeholders with your details. Run once before publishing.
#   ./scripts/personalize.sh <github-username> "<Your Name>"
set -eu
if [ "$#" -ne 2 ]; then
  echo 'Usage: ./scripts/personalize.sh <github-username> "<Your Name>"' >&2
  exit 1
fi
USER_NAME="$1"
FULL_NAME="$2"
cd "$(dirname "$0")/.."
FILES=$(grep -rIlE "YOUR_GITHUB_USERNAME|YOUR NAME" --exclude-dir=.git --exclude=personalize.sh . || true)
for f in $FILES; do
  sed -i.bak -e "s|YOUR_GITHUB_USERNAME|$USER_NAME|g" -e "s|YOUR NAME|$FULL_NAME|g" "$f"
  rm -f "$f.bak"
done
echo "Personalized for $FULL_NAME (@$USER_NAME)."
echo "Next: python3 scripts/validate.py && git init && git add . && git commit -m 'feat: initial release'"
