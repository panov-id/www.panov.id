#!/usr/bin/env bash
# Blog posts must not name any company, product or vendor. Technical standards are fine.
# The build fails on a match, so the rule does not depend on anyone's attention.
set -uo pipefail
# Under the C locale grep's \b and [а-я] silently match no Cyrillic at all (checked 08.10.2026),
# so a CI runner without a locale would pass «хайку» through. Force UTF-8.
export LC_ALL=C.UTF-8

PROJECT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
POSTS_DIRECTORY="${PROJECT_DIRECTORY}/content/posts"

[ -d "$POSTS_DIRECTORY" ] || { echo "нет каталога постов, проверять нечего"; exit 0; }

BRANDS=(
  git github gitlab bitbucket
  docker kubernetes
  mysql mariadb postgres postgresql redis sqlite
  laravel symfony django rails react vue angular svelte nextjs
  node nodejs npm yarn pnpm composer
  nginx apache caddy traefik
  vault hashicorp consul terraform
  aws amazon azure google apple microsoft meta facebook
  bunny cloudflare fastly akamai digitalocean hetzner
  anthropic claude openai chatgpt gpt gemini copilot llama mistral
  haiku sonnet opus fable mythos codex
  # Модели пишут и кириллицей: 08.10.2026 «хайку» в цитате прошло сборку зелёным.
  # «сонет» и «опус» — обычные слова, их не берём; «соннет» с двумя «н» — только модель.
  # Under C.UTF-8 a range like [а-я] is a grep error («Invalid collation character»), so
  # endings are [[:alpha:]]*; the capital is spelled out in case -i does not fold Cyrillic.
  '[Хх]айку' '[Кк]лод[[:alpha:]]*' '[Сс]оннет[[:alpha:]]*' '[Аа]нтропик[[:alpha:]]*' '[Чч]атгпт' '[Дд]жемини'
  telegram slack discord whatsapp signal
  linkedin twitter youtube instagram
  jetbrains phpstorm vscode intellij
  jira confluence notion figma
  stripe paypal revolut wise
  grafana prometheus loki sentry datadog
  keycloak auth0 okta
  # Свои проекты — такие же бренды: пост пишется о работе, а не о том, чья она.
  # Раньше список знал только чужие названия, и «выкатили sosed.place» прошло бы
  # линтер насквозь.
  'xor\.ad' 'sosed\.place' 'neighbro\.place' 'panov\.id'
  psytican pejeded noisen 'redpill-player' 'soulseek-charts' 'sunset-residents'
)

found=0
for brand in "${BRANDS[@]}"; do
  matches=$(grep -rniE "\\b${brand}\\b" "$POSTS_DIRECTORY"); rc=$?
  # rc 2 is a broken pattern, not «no match»: it used to be swallowed and matched nothing.
  [ "$rc" -le 1 ] || { echo "ОШИБКА ШАБЛОНА: ${brand} (grep rc=$rc)"; exit 2; }
  if [ -n "$matches" ]; then
    echo "ЗАПРЕЩЁННОЕ УПОМИНАНИЕ: ${brand}"
    printf '%s\n' "$matches" | sed 's/^/    /'
    found=1
  fi
done

if [ "$found" -eq 1 ]; then
  echo
  echo "Замените на разговорное: «та самая СУБД», «хостинг репозиториев», «одна компания»."
  exit 1
fi

echo "упоминаний брендов не найдено"
