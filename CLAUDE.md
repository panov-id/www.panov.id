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
```

Order matters: the linter first, otherwise a text with a brand name can be built and pushed.

<!-- global:begin sha=ad3e7094e7 -->
## Saving tokens (global block, edited in ~/.claude/templates/project-rules.md)

- Noisy output only through `digest`: `… 2>&1 | digest <phpunit|phpstan|cs|compose|git|httplog|auto>`.
  It prints at most 12 lines, puts the full text in the scratchpad and names the path; details with `sed -n` over a range.
  The hook `guard-long-output.py` refuses a test run, logs or a full diff without `digest`, `tail` or a file.
- A mechanical step with a machine check goes to `haiku-runner`; a module by a spec to `sonnet-runner`;
  a ready diff plan to `codex exec` through the wrapper (skill `delegate`). Fable: security, migrations, a fork with no answer; decisions and review: Opus.
- A run longer than a minute: `run_in_background`, read the result through `digest`, not the whole file.
- A command longer than 300 characters or with 4+ pipes and no script: `guard-inline-command.py` saves it to
  `~/.claude/state/inline/` and lets it run; a repeatable one goes to `scripts/` or `~/.claude/scripts/bin/`, a one-off to a file in the scratchpad.
- The project's offline gates are `.claude/gates.txt` (one command per line, `watch:` says which edits
  start them); after a turn with an edit `gates-run.py` runs them in the background, the verdict (rc per gate)
  arrives with the next prompt. Offline containers only: there is no network in the background.
<!-- global:end -->
