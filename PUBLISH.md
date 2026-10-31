# Publish in 3 steps

You need `git`, Python 3, and the GitHub CLI (`gh auth login` once).

1. **Run one command** (your GitHub username and your name):
   ```bash
   ./scripts/publish.sh yourgithubname "voyager67"
   ```
   It personalizes the files, rebuilds the docs, validates, creates the public repo, pushes, sets 18 topics and the homepage, enables Discussions and GitHub Pages, and opens 3 good-first-issues. It creates no releases or tags.

2. **Upload the social preview** (30 seconds): repo Settings, General, Social preview, then `assets/social-preview.png`.

3. **Post it**: copy the posts from `docs/launch-kit.md`.

No `gh`? Run `./scripts/personalize.sh yourgithubname "voyager67"` and `python3 scripts/build-docs.py`, create an empty repo on github.com, then:
```bash
git init -b main && git add . && git commit -m "feat: Claude Garage" && git remote add origin <url> && git push -u origin main
```
Enable Pages in Settings, Pages (branch `main`, folder `/docs`).
