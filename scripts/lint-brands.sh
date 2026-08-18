#!/usr/bin/env bash
# Blog posts must not name any company, product or vendor. Technical standards are fine.
# The build fails on a match, so the rule does not depend on anyone's attention.
set -uo pipefail

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
  telegram slack discord whatsapp signal
  linkedin twitter youtube instagram
  jetbrains phpstorm vscode intellij
  jira confluence notion figma
  stripe paypal revolut wise
  grafana prometheus loki sentry datadog
  keycloak auth0 okta
)

found=0
for brand in "${BRANDS[@]}"; do
  matches=$(grep -rniE "\\b${brand}\\b" "$POSTS_DIRECTORY" 2>/dev/null || true)
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
