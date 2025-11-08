#!/bin/sh
# Dependency checker for Cruella
# Run this before building to verify all dependencies are installed

set -e

echo "🔍 Checking Cruella Dependencies..."
echo ""

MISSING=0

check_cmd() {
  cmd="$1"
  desc="$2"
  required="$3"
  
  if command -v "$cmd" >/dev/null 2>&1; then
    version=$(command $cmd --version 2>&1 | head -n1 || echo "unknown")
    echo "✅ $desc: $version"
  else
    if [ "$required" = "required" ]; then
      echo "❌ $desc: NOT FOUND (REQUIRED)"
      MISSING=$((MISSING + 1))
    else
      echo "⚠️  $desc: NOT FOUND (optional)"
    fi
  fi
}

echo "Core Dependencies:"
check_cmd "pandoc" "Pandoc" "required"
check_cmd "sh" "POSIX Shell" "required"

echo ""
echo "PDF Support:"
check_cmd "xelatex" "XeLaTeX" "optional"
check_cmd "pdflatex" "pdfLaTeX" "optional"

echo ""
echo "Optional Features:"
check_cmd "entr" "entr (watch mode)" "optional"
check_cmd "jq" "jq (search index)" "optional"

echo ""
echo "Utilities:"
check_cmd "git" "Git" "optional"
check_cmd "rsync" "rsync" "optional"

echo ""
echo "─────────────────────────────────────────"

if [ $MISSING -eq 0 ]; then
  echo "✅ All required dependencies installed!"
  echo ""
  echo "Install optional dependencies:"
  echo "  Ubuntu/Debian: sudo apt-get install texlive-xetex entr jq"
  echo "  macOS:         brew install basictex entr jq"
  exit 0
else
  echo "❌ Missing $MISSING required dependencies"
  echo ""
  echo "Install required dependencies:"
  echo "  Ubuntu/Debian: sudo apt-get install pandoc"
  echo "  macOS:         brew install pandoc"
  exit 1
fi
