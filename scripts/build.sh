#!/usr/bin/env bash
# Generates index.html from README.md by running build.js inside a Node container.
# Node is intentionally not installed on the host.
set -euo pipefail

PROJECT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

docker run --rm \
  --volume "${PROJECT_DIRECTORY}:/workspace" \
  --workdir /workspace \
  --user "$(id -u):$(id -g)" \
  node:22-alpine node build.js
