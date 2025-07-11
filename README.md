[![](https://img.shields.io/badge/cruella_1.0.0-passing-green)](https://github.com/gongahkia/cruella/releases/tag/1.0.0)

# `Cruella`

...

**Cruella** is a powerful static publishing and conversion toolkit for Markdown-based content. It enables you to:

- Convert Markdown files to responsive HTML, PDF, and interactive Slides.
- Use custom templates for consistent, beautiful output.
- Serve your generated site locally for preview.
- Deploy your site to any remote server.
- Automate and customize your publishing workflow.

The project is fully POSIX shell compatible and designed for extensibility and reproducibility.

...

## Stack

* *Script*: [Bash](https://www.gnu.org/software/bash/)
* *Dependencies*: [Pandoc](https://pandoc.org/), [Python](https://www.python.org/), [rsync](https://linux.die.net/man/1/rsync)

## Usage

The below instructions are for running `Cruella` on your client machine.

1. Execute the below.

```console
$ git clone https://github.com/gongahkia/cruella && cd cruella && chmod +x bin/*
```

2. Place all Markdown files within [`./content/`](./content/).
3. Then run any of the following.

| Command | Purpose |
| :--- | :--- |
| `bin/cruella build html` | Build HTML site from Markdown files |
| `bin/cruella build pdf` | Build PDFs from Markdown files |
| `bin/cruella build slides` | Build Slides from Markdown files |
| `bin/cruella build all` | Run all Build Scripts |
| `bin/cruella clean` | Remove all generated files |
| `bin/cruella help` | Show all commands |
| `bin/cruella serve` | Serve any dirctory (`./public` by default) at [localhost:8000](http://localhost:8000) |
| `export DEPLOY_DEST="user@server:/var/www/html" && bin/cruella deploy` | Deploy the `public/` directory to a remote server |

## Architecture

```mermaid

```

## Reference

The name `Cruella` is in reference to [Cruella de Vil](https://disney.fandom.com/wiki/Cruella_De_Vil), the main antagonist of the [Disney](https://disney.fandom.com/wiki/Walt_Disney_Productions) classic [One Hundred and One Dalmatians](https://disney.fandom.com/wiki/One_Hundred_and_One_Dalmatians).

<div align="center">
    <img src="./asset/logo/cruella.png" width="35%">
</div>

## Customization

- **Templates:**  
  - Modify `templates/base.html`, `sidebar.html`, and `style.css` for HTML output.
  - Edit `templates/slides.html` for Reveal.js-based slides.

- **Sidebar Navigation:**  
  - The sidebar is auto-included in every page via `base.html` and can be customized in `sidebar.html`.

- **Environment Variables:**  
  - Override default directories by setting:
    - `MARKDOWN_DIR`, `HTML_DIR`, `PDF_DIR`, `SLIDES_DIR`, `TEMPLATES_DIR`
  - For deployment, set `DEPLOY_DEST`.

## Workflow Example

```sh
# 1. Add your .md files to content/
# 2. Build all outputs
bin/cruella build all

# 3. Preview the site locally
bin/cruella serve

# 4. Deploy to your server
export DEPLOY_DEST="user@host:/var/www/html"
bin/cruella deploy
```

## Advanced Usage

- **Add new Markdown files** to `content/` and rebuild.
- **Customize templates** in `templates/` for branding and layouts.
- **Integrate with CI/CD** by scripting calls to `bin/cruella`.
- **Extend scripts** in `bin/` for new formats or workflows.

## Troubleshooting

- **Pandoc not found:**  
  Ensure `pandoc` is installed and on your PATH.

- **Permission denied:**  
  Make sure all scripts in `bin/` are executable.

- **Deployment fails:**  
  Check your `DEPLOY_DEST` variable and SSH access.

## Contributing

- Fork the repo and submit pull requests for improvements.
- Report issues and suggest features.

## License

This project is released under the MIT License.

## Credits

- Built with Pandoc, Reveal.js, and POSIX shell scripting.
- Inspired by modern static site and publishing workflows.
