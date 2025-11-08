#!/bin/sh

set -e

DIR="${1:-./public}"
PORT="${PORT:-8000}"

if command -v python3 >/dev/null 2>&1; then
  cd "$DIR"
  python3 -m http.server "$PORT"
elif command -v python >/dev/null 2>&1; then
  cd "$DIR"
  python -m SimpleHTTPServer "$PORT"
else
  echo "Error: Python is required to serve files." >&2
  exit 1
fi
