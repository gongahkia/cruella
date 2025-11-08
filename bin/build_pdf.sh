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

# Quick sanity check for working LaTeX installation
test_tex=$(mktemp --suffix=.tex)
echo '\documentclass{article}\begin{document}test\end{document}' > "$test_tex"
if ! pdflatex -interaction=nonstopmode -output-directory=/tmp "$test_tex" >/dev/null 2>&1; then
  rm -f "$test_tex"
  echo "[build_pdf] LaTeX installation incomplete (missing fonts/packages), skipping PDF build"
  echo "[build_pdf] Tip: sudo apt install texlive-latex-base texlive-fonts-recommended"
  exit 0
fi
rm -f "$test_tex" /tmp/texput.*

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
