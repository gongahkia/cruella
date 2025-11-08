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

# Check for required LaTeX packages by testing pandoc PDF generation
test_md=$(mktemp --suffix=.md)
test_pdf=$(mktemp --suffix=.pdf)
echo "# Test" > "$test_md"
if ! pandoc "$test_md" --pdf-engine=pdflatex -o "$test_pdf" >/dev/null 2>&1; then
  rm -f "$test_md" "$test_pdf"
  echo "[build_pdf] LaTeX installation incomplete (missing required packages for pandoc)"
  # Detect package manager and provide appropriate install command
  if command -v apt >/dev/null 2>&1; then
    echo "[build_pdf] Install: sudo apt install texlive-latex-base texlive-fonts-recommended texlive-latex-extra"
  elif command -v dnf >/dev/null 2>&1; then
    echo "[build_pdf] Install: sudo dnf install texlive-ec texlive-collection-fontsrecommended texlive-footnotehyper"
  elif command -v yum >/dev/null 2>&1; then
    echo "[build_pdf] Install: sudo yum install texlive-ec texlive-collection-fontsrecommended texlive-footnotehyper"
  else
    echo "[build_pdf] Install required LaTeX packages for your system"
  fi
  echo "[build_pdf] Skipping PDF build. HTML and slides are available."
  exit 0
fi
rm -f "$test_md" "$test_pdf"

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
