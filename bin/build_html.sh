#!/bin/sh

set -e
. "$(dirname "$0")/utils.sh"

require pandoc

mkdir -p "$HTML_DIR"

echo "[build_html] Source: $MARKDOWN_DIR -> $HTML_DIR"
count=0
for md in "$MARKDOWN_DIR"/*.md; do
  [ -e "$md" ] || continue
  base=$(basename "$md" .md)
  output="$HTML_DIR/$base.html"
  echo "  - $base.md -> $base.html"
  render_markdown "$md" "$output" "$TEMPLATES_DIR/base.html"
  count=$((count+1))
done

ensure_assets
run_plugins
echo "[build_html] Completed $count file(s)."
