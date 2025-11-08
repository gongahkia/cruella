# Cruella Roadmap & Future Enhancements

**For Next-Generation Capabilities**

---

## 🔮 Phase 2: Advanced Features

### 1. **Lunr.js Integration**
Replace basic substring search with:
- Full-text indexing
- Relevance scoring
- Fuzzy matching
- Stemming support

**Implementation:**
```html
<script src="https://unpkg.com/lunr/lunr.js"></script>
```

### 2. **Tag & Category System**
- Parse `tags:` and `category:` from front matter
- Auto-generate tag pages (e.g., `tags/javascript.html`)
- Tag cloud visualization
- Filter by category in sidebar

**Example Plugin:**
```bash
#!/bin/sh
# plugins/generate_tag_pages.sh
# Extracts tags, groups files, generates index pages
```

### 3. **RSS Feed Generation**
- Plugin to generate `feed.xml`
- Include latest N documents
- Support Atom format
- Podcast-ready enclosures

### 4. **Markdown Extensions**
- **Mermaid diagrams** (via Pandoc filter)
- **Math rendering** (KaTeX or MathJax)
- **Footnotes** (Pandoc native)
- **Custom containers** (warning boxes, tips)

### 5. **Incremental Builds**
- Hash-based change detection
- Skip unchanged files
- Rebuild only affected dependencies
- Build cache directory (`.cruella/cache/`)

---

## 🐳 Phase 3: Deployment & CI/CD

### 1. **Dockerfile**
```dockerfile
FROM pandoc/latex:latest
RUN apk add --no-cache bash entr jq
COPY . /workspace
WORKDIR /workspace
CMD ["./bin/cruella", "build", "all"]
```

### 2. **GitHub Actions Workflow**
```yaml
name: Deploy Docs
on:
  push:
    branches: [main]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build
        run: |
          sudo apt-get install -y pandoc texlive-xetex entr jq
          ./bin/cruella build all
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
```

### 3. **Netlify/Vercel Support**
- `netlify.toml` config
- Build command: `bin/cruella build html`
- Publish directory: `public/`

### 4. **CI Caching**
```yaml
- uses: actions/cache@v3
  with:
    path: |
      ~/.cache/pandoc
      public/
    key: ${{ runner.os }}-cruella-${{ hashFiles('content/**/*.md') }}
```

---

## 🎨 Phase 4: UI/UX Enhancements

### 1. **Sidebar Navigation Tree**
- Collapsible sections
- Active page highlighting
- Breadcrumb trail
- Auto-scroll to current page

### 2. **Reading Progress Bar**
- Top-of-page indicator
- Percentage-based
- Smooth animations

### 3. **Print Styles**
- Hide sidebar on print
- Expand code blocks
- Page break hints
- Footer with URL

### 4. **Mobile-First Redesign**
- Hamburger menu for sidebar
- Touch-optimized search
- Swipe gestures in slides
- Responsive tables

### 5. **Code Copy Button**
- One-click copy for code blocks
- Tooltip confirmation
- Syntax-agnostic

---

## 🔌 Phase 5: Plugin Ecosystem

### Community Plugin Ideas

#### SEO Optimizer
- Auto-generate `meta` tags
- OpenGraph images
- Sitemap.xml
- robots.txt

#### Analytics Injector
- Insert Google Analytics
- Plausible.io support
- Privacy-friendly tracking
- Cookie consent banner

#### Image Optimizer
- Compress PNGs/JPEGs
- Generate WebP versions
- Lazy loading attributes
- Responsive srcset

#### Spell Checker
- Aspell integration
- Ignore code blocks
- Custom dictionary support
- CI-friendly exit codes

#### Link Validator
- Check internal links
- Validate external URLs
- Report broken references
- Auto-fix relative paths

---

## 📱 Phase 6: Content Ingestion

### 1. **Google Docs Exporter**
```bash
# plugins/import_gdocs.sh
# Uses Google Docs API to export as Markdown
# Requires: gdrive CLI tool
```

### 2. **Notion Integration**
- Export Notion pages
- Preserve formatting
- Download embedded images
- Map Notion DB to tags

### 3. **Confluence Importer**
- REST API integration
- Convert wiki markup
- Preserve attachments

### 4. **Obsidian Vault Sync**
- Watch Obsidian vault
- Convert wiki-links
- Sync bidirectionally

---

## 🧪 Phase 7: Quality Assurance

### 1. **Testing Suite**
- `bats-core` for shell script tests
- Example tests:
  ```bash
  @test "render_markdown produces valid HTML" {
    run render_markdown test.md output.html
    [ "$status" -eq 0 ]
    grep -q "<html" output.html
  }
  ```

### 2. **Linting**
- `shellcheck` for shell scripts
- `markdownlint` for content
- `htmlproofer` for generated HTML
- Pre-commit hooks

### 3. **Performance Profiling**
- Build time tracking per file
- Plugin execution metrics
- Memory usage monitoring
- Parallelization opportunities

### 4. **Security Scanning**
- Dependency vulnerability checks
- XSS prevention in search
- CSP header generation
- Subresource Integrity (SRI)

---

## 🌐 Phase 8: Internationalization (i18n)

### 1. **Multi-Language Support**
- Language-specific content dirs (`content/en/`, `content/zh/`)
- Language switcher in UI
- RTL layout support
- Locale-aware date formatting

### 2. **Translation Workflow**
- PO/MO file generation
- Integration with Crowdin/Transifex
- Fuzzy matching for updates
- Machine translation fallback

---

## 🚀 Phase 9: Advanced Slides Features

### 1. **Live Presentation Mode**
- WebSocket-based sync
- Speaker view on separate screen
- Audience participation (polls)
- Q&A sidebar

### 2. **Recording Integration**
- Export to video (Puppeteer + FFmpeg)
- Timed slide transitions
- Voiceover narration
- Auto-generated captions

### 3. **Interactive Elements**
- Embed live demos (CodePen, JSFiddle)
- Interactive charts (Chart.js, D3.js)
- Form inputs for quizzes
- Gamification (points, badges)

---

## 📊 Phase 10: Analytics & Insights

### 1. **Content Analytics**
- Most-viewed pages
- Search query logs (anonymized)
- Read time estimates
- Popular tags

### 2. **Build Analytics**
- Slowest files to compile
- Plugin execution times
- Dependency graph visualization
- Cache hit rates

### 3. **Quality Metrics**
- Readability scores (Flesch-Kincaid)
- Average sentence length
- Passive voice detection
- Grade-level estimates

---

## 🔧 Phase 11: Developer Tools

### 1. **VS Code Extension**
- Syntax highlighting for front matter
- Live preview pane
- Build task integration
- Snippet library

### 2. **CLI Enhancements**
- Subcommand for creating new pages
- Template scaffolding (`cruella new post`)
- Interactive mode (prompts)
- JSON output for scripting

### 3. **Configuration File**
- `cruella.toml` for project settings
- Override default directories
- Plugin enable/disable flags
- Custom Pandoc options

### 4. **Hot Module Replacement (HMR)**
- Live browser reload
- Preserve scroll position
- Diff-based updates
- WebSocket server

---

## 🎯 Hackathon-Specific Quick Wins

### Immediate Impact (< 2 hours)
1. **Add favicon support** (copy `favicon.ico` to output)
2. **Logo in sidebar** (image placeholder in `sidebar.html`)
3. **Social share buttons** (Twitter, LinkedIn)
4. **Estimated read time** (word count / 200)
5. **"Edit on GitHub" link** (if repo is public)

### Medium Effort (< 1 day)
1. **Export to EPUB** (Pandoc native format)
2. **Mermaid diagram support** (Pandoc filter + JS library)
3. **Sidebar sticky header** (CSS `position: sticky`)
4. **Code syntax themes** (dropdown selector)
5. **Customizable color scheme** (CSS variables UI)

### Stretch Goals (2-3 days)
1. **Full-text search with Algolia**
2. **Version control integration** (show last modified date from git)
3. **Automated screenshot generation** (Puppeteer)
4. **PDF watermarking** (ImageMagick)
5. **Multi-user collaboration** (real-time editing via Operational Transform)

---

## 📋 Implementation Priorities

### Must-Have (Core Differentiators)
- [x] Front matter support
- [x] Search functionality
- [x] Dark mode
- [x] Plugin system
- [x] Watch mode
- [ ] Tag pages
- [ ] Dockerfile
- [ ] GitHub Actions

### Should-Have (Competitive Edge)
- [ ] Lunr.js search
- [ ] RSS feed
- [ ] Incremental builds
- [ ] Mobile improvements
- [ ] Link validation

### Nice-to-Have (Polish)
- [ ] Reading progress
- [ ] Code copy buttons
- [ ] Mermaid diagrams
- [ ] i18n support
- [ ] VS Code extension

---

## 🤝 Community Contributions

### How to Contribute Plugins
1. Fork repository
2. Add plugin to `plugins/` directory
3. Document in `generated_docs/plugin_name.md`
4. Submit PR with tests
5. Add to plugin registry (future)

### Plugin Registry Structure (Proposed)
```json
{
  "name": "SEO Optimizer",
  "version": "1.0.0",
  "author": "username",
  "description": "Generates meta tags and sitemap",
  "dependencies": ["jq"],
  "install": "curl -o plugins/seo.sh ...",
  "license": "MIT"
}
```

---

## 📈 Success Metrics

### Adoption KPIs
- GitHub stars/forks
- Plugin contributions
- Community showcase entries
- Documentation coverage

### Performance KPIs
- Build time per file (target: <100ms HTML)
- Plugin execution overhead (target: <10% total time)
- Output size (target: <50KB per HTML page)
- Accessibility score (target: Lighthouse 95+)

---

## 🛡️ Long-Term Maintenance

### Sustainability Plan
1. **Documentation first** – every feature documented
2. **Backward compatibility** – deprecation warnings, migration guides
3. **Semantic versioning** – clear release notes
4. **Security policy** – vulnerability reporting process
5. **Governance model** – maintainer rotation, decision-making

---

**Last Updated:** November 8, 2025  
**Status:** Living Document  
**Next Review:** After Hackathon Feedback
