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

# Собранная страница обязана нести код таким же, каким он написан в посте.
# Проверка стоит здесь, а не в памяти: перекос отступа в блоке кода не виден ни
# в исходнике, ни в разметке — только на картинке, и ровно поэтому он прожил
# в шести постах из девятнадцати незамеченным.
"${PROJECT_DIRECTORY}/scripts/check-code-blocks.sh"
