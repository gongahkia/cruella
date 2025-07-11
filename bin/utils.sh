#!/bin/sh

set -e

MARKDOWN_DIR="${MARKDOWN_DIR:-./content}"
HTML_DIR="${HTML_DIR:-./public}"
PDF_DIR="${PDF_DIR:-./pdfs}"
SLIDES_DIR="${SLIDES_DIR:-./slides}"
TEMPLATES_DIR="${TEMPLATES_DIR:-./templates}"

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

render_markdown() {
  input="$1"
  output="$2"
  template="$3"
  pandoc --from markdown --to html5 --standalone --template="$template" --css="$TEMPLATES_DIR/style.css" "$input" -o "$output"
}

render_pdf() {
  input="$1"
  output="$2"
  pandoc --from markdown --to pdf "$input" -o "$output"
}

render_slides() {
  input="$1"
  output="$2"
  template="$3"
  pandoc --from markdown --to revealjs --standalone --template="$template" --css="$TEMPLATES_DIR/style.css" "$input" -o "$output"
}
