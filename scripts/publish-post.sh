#!/usr/bin/env bash
# Publishes one blog post end to end, so the whole run is one short command instead of
# seven one-liners typed anew every time (08.10.2026: build, shot, shrink, commit, push,
# cache purge and live check were ~2 500 characters of console, none of it kept).
#
#   scripts/publish-post.sh <slug>                       # build + screenshot, nothing sent
#   scripts/publish-post.sh <slug> -m "Post: ..." --send # commit, push main, purge cache, verify
#                                                        # append «# approved: main» to the command:
#                                                        # guard-push.sh folds this file in and wants it
#
# <slug> is the file name after the date: content/posts/ГГГГ-ММ-ДД-<slug>.md.
# The screenshot lands in the newest scratchpad (or $SHOT_DIR) as <slug>.png plus a
# ≤600 px copy <slug>-small.png to look at — the small one is what the eyes need and what
# guard-read-size lets through.
# Cache purge reads BUNNY_API_KEY from $BUNNY_ENV (default: xor.ad/deploy/.env.deploy); the
# deploy itself cannot purge — its secrets are not set up in this repository (02.09.2026).
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SITE="${SITE_URL:-https://panov.id}"
BUNNY_ENV="${BUNNY_ENV:-$HOME/Projects/panov-id/xor.ad/deploy/.env.deploy}"
REPO="${REPO:-panov-id/www.panov.id}"

# wait_deployed <sha>: wait up to 10 min for the deploy workflow run of <sha> to finish.
# The edge ignores query strings (13.10.2026: index.html?cb=<time> came back as a HIT cached
# the day before), so Last-Modified seen through it cannot tell an upload happened; the run
# itself can. A finished run means every file is on the storage zone.
wait_deployed() {
  local sha=$1 state
  set -a; . "$BUNNY_ENV"; set +a
  for _ in $(seq 1 40); do
    state=$(curl -sS -H "Authorization: Bearer ${GITHUB_TOKEN:?}" \
      "https://api.github.com/repos/$REPO/actions/runs?head_sha=$sha&per_page=5" \
      | python3 -c 'import sys,json; r=json.load(sys.stdin).get("workflow_runs") or [{}]; print(r[0].get("status"), r[0].get("conclusion"))')
    case $state in
      "completed success") echo "+ выкладка $sha завершена"; return 0;;
      completed\ *) echo "✗ выкладка $sha: $state" >&2; return 1;;
    esac
    sleep 15
  done
  echo "✗ за 10 минут выкладка $sha не завершилась (${state:-нет прогона})" >&2; return 1
}
[ "${1:-}" = "--selftest-wait" ] && { wait_deployed "$2"; exit $?; }

slug=${1:?slug}; shift
msg=""; send=0; shot=1
while [ $# -gt 0 ]; do
  case $1 in
    -m) msg=$2; shift 2;;
    --send) send=1; shift;;
    --no-shot) shot=0; shift;;
    *) echo "unknown $1" >&2; exit 2;;
  esac
done

post=$(ls "$ROOT"/content/posts/*-"$slug".md 2>/dev/null | head -1)
[ -n "$post" ] || { echo "✗ нет поста content/posts/*-$slug.md" >&2; exit 2; }
title=$(sed -n 's/^title:[[:space:]]*"\{0,1\}\([^"]*\)"\{0,1\}$/\1/p' "$post" | head -1)
[ -n "$title" ] || { echo "✗ в $post нет title" >&2; exit 2; }
page="blog/$slug.html"

"$ROOT/scripts/build.sh"
[ -f "$ROOT/$page" ] || { echo "✗ сборка не дала $page" >&2; exit 3; }
[ -f "$ROOT/blog/covers/$slug.svg" ] || { echo "✗ нет обложки blog/covers/$slug.svg" >&2; exit 3; }
echo "+ собрано: $page, обложка есть"

if [ $shot = 1 ]; then
  out=${SHOT_DIR:-$(ls -td /tmp/claude-1000/*/*/scratchpad 2>/dev/null | head -1)}; out=${out:-/tmp}
  SHOT_SIZE="${SHOT_SIZE:-900,1500}" timeout 180 "$ROOT/scripts/shot.sh" "$page" "$out/$slug.png" | tail -1
  if python3 -c 'import PIL' 2>/dev/null; then
    python3 - "$out/$slug.png" "$out/$slug-small.png" <<'EOF'
import os, sys
from PIL import Image
im = Image.open(sys.argv[1]); im.thumbnail((600, 1000)); im.save(sys.argv[2])
print(f"+ смотреть: {sys.argv[2]} {im.size[0]}x{im.size[1]} {os.path.getsize(sys.argv[2]) // 1024} KB")
EOF
  else
    echo "! PIL нет — ужатой копии нет, смотреть $out/$slug.png"
  fi
fi

if [ $send = 0 ]; then
  echo "@@ не отправлено: посмотри снимок, затем --send -m \"Post: ...\"  # approved: main"
  exit 0
fi
[ -n "$msg" ] || { echo "✗ --send требует -m \"Post: ...\"" >&2; exit 2; }

cd "$ROOT"
paths=("content/posts/$(basename "$post")" blog feed.xml index.html)
git diff --quiet -- README.md || paths+=(README.md)
git add -- "${paths[@]}"
git diff --cached --quiet && { echo "✗ нечего коммитить" >&2; exit 4; }
git commit -q -m "$msg

Co-Authored-By: Claude Fable 5.1 <noreply@anthropic.com>"
echo "+ коммит $(git log --oneline -1)"
git push origin main:refs/heads/main 2>&1 | tail -1

live="$SITE/$page"
echo "@@ жду выкладки $live"
# Purging before every file has landed re-caches the old copy for ~296 days (seen 08.10.2026:
# "/" cached 13 s too early), so the purge waits for the whole deploy run.
[ -f "$BUNNY_ENV" ] || { echo "✗ нет $BUNNY_ENV — ни дождаться выкладки, ни сбросить кэш" >&2; exit 5; }
wait_deployed "$(git rev-parse HEAD)" || exit 5

if [ -f "$BUNNY_ENV" ]; then
  set -a; . "$BUNNY_ENV"; set +a
  # "/" and "/index.html" are separate cache keys at the edge, as are "/blog/" and its index.
  for u in "$SITE/" "$SITE/index.html" "$SITE/blog/" "$SITE/blog/index.html" "$SITE/feed.xml" "$live"; do
    enc=$(printf '%s' "$u" | python3 -c 'import sys,urllib.parse; print(urllib.parse.quote(sys.stdin.read(), safe=""))')
    code=$(curl -sS -o /dev/null -w '%{http_code}' -X POST "https://api.bunny.net/purge?url=${enc}&async=false" -H "AccessKey: ${BUNNY_API_KEY:?}")
    echo "+ кэш сброшен $u → $code"
  done
else
  echo "! нет $BUNNY_ENV — кэш не сброшен, пост виден только по прямой ссылке"
fi

curl -sf "$live" | grep -qF "$title" \
  || { echo "✗ на $live нет заголовка «$title»" >&2; exit 5; }
curl -sf "$SITE/blog/" | grep -qF "$slug.html" \
  && echo "+ в ленте блога: $SITE/blog/" || { echo "✗ в $SITE/blog/ поста нет" >&2; exit 6; }
echo "+ опубликовано: $live"
