#!/usr/bin/env python3
"""Validate Claude Garage agents, skills, manifests, docs and counts. Standard library only."""
import json
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
errors = []


def frontmatter(path):
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        return None
    end = text.find("\n---", 4)
    if end == -1:
        return None
    data = {}
    for line in text[4:end].splitlines():
        if ":" in line:
            key, _, value = line.partition(":")
            data[key.strip()] = value.strip()
    return data


def check(path, expected_name, required):
    fm = frontmatter(path)
    rel = path.relative_to(ROOT)
    if fm is None:
        errors.append(f"{rel}: missing or malformed frontmatter")
        return
    for key in required:
        if not fm.get(key):
            errors.append(f"{rel}: missing '{key}'")
    if expected_name and fm.get("name") and fm["name"] != expected_name:
        errors.append(f"{rel}: name '{fm['name']}' must match '{expected_name}'")
    if len(fm.get("description", "")) > 1024:
        errors.append(f"{rel}: description longer than 1024 characters")


agents = sorted((ROOT / "agents").glob("*.md"))
for f in agents:
    check(f, f.stem, ["name", "description", "tools"])

skills = sorted((ROOT / "skills").glob("*/SKILL.md"))
for f in skills:
    check(f, f.parent.name, ["name", "description"])

styles = sorted((ROOT / "output-styles").glob("*.md"))
for f in styles:
    check(f, None, ["name", "description"])

for manifest in [".claude-plugin/plugin.json", ".claude-plugin/marketplace.json"]:
    try:
        json.loads((ROOT / manifest).read_text(encoding="utf-8"))
    except Exception as exc:  # noqa: BLE001
        errors.append(f"{manifest}: invalid JSON ({exc})")

na, nc = len(agents), len(skills)

# counts must agree everywhere they are advertised
readme = (ROOT / "README.md").read_text(encoding="utf-8")
plugin = (ROOT / ".claude-plugin" / "plugin.json").read_text(encoding="utf-8")
for label, text, pats in [
    ("README.md", readme, [(r"(\d+) specialist agents", na), (r"(\d+) slash commands", nc)]),
    ("plugin.json", plugin, [(r"(\d+) specialist agents", na), (r"(\d+) slash commands", nc)]),
    ("publish.sh", (ROOT / "scripts" / "publish.sh").read_text(encoding="utf-8"), [(r"(\d+) agents", na), (r"(\d+) commands", nc)]),
]:
    for pat, want in pats:
        m = re.search(pat, text)
        if not m:
            errors.append(f"{label}: no '{pat}' count found")
        elif int(m.group(1)) != want:
            errors.append(f"{label}: says {m.group(1)} but repo has {want} ({pat})")

# generated docs must list every command and agent
cmds_md = (ROOT / "docs" / "commands.md").read_text(encoding="utf-8")
agents_md = (ROOT / "docs" / "agents.md").read_text(encoding="utf-8")
for f in skills:
    if f"/garage:{f.parent.name}" not in cmds_md:
        errors.append(f"docs/commands.md: missing {f.parent.name} (run scripts/build-docs.py)")
    if f"/garage:{f.parent.name}" not in readme:
        errors.append(f"README.md: command {f.parent.name} is not mentioned")
for f in agents:
    if f"**{f.stem}**" not in agents_md:
        errors.append(f"docs/agents.md: missing {f.stem} (run scripts/build-docs.py)")

for f in ["LICENSE", "NOTICE.md", "README.md", "CONTRIBUTING.md", "SECURITY.md", "CODE_OF_CONDUCT.md", "CHANGELOG.md", "docs/index.html"]:
    if not (ROOT / f).exists():
        errors.append(f"missing file: {f}")

if errors:
    print("Validation failed:")
    for e in errors:
        print(f"  - {e}")
    sys.exit(1)

print(f"OK: {na} agents, {nc} commands, {len(styles)} output styles, manifests and docs consistent.")
