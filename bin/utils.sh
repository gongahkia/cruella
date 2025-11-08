#!/bin/sh

set -e

# Directories (can be overridden via env)
MARKDOWN_DIR="${MARKDOWN_DIR:-./content}"
HTML_DIR="${HTML_DIR:-./public}"
PDF_DIR="${PDF_DIR:-./pdfs}"
SLIDES_DIR="${SLIDES_DIR:-./slides}"
TEMPLATES_DIR="${TEMPLATES_DIR:-./templates}"
PLUGINS_DIR="${PLUGINS_DIR:-./plugins}"

# Helper: command availability
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

require() {
  for cmd in "$@"; do
    if ! command_exists "$cmd"; then
      echo "Error: Required command '$cmd' not found." >&2
      exit 1
    fi
  done
}

# Extract a YAML front matter key (simple, first occurrence)
front_matter_value() {
  key="$1"; file="$2"
  awk -v k="$key" '
    BEGIN{inmeta=0}
    /^---[[:space:]]*$/{ if(inmeta==0){inmeta=1;next}else{exit} }
    inmeta==1 && $0 ~ "^"k":" {
      sub("^"k":[ ]*", "", $0); print; exit
    }' "$file"
}

# Copy static assets to output dirs
ensure_assets() {
  mkdir -p "$HTML_DIR" "$SLIDES_DIR"
  # Core stylesheet
  if [ -f "$TEMPLATES_DIR/style.css" ]; then
    cp -f "$TEMPLATES_DIR/style.css" "$HTML_DIR/style.css"
    cp -f "$TEMPLATES_DIR/style.css" "$SLIDES_DIR/style.css"
  fi
  # Optional search script
  if [ -f "$TEMPLATES_DIR/search.js" ]; then
    cp -f "$TEMPLATES_DIR/search.js" "$HTML_DIR/search.js"
  fi
}

# Plugin hook runner (executables in plugins/)
run_plugins() {
  [ -d "$PLUGINS_DIR" ] || return 0
  for plugin in "$PLUGINS_DIR"/*; do
    [ -x "$plugin" ] || continue
    echo "[plugins] Running $(basename "$plugin")"
    HTML_DIR="$HTML_DIR" MARKDOWN_DIR="$MARKDOWN_DIR" SLIDES_DIR="$SLIDES_DIR" PDF_DIR="$PDF_DIR" "$plugin" || echo "[plugins] Warning: $(basename "$plugin") failed"
  done
}

render_markdown() {
  input="$1"
  output="$2"
  template="$3"
  title="$(front_matter_value title "$input")"
  description="$(front_matter_value description "$input")"
  tags_line="$(front_matter_value tags "$input")"
  # normalize tags to comma-separated (no spaces around commas)
  tags_csv=$(printf "%s" "$tags_line" | sed 's/,\s*/,/g')
  [ -z "$title" ] && title="$(basename "$input" .md)"
  pandoc \
    --from markdown \
    --to html5 \
    --standalone \
    --template="$template" \
    --metadata title="$title" \
    ${description:+--metadata description="$description"} \
    ${tags_csv:+--metadata keywords="$tags_csv"} \
    --css="style.css" \
    --toc --toc-depth=3 \
    "$input" -o "$output"
}

render_pdf() {
  input="$1"
  output="$2"
  title="$(front_matter_value title "$input")"
  [ -z "$title" ] && title="$(basename "$input" .md)"
  
  # Detect available PDF engine (prefer pdflatex for simplicity)
  pdf_engine="pdflatex"
  if ! command_exists pdflatex && command_exists xelatex; then
    pdf_engine="xelatex"
  fi
  
  pandoc \
    --from markdown \
    --metadata title="$title" \
    --pdf-engine="$pdf_engine" \
    --resource-path=".:./content:./asset" \
    "$input" -o "$output"
}

render_slides() {
  input="$1"
  output="$2"
  template="$3"
  title="$(front_matter_value title "$input")"
  description="$(front_matter_value description "$input")"
  tags_line="$(front_matter_value tags "$input")"
  tags_csv=$(printf "%s" "$tags_line" | sed 's/,\s*/,/g')
  [ -z "$title" ] && title="$(basename "$input" .md)"
  pandoc \
    --from markdown \
    --to revealjs \
    --standalone \
    --template="$template" \
    --metadata title="$title" \
    ${description:+--metadata description="$description"} \
    ${tags_csv:+--metadata keywords="$tags_csv"} \
    --css="style.css" \
    --toc --toc-depth=2 \
    "$input" -o "$output"
}
