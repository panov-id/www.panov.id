# www.panov.id#0002 — comments

One entry per date: decisions, owner words verbatim, findings.

## 2026-11-20 13:41 · claude
step 1 closed: scope in TASK_RU/EN: README.md:147+ vs ~/.claude rules 3,10,40-42, commands 11, agents 5, wins 7

## 2026-11-20 13:42 · claude
step 2 closed: change: README.md AI block (13 approaches, +/goloop, wins seven, items 9-12), scripts/check-ai-block.sh

## 2026-11-20 13:42 · claude
step 3 closed: test: scripts/check-ai-block.sh rc=0 'ok: 13 approaches, 11 commands, 7 wins'; skip rc=0 without ~/.claude

## 2026-11-20 13:42 · claude
step 4 closed: mutant: 5 of 5 red (approaches, wins, /goloop, digest 12, ten steps both), restored

## 2026-11-20 13:42 · claude
step 5 closed: lens 1 (second reader sonnet-runner): plan matches; gaps: 3 facts only, no skip without ~/.claude

## 2026-11-20 13:42 · claude
step 6 closed: fixes: added agents, digest, steps checks and skip

## 2026-11-20 13:42 · claude
step 7 closed: lens 2 clean: items 9-12 match CLAUDE.md rules 40, 41, 42, global Target path block, skill artel, rule 3

## 2026-11-20 13:42 · claude
step 8 closed: full suite [#1]: check-ai-block, lint-brands, build rc=0, index.html has the block

## 2026-11-20 13:43 · claude
step 9 closed: gap-auditor: 8 gaps, listed in answer under Не проверено

## 2026-11-20 13:44 · claude
step 10 closed: acceptance filled RU/EN: verdict would return, waits /commit /push

## 2026-11-20 13:47 · claude
/go 20.11: gates.txt added (inert: site not in trusted-projects.txt), no ~/.claude -> rc 2, steps from issue tool range; cases 8 of 8 [#4]

## 2026-11-20 14:44 · claude
Owner picked «Снимаю правило 22» in the questionnaire; hook phase-during.py still refused, so the owner added the line himself: deploy-bunny.yml:58 excludes issues/ [#18]. Final: 15 of 15 cases [#19], index.html equals the build [#20], commit a31f11b pushed. Step 3 evidence is stale: without ~/.claude the check exits 2 (NOT CHECKED), not 0. RU check now also covers digest lines and steps: 17 of 17 [#23].
