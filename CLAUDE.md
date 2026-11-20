# www.panov.id: project rules

A static site: the card page is built from `README.md`, the blog from `content/posts/`.
Plain Node with no dependencies, run in a container (nothing is installed on the host).
Publishing is automatic when changes are pushed to `main`.

## Blog

Written by the assistant. Format, tone, topic choice and publishing order: skill `blog-post`.

- When to write is decided by a count, not by memory: `~/.claude/scripts/blog-due.sh` counts days
  since the last post and commits across all projects of the group, and the `SessionStart` hook
  brings the result into the session. Until the threshold is passed the script is silent.
- Posts are in Russian only. This is a recorded exception to the document pairing rule.
- **Not one company, product or vendor name**: not in the text, not in code examples,
  not in the title. Checked by `scripts/lint-brands.sh`; the build fails on a match.
- Our own projects are brands too: the group's domains and repository names are in the linter list.
- Standards and protocols are not brands: RFC, OAuth, HTTP, SQL, RSS, SVG.
- The cover is generated from the title hash, never drawn by hand.
- `feed.xml`, `blog/index.html` and the post pages are produced by the build, never edited by hand.

## Build

```bash
./scripts/lint-brands.sh && ./scripts/build.sh
./scripts/check-ai-block.cases.sh   # AI block of both README halves vs ~/.claude
```

`check-ai-block.sh` reads `~/.claude`; without it rc=2 means NOT CHECKED, never a pass.
`issues/` holds task folders, excluded from the upload in `deploy-bunny.yml`.

Order matters: the linter first, otherwise a text with a brand name can be built and pushed.

<!-- global:begin sha=f80c1cf0c9 -->
## Saving tokens (global block, edited in ~/.claude/templates/project-rules.md)

- Noisy output only through `digest`: `… 2>&1 | digest <phpunit|phpstan|cs|compose|git|httplog|auto>`.
  It prints at most 12 lines, puts the full text in the scratchpad and names the path; details with `sed -n` over a range.
  The hook `guard-long-output.py` refuses a test run, logs or a full diff without `digest`, `tail` or a file.
- A mechanical step with a machine check goes to `haiku-runner`; a module by a spec to `sonnet-runner`;
  a ready diff plan to `codex exec` through the wrapper (skill `delegate`). Fable: security, migrations, a fork with no answer; decisions and review: Opus.
- A run longer than a minute: `run_in_background`, read the result through `digest`, not the whole file.
- Check only what was touched (owner 27.10.2026): the tests next to the changed files (`git diff --name-only`),
  shots of the changed screens, the flow leg through them; the build/type gate stays whole; the full suite once before a commit.
- A command longer than 300 characters or with 4+ pipes and no script: `guard-inline-command.py` saves it to
  `~/.claude/state/inline/` and lets it run; a repeatable one goes to `scripts/` or `~/.claude/scripts/bin/`, a one-off to a file in the scratchpad.
- The project's offline gates are `.claude/gates.txt` (one command per line, `watch:` says which edits
  start them); after a turn with an edit `gates-run.py` runs them in the background, the verdict (rc per gate)
  arrives with the next prompt. Offline containers only: there is no network in the background.
- Target path (owner 17.11.2026, «проверка того что ты не сделал»): the project's `CLAUDE.md` names one command that
  rehearses the real rollout from scratch, in the target environment, without the local stand's helpers. Before a
  report of done work, a status, a handoff or a release, `gap-gate.py` wants a `gap-auditor` call after the last
  change and a line «Не проверено:»; the auditor names every environment and path the claims did not run.
- Tasks (owner 19.11.2026): one folder per task in `issues/<NNNN>-<slug>/` of this repo, made by `~/.claude/scripts/bin/issue new`;
  a commit names it as `[<repo>#<NNNN>]` (`issue-ref.py`); links to other repos' tasks with a why via `issue link`.
<!-- global:end -->
