#!/bin/sh
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MARKDOWN_DIR="${MARKDOWN_DIR:-./content}"

if ! command -v entr >/dev/null 2>&1; then
  echo "Please install 'entr' to use watch mode (Ubuntu/Debian: sudo apt-get install entr)" >&2
  exit 1
fi

echo "[watch] Watching $MARKDOWN_DIR for changes..."
find "$MARKDOWN_DIR" -type f -name "*.md" | sort | \
entr -r sh -c "$SCRIPT_DIR/build_all.sh && echo '[watch] Rebuilt at '$(date)"
