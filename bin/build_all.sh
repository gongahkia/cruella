#!/bin/sh
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

"$SCRIPT_DIR/build_html.sh"
"$SCRIPT_DIR/build_pdf.sh"
"$SCRIPT_DIR/build_slides.sh"

echo "[build_all] Complete."
