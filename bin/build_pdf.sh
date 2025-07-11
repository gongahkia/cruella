#!/bin/sh

set -e
. "$(dirname "$0")/utils.sh"

require pandoc

mkdir -p "$PDF_DIR"

for md in "$MARKDOWN_DIR"/*.md; do
  [ -e "$md" ] || continue
  base=$(basename "$md" .md)
  output="$PDF_DIR/$base.pdf"
  render_pdf "$md" "$output"
done
