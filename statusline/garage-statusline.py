#!/usr/bin/env python3
"""Claude Garage statusline for Claude Code. Reads JSON on stdin, prints one line.

Shows: directory, git branch (* = dirty), model, active pitch, session cost, duration.
Standard library only. Never crashes the prompt: any error prints a minimal line.
"""
import json
import os
import re
import subprocess
import sys


def sh(cmd, cwd):
    try:
        return subprocess.run(cmd, cwd=cwd, capture_output=True, text=True, timeout=1.5).stdout.strip()
    except Exception:  # noqa: BLE001
        return ""


def active_pitch(cwd):
    base = os.path.join(cwd, ".garage", "pitches")
    try:
        for name in sorted(os.listdir(base), reverse=True):
            sprint = os.path.join(base, name, "sprint.md")
            if os.path.exists(sprint):
                text = open(sprint, encoding="utf-8").read()
                done = len(re.findall(r"- \[x\]", text, flags=re.I))
                todo = len(re.findall(r"- \[ \]", text))
                if todo:
                    return f"{name.split('-')[0]} {done}/{done + todo}"
    except Exception:  # noqa: BLE001
        pass
    return ""


def main():
    try:
        data = json.load(sys.stdin)
    except Exception:  # noqa: BLE001
        data = {}
    cwd = (data.get("workspace") or {}).get("current_dir") or data.get("cwd") or os.getcwd()
    home = os.path.expanduser("~")
    short = cwd.replace(home, "~", 1) if cwd.startswith(home) else cwd
    parts = short.split("/")
    if len(parts) > 3:
        short = "/".join([parts[0]] + [p[:1] for p in parts[1:-1]] + [parts[-1]])
    out = [f"\U0001F4C1 {short}"]

    branch = sh(["git", "branch", "--show-current"], cwd)
    if branch:
        dirty = "*" if sh(["git", "status", "--porcelain"], cwd) else ""
        out.append(f"\u2387 {branch}{dirty}")

    model = (data.get("model") or {}).get("display_name")
    if model:
        out.append(f"\U0001F916 {model}")

    pitch = active_pitch(cwd)
    if pitch:
        out.append(f"\U0001F6E0 pitch {pitch}")

    cost = (data.get("cost") or {})
    ms = cost.get("total_duration_ms")
    if ms:
        out.append(f"\U0001F550 {int(ms // 60000)}m")
    usd = cost.get("total_cost_usd")
    if usd is not None:
        out.append(f"\U0001F4B0 ${usd:.2f}")

    print("  ".join(out))


if __name__ == "__main__":
    try:
        main()
    except Exception:  # noqa: BLE001
        print("Claude Garage")
