#!/usr/bin/env bash
# Снимает страницу блога в PNG, чтобы посмотреть её глазами до публикации.
#
# Обложки генеративные: пустой или уехавший узор видно только на картинке, а не
# в разметке. Смотреть через file:// нельзя — страница ссылается на стили и
# обложку от корня («/styles.css»), а корень у file:// это корень файловой
# системы: получается голый текст без единого стиля, и по нему ничего не судят.
# Поэтому внутри контейнера поднимаем статический сервер и ходим на него.
# Образ берём тот, что уже лежит на машине; на хост не ставим ничего.
#
#   scripts/shot.sh blog/index.html            # в /tmp/blog-shot.png
#   scripts/shot.sh blog/<слаг>.html out.png
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE="${SHOT_IMAGE:-mcr.microsoft.com/playwright:v1.52.0-noble}"
PAGE="${1:-blog/index.html}"
OUT="${2:-/tmp/blog-shot.png}"
SIZE="${SHOT_SIZE:-1200,1700}"
[ -f "$ROOT_DIR/$PAGE" ] || { echo "нет такой страницы: $PAGE" >&2; exit 2; }
mkdir -p "$(dirname "$OUT")"
docker run --rm -v "$ROOT_DIR:/site:ro" -v "$(dirname "$OUT"):/out" \
  --entrypoint /bin/sh "$IMAGE" -c "
    cd /site && python3 -m http.server 8931 >/dev/null 2>&1 &
    for i in \$(seq 1 40); do
      curl -sf -o /dev/null http://127.0.0.1:8931/$PAGE && break
      sleep 0.25
    done
    curl -sf -o /dev/null http://127.0.0.1:8931/$PAGE || { echo 'сервер не поднялся' >&2; exit 3; }
    BROWSER=\$(ls -d /ms-playwright/chromium-*/chrome-linux/chrome | head -1)
    \"\$BROWSER\" --headless --no-sandbox --disable-gpu --hide-scrollbars \
      --virtual-time-budget=4000 --window-size=$SIZE \
      --screenshot=/out/$(basename "$OUT") 'http://127.0.0.1:8931/$PAGE' 2>/dev/null
    chmod 644 /out/$(basename "$OUT")
  "
echo "снято: $OUT ($(du -h "$OUT" | cut -f1))"
