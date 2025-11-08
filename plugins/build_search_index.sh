#!/bin/sh
# Plugin: build search index (index.json) from markdown front matter + content
set -e
MARKDOWN_DIR="${MARKDOWN_DIR:-./content}"
HTML_DIR="${HTML_DIR:-./public}"
OUT="$HTML_DIR/index.json"

command -v jq >/dev/null 2>&1 || { echo "[search_index] jq not installed, skipping."; exit 0; }

printf '[' > "$OUT.tmp"
first=1
for f in "$MARKDOWN_DIR"/*.md; do
  [ -e "$f" ] || continue
  title=$(awk -v k="title" 'BEGIN{inmeta=0} /^---[[:space:]]*$/{if(inmeta==0){inmeta=1;next}else{exit}} inmeta==1 && $0 ~ "^"k":" {sub("^"k":[ ]*", "", $0); print; exit}' "$f")
  [ -z "$title" ] && title="$(basename "$f" .md)"
  description=$(awk -v k="description" 'BEGIN{inmeta=0} /^---[[:space:]]*$/{if(inmeta==0){inmeta=1;next}else{exit}} inmeta==1 && $0 ~ "^"k":" {sub("^"k":[ ]*", "", $0); print; exit}' "$f")
  tags=$(awk -v k="tags" 'BEGIN{inmeta=0} /^---[[:space:]]*$/{if(inmeta==0){inmeta=1;next}else{exit}} inmeta==1 && $0 ~ "^"k":" {sub("^"k":[ ]*", "", $0); print; exit}' "$f" | sed 's/,\s*/,/g')
  body=$(awk 'BEGIN{inmeta=0;done=0} /^---[[:space:]]*$/{if(inmeta==0){inmeta=1;next}else{done=1;next}} inmeta==1 && done==0 {next} {print}' "$f" | tr '\n' ' ' | sed 's/"/\\"/g')
  file="$(basename "$f" .md).html"
  if [ $first -eq 0 ]; then printf ',' >> "$OUT.tmp"; fi
  first=0
  printf '{"title":"%s","file":"%s","description":"%s","tags":"%s","content":"%s"}' "$title" "$file" "$description" "$tags" "$body" >> "$OUT.tmp"
done
printf ']' >> "$OUT.tmp"
mv "$OUT.tmp" "$OUT"
chmod 644 "$OUT"
echo "[search_index] Wrote $OUT"
