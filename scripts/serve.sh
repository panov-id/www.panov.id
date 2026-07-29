#!/usr/bin/env bash
# Serves the generated site on http://localhost:8080 for local preview.
set -euo pipefail

PROJECT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PORT="${1:-8080}"

exec python3 -m http.server "${PORT}" --directory "${PROJECT_DIRECTORY}" --bind 127.0.0.1
