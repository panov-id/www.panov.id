#!/usr/bin/env bash
# Cases for publish-post.sh seen(): the edge cache wait (27.10.2026: /blog/ caught up after more than 90 s).
# A local HTTP server stands in for the site; no network beyond 127.0.0.1.
#   scripts/test-publish-post-seen.sh [path/to/publish-post.sh]
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="${1:-$ROOT/scripts/publish-post.sh}"
dir=$(mktemp -d); port=$((20000 + RANDOM % 20000))
echo "old page" > "$dir/page.html"
python3 -m http.server "$port" --bind 127.0.0.1 --directory "$dir" >/dev/null 2>&1 &
server=$!
trap 'kill $server 2>/dev/null; rm -rf "$dir"' EXIT
for _ in 1 2 3 4 5 6 7 8 9 10; do curl -sf "http://127.0.0.1:$port/page.html" >/dev/null && break; sleep 0.3; done
url="http://127.0.0.1:$port/page.html"
pass=0; total=0
check() {  # name, expected rc, actual rc, output, expected text
  total=$((total + 1))
  if [ "$2" = "$3" ] && grep -qF "$5" <<<"$4"; then pass=$((pass + 1)); echo "ok   $1"; else echo "FAIL $1 (rc $3, out: $4)"; fi
}

out=$(SEEN_TRIES=1 "$SCRIPT" --selftest-seen "$url" "old page" 2>&1); check "present: found" 0 $? "$out" "+ найдено"
out=$(SEEN_TRIES=1 "$SCRIPT" --selftest-seen "$url" "new page" 2>&1); check "absent: fails, seconds from SEEN_TRIES" 1 $? "$out" "за 10 с"
( sleep 12; echo "new page" > "$dir/page.html" ) &
out=$(SEEN_TRIES=3 "$SCRIPT" --selftest-seen "$url" "new page" 2>&1); check "appears after 12 s: found on a retry" 0 $? "$out" "+ найдено"
echo "old page" > "$dir/page.html"
default=$(grep -oE 'SEEN_TRIES=\$\{SEEN_TRIES:-[0-9]+\}' "$SCRIPT" | grep -oE '[0-9]+')
check "default wait is 6 min (36 tries)" 0 0 "${default:-none}" "36"

echo "$pass of $total"
[ "$pass" = "$total" ]
