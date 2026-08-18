#!/usr/bin/env bash
# Generates index.html from README.md and the blog from content/posts,
# running Node inside a container. Node is intentionally not installed on the host.
set -euo pipefail

PROJECT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

"${PROJECT_DIRECTORY}/scripts/lint-brands.sh"

docker run --rm \
  --volume "${PROJECT_DIRECTORY}:/workspace" \
  --workdir /workspace \
  --user "$(id -u):$(id -g)" \
  node:22-alpine sh -c 'node build.js && node build-blog.js'
