#!/bin/sh

set -e
. "$(dirname "$0")/utils.sh"

require pandoc

mkdir -p "$SLIDES_DIR"

for md in "$MARKDOWN_DIR"/*.md; do
  [ -e "$md" ] || continue
  base=$(basename "$md" .md)
  output="$SLIDES_DIR/$base.html"
  echo "  - $base.md -> $base.html"
  render_slides "$md" "$output" "$TEMPLATES_DIR/slides.html"
done

ensure_assets
run_plugins
echo "[build_slides] Done."
