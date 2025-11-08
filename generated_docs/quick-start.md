# Quick Start Guide

## Installation

### 1. Prerequisites
```bash
# Ubuntu/Debian
sudo apt-get install -y pandoc texlive-xetex entr jq

# macOS (using Homebrew)
brew install pandoc basictex entr jq
```

### 2. Clone Repository
```bash
git clone https://github.com/gongahkia/cruella.git
cd cruella
```

### 3. Make Scripts Executable
```bash
chmod +x bin/*.sh bin/cruella plugins/*.sh
```

## Basic Usage

### Build All Formats
```bash
./bin/cruella build all
```

### Build Individual Formats
```bash
# HTML only
./bin/cruella build html

# PDF only
./bin/cruella build pdf

# Slides only
./bin/cruella build slides
```

### Watch Mode (Live Rebuild)
```bash
./bin/cruella watch
```

### Serve Locally
```bash
# Default: serve public/ on port 8080
./bin/cruella serve

# Custom directory and port
./bin/cruella serve public 3000
```

### Clean Generated Files
```bash
./bin/cruella clean
```

## Creating Content

### 1. Add Markdown File
Create a file in `content/` directory:

```bash
nano content/my-doc.md
```

### 2. Add Front Matter (Optional)
```markdown
---
title: My Amazing Document
---

# Your Content Here

This is a paragraph.
```

### 3. Build
```bash
./bin/cruella build all
```

### 4. View Output
- **HTML**: `public/my-doc.html`
- **PDF**: `pdfs/my-doc.pdf`
- **Slides**: `slides/my-doc.html`

## Testing Your Setup

### Sample Document
```bash
cat > content/test.md <<'EOF'
---
title: Test Document
---

# Hello Cruella

This is a **test** with `code`.

## Features
- Dark mode
- Search
- TOC

```python
print("Hello World!")
```
EOF

./bin/cruella build html
open public/test.html  # macOS
xdg-open public/test.html  # Linux
```

## Troubleshooting

### "pandoc: command not found"
```bash
sudo apt-get install pandoc
```

### "entr: command not found" (watch mode)
```bash
sudo apt-get install entr
```

### "jq: command not found" (search)
```bash
sudo apt-get install jq
```

### LaTeX Errors (PDF)
```bash
# Full TeX Live installation
sudo apt-get install texlive-full

# Or minimal
sudo apt-get install texlive-xetex texlive-fonts-recommended
```

### Permission Denied
```bash
chmod +x bin/cruella bin/*.sh plugins/*.sh
```

## Next Steps

- Read [Enhancements](enhancements.md) for full feature documentation
- Check [Roadmap](roadmap.md) for future plans
- Browse [Advanced Features](../content/advanced-features.md) guide

---

**Questions?** Check the generated_docs/ folder or open a GitHub issue.
