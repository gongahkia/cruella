---
title: Getting Started with Cruella
description: Quick tour of Cruella features and how to build outputs
tags: getting-started, quickstart, docs
---

# Welcome to Cruella

Cruella is a **multi-format documentation generator** that transforms Markdown files into beautiful HTML, PDF, and presentation slides.

## Features

- 🎨 Dark/Light theme toggle
- 🔍 Client-side search
- 📱 Responsive design
- 🔌 Plugin system
- ⚡ Watch mode for live rebuilds

## Quick Start

### Installation

```bash
# Install dependencies
sudo apt-get install pandoc texlive-xetex entr jq

# Clone repository
git clone https://github.com/gongahkia/cruella.git
cd cruella
```

### Build Commands

```bash
# Build all formats
./bin/cruella build all

# Build individual formats
./bin/cruella build html
./bin/cruella build pdf
./bin/cruella build slides

# Watch mode (auto-rebuild)
./bin/cruella watch

# Serve locally
./bin/cruella serve public 8080
```

## Writing Content

Create Markdown files in the `content/` directory with optional YAML front matter:

```markdown
---
title: My Amazing Document
---

# Heading

Your content here...
```

## Plugin Development

Plugins are executable shell scripts in `plugins/` directory:

```bash
#!/bin/sh
# Example plugin
echo "Hello from plugin!"
```

Make it executable:

```bash
chmod +x plugins/my_plugin.sh
```

## Code Examples

### Python

```python
def greet(name):
    """Say hello to someone."""
    return f"Hello, {name}!"

print(greet("Cruella"))
```

### JavaScript

```javascript
const calculateSum = (a, b) => {
  return a + b;
};

console.log(calculateSum(5, 3));
```

## Tables

| Feature | HTML | PDF | Slides |
|---------|------|-----|--------|
| Dark Mode | ✅ | ❌ | ❌ |
| Search | ✅ | ❌ | ✅ |
| TOC | ✅ | ✅ | ✅ |

## Blockquotes

> "Simplicity is the ultimate sophistication."  
> — Leonardo da Vinci

## Next Steps

1. Read the [Enhancements Documentation](../generated_docs/enhancements.md)
2. Check out the [Roadmap](../generated_docs/roadmap.md)
3. Start creating your content!

---

**Happy documenting! 🚀**
