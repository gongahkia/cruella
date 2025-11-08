#!/bin/sh

set -e
. "$(dirname "$0")/utils.sh"

require pandoc

mkdir -p "$PDF_DIR"

for md in "$MARKDOWN_DIR"/*.md; do
  [ -e "$md" ] || continue
  base=$(basename "$md" .md)
  output="$PDF_DIR/$base.pdf"
  echo "  - $base.md -> $base.pdf"
  render_pdf "$md" "$output"
done

run_plugins
echo "[build_pdf] Done."
