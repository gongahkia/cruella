#!/bin/sh

set -e
. "$(dirname "$0")/utils.sh"

require pandoc

mkdir -p "$HTML_DIR"

for md in "$MARKDOWN_DIR"/*.md; do
  [ -e "$md" ] || continue
  base=$(basename "$md" .md)
  output="$HTML_DIR/$base.html"
  render_markdown "$md" "$output" "$TEMPLATES_DIR/base.html"
done
