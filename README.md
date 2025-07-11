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
* *Dependencies*: [Pandoc](https://pandoc.org/), [Reveal.js](https://revealjs.com/),  [Python](https://www.python.org/), [rsync](https://linux.die.net/man/1/rsync)

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
| `bin/cruella help` | Show all available commands |
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