#!/bin/sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

"$SCRIPT_DIR/build_html.sh"
"$SCRIPT_DIR/build_pdf.sh" || echo "[build_all] PDF build failed (LaTeX not installed?)"
"$SCRIPT_DIR/build_slides.sh"

echo "[build_all] Complete."
