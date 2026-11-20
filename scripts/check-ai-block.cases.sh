#!/usr/bin/env bash
# Cases for scripts/check-ai-block.sh ([www.panov.id#0002]): the real README passes,
# a missing ~/.claude exits 2 (not checked), and each checked fact, broken, turns it red.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
T=$(mktemp -d) && [[ -d "$T" ]] || exit 1; trap 'rm -rf "$T"' EXIT
pass=0; total=0
case_rc() { total=$((total+1)); if [[ "$2" == "$3" ]]; then pass=$((pass+1)); else echo "FAIL $1: rc=$2 want $3"; fi; }
./scripts/check-ai-block.sh >/dev/null; case_rc real $? 0
./scripts/check-ai-block.sh README.md /nonexist >/dev/null; case_rc no-claude-dir $? 2
sed 's/range(1, 11)/range(1, 12)/' "$HOME/.claude/scripts/bin/issue" > "$T/issue"
ISSUE_BIN="$T/issue" ./scripts/check-ai-block.sh >/dev/null; case_rc issue-tool-eleven-steps $? 1
mut() { python3 -c "import sys;s=open('README.md').read()
for p in sys.argv[2:]:
  a,b=p.split('=>');s=s.replace(a,b)
open(sys.argv[1],'w').write(s)" "$T/README.md" "$@"
  ./scripts/check-ai-block.sh "$T/README.md" >/dev/null; echo $?; }
case_rc approaches "$(mut 'Thirteen approaches=>Twelve approaches')" 1
case_rc wins "$(mut 'there are seven so far=>there are five so far')" 1
case_rc goloop "$(mut '`/goloop` is=>goloop is')" 1
case_rc digest "$(mut '12-line digest=>10-line digest')" 1
case_rc steps "$(mut 'Ten steps=>Nine steps' 'ten steps=>nine steps')" 1
[[ -e README.mut ]]; case_rc no-mutant-in-repo-root $? 1
python3 -c "import sys;open(sys.argv[1],'w').write(open('README_RU.md').read().replace('пока их семь','пока их пять'))" "$T/ru.md"
RU_README="$T/ru.md" ./scripts/check-ai-block.sh >/dev/null; case_rc ru-wins $? 1
python3 -c "import sys,re;open(sys.argv[1],'w').write(re.sub(r'\n\*\*12\. .*?(?=\n\nВсё работает)','',open('README_RU.md').read(),flags=re.S))" "$T/ru.md"
RU_README="$T/ru.md" ./scripts/check-ai-block.sh >/dev/null; case_rc ru-item-missing $? 1
python3 -c "import sys;open(sys.argv[1],'w').write(open('README_RU.md').read().replace('Тринадцать подходов','Восемьтринадцать подходов'))" "$T/ru.md"
RU_README="$T/ru.md" ./scripts/check-ai-block.sh >/dev/null; case_rc ru-approaches-substring $? 1
python3 -c "import sys;open(sys.argv[1],'w').write(open('README_RU.md').read().replace('сводку в 12 строк','сводку в 10 строк'))" "$T/ru.md"
RU_README="$T/ru.md" ./scripts/check-ai-block.sh >/dev/null; case_rc ru-digest $? 1
python3 -c "import sys;open(sys.argv[1],'w').write(open('README_RU.md').read().replace('десятью шагами','девятью шагами'))" "$T/ru.md"
RU_README="$T/ru.md" ./scripts/check-ai-block.sh >/dev/null; case_rc ru-steps $? 1
mkdir -p "$T/c/scripts/bin"; cp -r "$HOME/.claude/commands" "$HOME/.claude/agents" "$HOME/.claude/templates" "$T/c/"; cp "$HOME/.claude/wins.md" "$T/c/"; cp "$HOME/.claude/scripts/bin/issue" "$T/c/scripts/bin/"; cp "$HOME/.claude/scripts/token-report.py" "$T/c/scripts/"
./scripts/check-ai-block.sh README.md "$T/c" >/dev/null; case_rc tool-pdf-pages-gone $? 1
{ cat "$HOME/.claude/scripts/bin/issue"; echo '    for k in range(1, 11): pass'; } > "$T/issue2"
ISSUE_BIN="$T/issue2" ./scripts/check-ai-block.sh >/dev/null; case_rc issue-tool-two-ranges $? 1
sed 's/at most [0-9]* lines/at most some lines/' "$HOME/.claude/templates/project-rules.md" > "$T/c/templates/project-rules.md"; cp "$HOME/.claude/scripts/bin/pdf-pages.sh" "$T/c/scripts/bin/"
./scripts/check-ai-block.sh README.md "$T/c" >/dev/null; case_rc digest-rule-missing $? 1
echo "cases: $pass of $total"
[[ $pass == $total ]]
