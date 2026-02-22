# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal blog/portfolio website built with **Pelican** (Python static site generator). The site is hosted at `andy.terrel.us` via GitHub Pages.

## Build Commands

```bash
# Install dependencies
pip install -r requirements.txt

# Development server with auto-reload (runs on http://localhost:8000)
make devserver

# Stop development server
make stopserver

# Generate static site (development)
make html

# Generate site with production settings
make publish

# Clean generated output
make clean

# Build and deploy to GitHub Pages (master branch)
make github
```

## Architecture

- **Content**: Markdown files in `content/posts/` and `content/pages/` with YAML front matter
- **Theme**: Custom Pelican theme in `theme/tuxlite_tbs/` (Jinja2 templates + static assets)
- **Config**: `pelicanconf.py` (development) and `publishconf.py` (production)
- **Output**: Generated HTML goes to `output/` directory (gitignored)

## Content Format

Posts use this metadata format:
```markdown
Title: Post Title
Author: Andy R. Terrel
Date: YYYY-MM-DD
Tags: tag1, tag2
Slug: url-slug

Content here...
```

## Git Workflow

- `source` branch: Content and source files (main development branch)
- `master` branch: Built output for GitHub Pages deployment
- `make github` handles building and pushing to master
