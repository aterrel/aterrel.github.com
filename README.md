# Codematician

Andy R. Terrel's personal website at [andy.terrel.us](https://andy.terrel.us).

Built with [Pelican](https://getpelican.com/), a Python static site generator.

## Site Structure

```
content/
├── posts/           # Blog posts (Markdown with YAML front matter)
├── pages/           # Static pages (Vita)
├── figures/         # Images for posts
└── papers_and_talks/  # PDFs of publications and presentations
```

### Blog

Posts are Markdown files in `content/posts/` with this format:

```markdown
Title: Post Title
Author: Andy R. Terrel
Date: YYYY-MM-DD
Tags: tag1, tag2
Slug: url-slug

Content here...
```

Published at: `andy.terrel.us/blog/YYYY/MM/DD/{slug}/`

### Vita

Academic CV and professional history at [andy.terrel.us/vita/](https://andy.terrel.us/vita/).

Source: `content/pages/vita.md`

### Papers and Talks

PDFs of publications, theses, and presentation slides in `content/papers_and_talks/`.

## Development

```bash
# Install dependencies
pip install -r requirements.txt

# Run dev server (http://localhost:8000)
make devserver

# Stop dev server
make stopserver

# Build site
make html

# Build and deploy to GitHub Pages
make github
```

## Theme

Custom Pelican theme in `theme/tuxlite_tbs/` using Jinja2 templates.

## Git Workflow

- `source` branch: Content and source files (main development)
- `master` branch: Built output for GitHub Pages

## Content Pipeline (Claude Code Agents)

Four agents in `agents/` automate blog post creation:

| Agent | Input | Output | Purpose |
|-------|-------|--------|---------|
| Writer | Topic idea | `handoffs/draft-{slug}.md` | Creates initial draft |
| Editor | Draft file | `handoffs/edited-{slug}.md` | Refines clarity and tone |
| SEO | Edited file | `handoffs/final-{slug}.md` | Optimizes for search |
| Publisher | Final file | `content/posts/{date}-{slug}.md` | Publishes to site |

Usage:
```bash
claude "Read agents/writer.md and create a post about [TOPIC]"
claude "Read agents/editor.md and edit agents/handoffs/draft-{slug}.md"
claude "Read agents/seo.md and optimize agents/handoffs/edited-{slug}.md"
claude "Read agents/publisher.md and publish agents/handoffs/final-{slug}.md"
```

See `agents/README.md` for detailed workflow documentation.
