---
name: docs
description: Generate or synchronize documentation with the code. Creates README, API docs or architecture notes, and finds stale docs that no longer match reality.
argument-hint: "[readme | api | arch | sync] [path]"
---

# /docs: documentation that matches the code

## Modes
- **readme:** write or refresh the project README
- **api:** document public functions, endpoints or CLI flags
- **arch:** a one-page architecture note with a diagram (Mermaid)
- **sync** (default): compare existing docs with the code and fix drift

## Steps
1. Delegate to `scout` to map what exists, then to `scribe` for the chosen mode.
2. Every command, path, flag and example in the docs is **verified against the code**. Run commands where it is safe to do so.
3. For `sync`, produce a short table: `doc | claim | reality | action`, then apply the fixes the user approves.
4. Keep the existing tone and structure unless the user asks for a rewrite.

## Rules
- Lead with what the reader can do, then how.
- No invented features. If you are unsure, mark it `TODO: verify` and tell the user.
