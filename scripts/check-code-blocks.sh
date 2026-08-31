#!/usr/bin/env bash
# Блок кода на собранной странице обязан совпадать с блоком в исходнике поста.
#
#   scripts/check-code-blocks.sh
#
# Зачем. Разметку сборка отбивает отступом для читаемости, а внутри <pre> пробелы
# значащие: строки кода получали лишние шесть пробелов и в браузере ехали вправо
# начиная со второй. В HTML это не бросается в глаза, в исходнике поста этого нет
# вовсе — увидеть можно было только на картинке, и баг прожил в шести постах из
# девятнадцати. Считать пробелы бессмысленно: автор ставит свои отступы внутри
# кода, и они законны. Единственный честный признак — равенство исходнику.
set -uo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
root="$(cd "$here/.." && pwd)"

python3 - "$root" <<'PY'
import html as html_module
import pathlib
import re
import sys

root = pathlib.Path(sys.argv[1])
BLOCK_HTML = re.compile(r'<pre class="code"><code>(.*?)</code></pre>', re.S)
BLOCK_MD = re.compile(r'^```[^\n]*\n(.*?)^```', re.S | re.M)

problems = checked = 0
for source in sorted((root / 'content' / 'posts').glob('*.md')):
    slug = source.stem[11:]                      # ГГГГ-ММ-ДД-слаг
    page = root / 'blog' / f'{slug}.html'
    if not page.is_file():
        print(f'  ✗ {slug}: пост есть, страницы нет')
        problems += 1
        continue
    expected = [block.rstrip('\n') for block in BLOCK_MD.findall(source.read_text(encoding='utf-8'))]
    actual = [html_module.unescape(block) for block in BLOCK_HTML.findall(page.read_text(encoding='utf-8'))]
    if len(expected) != len(actual):
        print(f'  ✗ {slug}: блоков кода в исходнике {len(expected)}, на странице {len(actual)}')
        problems += 1
        continue
    for number, (want, got) in enumerate(zip(expected, actual), 1):
        checked += 1
        if want == got:
            continue
        problems += 1
        print(f'  ✗ {slug}, блок {number}: страница разошлась с исходником')
        for line_number, (a, b) in enumerate(zip(want.split('\n'), got.split('\n')), 1):
            if a != b:
                print(f'      строка {line_number}')
                print(f'      исходник: {a!r}')
                print(f'      страница: {b!r}')
                break

if problems:
    print(f'\nблоков сверено: {checked} — РАСХОЖДЕНИЙ: {problems}')
    sys.exit(1)
print(f'\nблоков сверено: {checked} — каждый совпадает с исходником поста')
PY
