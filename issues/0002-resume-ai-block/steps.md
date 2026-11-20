# www.panov.id#0002 — steps
Mark one with `issue step www.panov.id#0002 <N> "<evidence>"`. `issue status www.panov.id#0002 review` is refused while a step is open,
while «Объём» is empty or while ACCEPTANCE has an empty criterion row (owner 20.11.2026: «Каждая задача должна
собдержать несколько проходов линз, правки и такдалее до полной приемки»).
Each step names who does it · model, settings · who accepts (owner 20.11.2026: «какой агент с какой моделью и
настройками будет делать подзадачи. Кто будет принимать. Кто Когда карма гоняется»). Another role for this task is
written as a comment (`issue comment www.panov.id#0002 "role step N: … because …"`). karma-judge runs after every turn
with an edit and on every report draft (karma-gate.py; owner 20.11.2026 chose «Как сейчас: каждый ход с правкой»); step 10 is the last of them.
- [x] 1. scope written in TASK_RU/EN «Объём»/«Scope» — main session · Opus · accepts: sonnet-runner · Sonnet, reads scope against the ask verbatim — 2026-11-20 13:41 · scope in TASK_RU/EN: README.md:147+ vs ~/.claude rules 3,10,40-42, commands 11, agents 5, wins 7
- [x] 2. change made (files named) — mechanical: haiku-runner · Haiku, full instruction + check command; module: sonnet-runner · Sonnet, task files only, no commit; search: Explore · Sonnet, read-only, one area per agent, result to a file · accepts: main session · Opus, runs the check command — 2026-11-20 13:42 · change: README.md AI block (13 approaches, +/goloop, wins seven, items 9-12), scripts/check-ai-block.sh
- [x] 3. test for the change, run after the last edit — sonnet-runner · Sonnet · accepts: main session · Opus, reruns it — 2026-11-20 13:42 · test: scripts/check-ai-block.sh rc=0 'ok: 13 approaches, 11 commands, 7 wins'; skip rc=0 without ~/.claude
- [x] 4. mutant turned the test red (how many failed, restored) — haiku-runner · Haiku, mutant in a scratchpad copy · accepts: main session · Opus, sees red then green — 2026-11-20 13:42 · mutant: 5 of 5 red (approaches, wins, /goloop, digest 12, ten steps both), restored
- [x] 5. lens pass 1 (findings by level) — review-panel, 2-4 agents in one message · Opus; security lens Fable · accepts: a second agent · Sonnet refutes each important finding — 2026-11-20 13:42 · lens 1 (second reader sonnet-runner): plan matches; gaps: 3 facts only, no skip without ~/.claude
- [x] 6. fixes for lens pass 1, with tests — sonnet-runner · Sonnet · accepts: main session · Opus, reruns the tests — 2026-11-20 13:42 · fixes: added agents, digest, steps checks and skip
- [x] 7. lens pass 2 or later: no HIGH/MEDIUM — review-panel · Opus, fresh agents · accepts: main session · Opus, recounts — 2026-11-20 13:42 · lens 2 clean: items 9-12 match CLAUDE.md rules 40, 41, 42, global Target path block, skill artel, rule 3
- [x] 8. full suite green after the last edit, claim [#N] verified — main session · Opus, run_in_background, digest · accepts: claim verify — 2026-11-20 13:42 · full suite [#1]: check-ai-block, lint-brands, build rc=0, index.html has the block
- [x] 9. gap-auditor after the last change, its list in comments.md — gap-auditor · Sonnet, read-only · accepts: its list goes verbatim to «Не проверено» — 2026-11-20 13:43 · gap-auditor: 8 gaps, listed in answer under Не проверено
- [x] 10. acceptance criteria filled in ACCEPTANCE_RU/EN — main session · Opus; then karma-judge · Sonnet, once on the report draft · accepts: the owner, `accepted` is the owner's word only — 2026-11-20 13:44 · acceptance filled RU/EN: verdict would return, waits /commit /push
