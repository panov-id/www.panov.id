# www.panov.id#0001 — steps
Mark one with `issue step www.panov.id#0001 <N> "<evidence>"`. `issue status www.panov.id#0001 review` is refused while a step is open,
while «Объём» is empty or while ACCEPTANCE has an empty criterion row (owner 20.11.2026: «Каждая задача должна
собдержать несколько проходов линз, правки и такдалее до полной приемки»).
Each step names who does it · model, settings · who accepts (owner 20.11.2026: «какой агент с какой моделью и
настройками будет делать подзадачи. Кто будет принимать. Кто Когда карма гоняется»). Another role for this task is
written as a comment (`issue comment www.panov.id#0001 "role step N: … because …"`). karma-judge runs after every turn
with an edit and on every report draft (karma-gate.py; owner 20.11.2026 chose «Как сейчас: каждый ход с правкой»); step 10 is the last of them.
- [x] 1. scope written in TASK_RU/EN «Объём»/«Scope» — main session · Opus · accepts: sonnet-runner · Sonnet, reads scope against the ask verbatim — 2026-11-20 13:28 · scope: failures.md 470 records, last 34 lines 440-473 (9 ask, 7 unverified, 2 no task folder), wins.md 7 lines; script scratchpad/count.py
- [x] 2. change made (files named) — mechanical: haiku-runner · Haiku, full instruction + check command; module: sonnet-runner · Sonnet, task files only, no commit; search: Explore · Sonnet, read-only, one area per agent, result to a file · accepts: main session · Opus, runs the check command — 2026-11-20 13:28 · change: content/posts/2026-11-20-pravilo-kotoroe-ya-chital.md
- [x] 3. test for the change, run after the last edit — sonnet-runner · Sonnet · accepts: main session · Opus, reruns it — 2026-11-20 13:28 · test: lint-brands rc=0, build rc=0, 69 posts, feed.xml has slug x2
- [x] 4. mutant turned the test red (how many failed, restored) — haiku-runner · Haiku, mutant in a scratchpad copy · accepts: main session · Opus, sees red then green — 2026-11-20 13:28 · mutant: appended a brand name, lint-brands rc=1, restored
- [x] 5. lens pass 1 (findings by level) — review-panel, 2-4 agents in one message · Opus; security lens Fable · accepts: a second agent · Sonnet refutes each important finding — 2026-11-20 13:28 · lens 1 (facts): 'через несколько часов' had no source
- [x] 6. fixes for lens pass 1, with tests — sonnet-runner · Sonnet · accepts: main session · Opus, reruns the tests — 2026-11-20 13:28 · fixes: -> 'в тот же день'; summary 'три раза' -> 'дважды' (journal has 2)
- [x] 7. lens pass 2 or later: no HIGH/MEDIUM — review-panel · Opus, fresh agents · accepts: main session · Opus, recounts — 2026-11-20 13:28 · lens 2 clean: every number matches count.py / day metrics hook; no brand, no project name
- [ ] 8. full suite green after the last edit, claim [#N] verified — main session · Opus, run_in_background, digest · accepts: claim verify
- [ ] 9. gap-auditor after the last change, its list in comments.md — gap-auditor · Sonnet, read-only · accepts: its list goes verbatim to «Не проверено»
- [ ] 10. acceptance criteria filled in ACCEPTANCE_RU/EN — main session · Opus; then karma-judge · Sonnet, once on the report draft · accepts: the owner, `accepted` is the owner's word only
