#!/usr/bin/env bash
# Checks that the "AI Assistant Setup" block of README.md matches the setup on disk
# ([www.panov.id#0002]): number of approaches, every command, wins count.
# Usage: scripts/check-ai-block.sh [README] [CLAUDE_DIR]
set -uo pipefail
R="${1:-$(dirname "$0")/../README.md}"
C="${2:-$HOME/.claude}"
fail=0
[[ -d "$C/commands" && -f "$C/wins.md" ]] || { echo "NOT CHECKED: no $C"; exit 2; }
block=$(sed -n '/^## AI Assistant Setup/,$p' "$R")
words=(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen)
n=$(grep -cE '^\*\*[0-9]+\. ' <<<"$block")
w=$(grep -oE '[A-Za-z]+ approaches, each' <<<"$block" | awk '{print tolower($1)}')
[[ "${words[$n]}" == "$w" ]] || { echo "FAIL approaches: $n headers, text says '$w'"; fail=1; }
for f in "$C"/commands/*.md; do
  c="/$(basename "$f" .md)"
  grep -qF "\`$c\`" <<<"$block" || { echo "FAIL command $c not in block"; fail=1; }
done
wins=$(grep -c '^- ' "$C/wins.md")
txt=$(grep -oE 'there are [a-z]+ so far' <<<"$block" | awk '{print $3}')
[[ "${words[$wins]}" == "$txt" ]] || { echo "FAIL wins: $wins in wins.md, text says '$txt'"; fail=1; }
for a in judge auditor; do
  ls "$C"/agents/*"$a"*.md >/dev/null 2>&1 || { echo "FAIL agent *$a* not in $C/agents"; fail=1; }
done
for t in scripts/token-report.py scripts/bin/pdf-pages.sh; do
  [[ -f "$C/$t" ]] || { echo "FAIL tool $t is gone, block still names it"; fail=1; }
done
dl=$(grep -oE 'at most [0-9]+ lines' "$C/templates/project-rules.md" | grep -oE '[0-9]+')
[[ -n "$dl" ]] && grep -qF -- "${dl}-line digest" <<<"$block" ||{ echo "FAIL digest: rules say $dl lines"; fail=1; }
k=$(grep -oE 'for k in range\(1, [0-9]+\)' "${ISSUE_BIN:-$C/scripts/bin/issue}" | grep -oE '[0-9]+\)$' | tr -d ')')
if [[ -z "$k" || "$k" == *$'\n'* ]]; then echo "FAIL steps: not exactly one step range in the issue tool"; fail=1
else k=$((k-1)); grep -qiE "${words[$k]} steps" <<<"$block" || { echo "FAIL steps: issue tool has $k"; fail=1; }; fi
RU="${RU_README:-$(dirname "$R")/README_RU.md}"
if [[ -f "$RU" ]]; then
  rub=$(sed -n '/^## Настройка ИИ-ассистента/,$p' "$RU")
  ruw=(ноль один два три четыре пять шесть семь восемь девять десять одиннадцать двенадцать тринадцать четырнадцать пятнадцать)
  rn=$(grep -cE '^\*\*[0-9]+\. ' <<<"$rub")
  [[ "$rn" == "$n" ]] || { echo "FAIL RU: $rn items, EN has $n"; fail=1; }
  grep -qiE "^Как я работаю.*(^|[[:space:].])${ruw[$n]} подход" <<<"$rub" || { echo "FAIL RU approaches word, want ${ruw[$n]}"; fail=1; }
  for f in "$C"/commands/*.md; do
    c="/$(basename "$f" .md)"; grep -qF "\`$c\`" <<<"$rub" || { echo "FAIL RU command $c"; fail=1; }
  done
  grep -qF -- "сводку в ${dl} строк" <<<"$rub" || { echo "FAIL RU digest: want ${dl} строк"; fail=1; }
  rk=(ноль одним двумя тремя четырьмя пятью шестью семью восемью девятью десятью одиннадцатью двенадцатью)
  [[ -n "${k:-}" && "$k" != *$'\n'* ]] && { grep -qiF -- "${rk[$k]} шагами" <<<"$rub" || { echo "FAIL RU steps: want ${rk[$k]} шагами"; fail=1; }; }
  rw=(ноль одно два три четыре пять шесть семь восемь девять десять одиннадцать двенадцать тринадцать четырнадцать пятнадцать)
  (( wins < ${#rw[@]} && n < ${#ruw[@]} )) || { echo "FAIL word table too short: wins=$wins items=$n, extend rw/ruw/words"; exit 1; }
  grep -qE "пока их ${rw[$wins]}[;,. ]" <<<"$rub" || { echo "FAIL RU wins: want ${rw[$wins]}"; fail=1; }
fi
[[ $fail == 0 ]] && echo "ok: $n approaches, $(ls "$C"/commands/*.md | wc -l) commands, $wins wins"
exit $fail
