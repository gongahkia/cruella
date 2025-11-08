#!/bin/sh
# Plugin: append invisible build stamp to generated HTML files
set -e
HTML_DIR="${HTML_DIR:-./public}"
stamp="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
for html in "$HTML_DIR"/*.html; do
  [ -e "$html" ] || continue
  if ! grep -q 'data-build-stamp' "$html"; then
    printf '\n<!-- build stamp --><div data-build-stamp="%s" style="display:none"></div>\n' "$stamp" >> "$html"
  fi
done
echo "[postprocess] Added build stamp to HTML files."
