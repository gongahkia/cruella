#!/bin/sh

. "$(dirname "$0")/utils.sh"

if ! command -v pandoc >/dev/null 2>&1; then
  echo "[build_pdf] pandoc not found, skipping PDF build"
  exit 0
fi

if ! command -v xelatex >/dev/null 2>&1 && ! command -v pdflatex >/dev/null 2>&1; then
  echo "[build_pdf] LaTeX not found (xelatex or pdflatex required), skipping PDF build"
  exit 0
fi

mkdir -p "$PDF_DIR"

for md in "$MARKDOWN_DIR"/*.md; do
  [ -e "$md" ] || continue
  base=$(basename "$md" .md)
  output="$PDF_DIR/$base.pdf"
  echo "  - $base.md -> $base.pdf"
  render_pdf "$md" "$output" || echo "[build_pdf] Failed to build $base.pdf"
done

run_plugins
echo "[build_pdf] Done."
