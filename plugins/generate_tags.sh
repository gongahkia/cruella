#!/bin/sh
# Plugin: generate tag index pages from front matter tags
set -e
MARKDOWN_DIR="${MARKDOWN_DIR:-./content}"
HTML_DIR="${HTML_DIR:-./public}"
OUT_DIR="$HTML_DIR/tags"
mkdir -p "$OUT_DIR"

# Collect tags
TMP_TAGS=$(mktemp)
for f in "$MARKDOWN_DIR"/*.md; do
  [ -e "$f" ] || continue
  tags=$(awk -v k="tags" 'BEGIN{inmeta=0} /^---[[:space:]]*$/{if(inmeta==0){inmeta=1;next}else{exit}} inmeta==1 && $0 ~ "^"k":" {sub("^"k":[ ]*", "", $0); print; exit}' "$f" | sed 's/,\s*/,/g')
  [ -z "$tags" ] && continue
  for t in $(printf "%s" "$tags" | tr ',' ' '); do
    printf '%s;%s\n' "$t" "$(basename "$f" .md).html" >> "$TMP_TAGS"
  done
done

[ ! -s "$TMP_TAGS" ] && { echo "[tags] No tags found"; rm -f "$TMP_TAGS"; exit 0; }

ALL_TAGS=$(cut -d';' -f1 "$TMP_TAGS" | sort -u)

# Build master tags index fragment (HTML list)
INDEX_FRAGMENT="$HTML_DIR/tagindex.html"
{
  echo '<ul class="tags-list">'
  for tag in $ALL_TAGS; do
    count=$(grep -c "^$tag;" "$TMP_TAGS")
    echo "  <li><a href=\"tags/$tag.html\">$tag</a> <small>($count)</small></li>"
  done
  echo '</ul>'
} > "$INDEX_FRAGMENT"

# Generate individual tag pages (simple static HTML)
for tag in $ALL_TAGS; do
  page="$OUT_DIR/$tag.html"
  {
    echo "<!DOCTYPE html>"
    echo "<html lang=\"en\">"
    echo "<head><meta charset=\"utf-8\"/><title>Tag: $tag</title><link rel=\"stylesheet\" href=\"../style.css\"/></head>"
    echo "<body><div class=\"content\"><h1>Tag: $tag</h1><ul>"
    grep "^$tag;" "$TMP_TAGS" | while IFS=';' read -r t file; do
      # Attempt to find title inside generated HTML (fallback to filename)
      title=$(grep -m1 '<h1>' "$HTML_DIR/$file" | sed 's/<h1>//;s/<\/h1>//' | head -n1)
      [ -z "$title" ] && title="${file%.html}";
      echo "<li><a href=\"../$file\">$title</a></li>"
    done
    echo "</ul><p><a href=\"../index.html\">Home</a></p></div></body></html>"
  } > "$page"
  echo "[tags] Built tags/$tag.html"
  
  # Inject tag index placeholder replacement into main HTML pages (optional augmentation)
  # Replace $tagindex$ token with generated index fragment content
  for html in "$HTML_DIR"/*.html; do
    [ -e "$html" ] || continue
    if grep -q '\$tagindex\$' "$html"; then
      sed "/\\$tagindex\\$/r $INDEX_FRAGMENT" -e "s/\\$tagindex\\$//" "$html" > "$html.tmp" && mv "$html.tmp" "$html"
    fi
  done
done

echo "[tags] Tag index generated."
rm -f "$TMP_TAGS"
