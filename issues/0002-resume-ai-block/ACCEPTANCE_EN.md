# www.panov.id#0002 — acceptance

## Criteria
| # | Criterion | Check (command, test, shot) | Result |
|---|---|---|---|
| 1 | Block numbers and names match ~/.claude | scripts/check-ai-block.sh [#1] | yes |
| 2 | The check turns red on a break | scripts/check-ai-block.cases.sh 15 of 15 [#19] | yes |
| 3 | Block live on panov.id | curl of the live page after /push | no, waits for /commit, /push |

## Acceptance (I am the customer)
Asked: «поставь задачу обновить блок в резюме про ии. Собери чтото более свежее и обнови. Чтобы совпадало с реальностьбю 100%»
Got: block of 13 approaches, /goloop, seven wins, items 9-12, RU pair [#19], cases 15 of 15 [#19]
Missing: commit and push; prose of items 0-8 checked by hand; the check is not in CI (no ~/.claude there)
Verdict: would return — the site shows the old block
