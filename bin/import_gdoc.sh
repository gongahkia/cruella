#!/bin/sh
# Import a Google Doc into content/ as Markdown using gdrive + pandoc
# Usage: bin/import_gdoc.sh <google_doc_id> [output_basename]
set -e

DOC_ID="$1"
BASENAME="$2"
[ -z "$DOC_ID" ] && { echo "Usage: $0 <google_doc_id> [output_basename]"; exit 1; }

if ! command -v gdrive >/dev/null 2>&1; then
  echo "[import_gdoc] 'gdrive' CLI not found. Install from https://github.com/prasmussen/gdrive" >&2
  exit 1
fi
if ! command -v pandoc >/dev/null 2>&1; then
  echo "[import_gdoc] pandoc is required" >&2
  exit 1
fi

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

OUT_DOCX="$TMP_DIR/doc.docx"

echo "[import_gdoc] Exporting Google Doc $DOC_ID as DOCX..."
# Export as DOCX (requires gdrive to be authenticated)
gdrive export --mime application/vnd.openxmlformats-officedocument.wordprocessingml.document "$DOC_ID" --force --path "$TMP_DIR" >/dev/null
# gdrive names file by document title; find the first .docx
DOCX_FILE=$(ls -1 "$TMP_DIR"/*.docx | head -n1)
[ -z "$DOCX_FILE" ] && { echo "[import_gdoc] Failed to export DOCX" >&2; exit 1; }

TITLE=$(basename "$DOCX_FILE" .docx)
[ -z "$BASENAME" ] && BASENAME=$(echo "$TITLE" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
MD_FILE="./content/${BASENAME}.md"

echo "[import_gdoc] Converting to Markdown: $MD_FILE"
# Convert DOCX to Markdown with pandoc; add simple front matter
echo "---" > "$MD_FILE"
echo "title: $TITLE" >> "$MD_FILE"
echo "---" >> "$MD_FILE"

pandoc "$DOCX_FILE" -t gfm >> "$MD_FILE"

echo "[import_gdoc] Done. Edit content in $MD_FILE"
