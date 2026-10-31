# Launch Kit

Everything you need to publish Garage well. Honest note: nobody can promise stars. What you *can* control is making the repo easy to understand in ten seconds and putting it in front of the right people. Never buy stars; it is against GitHub's rules and readers can tell.

## 1. Publish (5 minutes)
Everything is already prepared: README with animated demo, banner, social preview PNG, topics, interactive site and starter issues. No releases are needed.
- [ ] Run `./scripts/publish.sh <username> "<voyager67>"` (see PUBLISH.md)
- [ ] Upload `assets/social-preview.png` in Settings → General → Social preview
- [ ] Pin the repo on your GitHub profile

## 2. Launch day
Post once, in the right places, and reply to every comment for the first few hours.

**Show HN title**
> Show HN: Claude Garage, a startup crew (13 agents, 20 commands) for Claude Code

**Show HN first comment**
> I kept getting great code for the wrong problem. Garage makes Claude Code work in the order a good small startup does: pitch (with non-goals and kill criteria), blueprint, parallel sprint, a gremlin agent that tries to break the result, audit, launch, retro. Every step writes a one-page Markdown file, so you can resume after a context reset. The retro step saves "when X, do Y" rules that every later command reads. MIT, plain Markdown, no config. Feedback on the agents' prompts is very welcome.

**X / Threads thread**
1. I built a startup crew for Claude Code. 13 agents, 20 slash commands, idea → shipped. Open source. 🧵
2. The problem: AI writes code fast, but nobody asks "should we build this?" So `/pitch` forces non-goals and kill criteria first.
3. `/sprint` runs up to 3 builders in parallel, but only on slices that touch different files.
4. `/break` unleashes a Gremlin agent whose only job is to break your code, with failing tests as proof.
5. `/retro` turns lessons into rules the whole crew reads next time. It compounds.
6. Install in 2 commands. MIT. Link below. Tell me which agent I should add next.

**Reddit (r/ClaudeAI, r/ClaudeCode)**
Title: `I open-sourced Claude Garage: a startup-style workflow (pitch → blueprint → sprint → break → audit → launch) for Claude Code`
Body: 3 sentences on the problem, the install lines, one demo GIF, and a question like "What agent is missing?" Check each subreddit's self-promotion rules first.

## 3. Get discovered
- Submit to community lists such as awesome-claude-code (read their contribution guide)
- Add the plugin to any Claude Code plugin directories you find
- Write one short post: "What I learned building 13 agents" (the least-privilege and parallel-safety ideas are interesting on their own)

## 4. Keep it alive
- Answer issues within a day for the first month
- Ship small releases often; each release is another reason to share
- Merge good first PRs warmly, since contributors become advocates
- Re-share when you add something new (roadmap items are ready-made updates)
