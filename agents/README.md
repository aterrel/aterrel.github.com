# Claude Code Content Pipeline

This directory contains agent configurations for a 4-stage content creation pipeline using Claude Code.

## Overview

The pipeline transforms a topic idea into a published blog post through four specialized agents:

```
Topic → Writer → Editor → SEO → Publisher → Live Post
```

## Workflow

### 1. Writer Agent
**Invoke with:** `claude "Read agents/writer.md and create a post about [TOPIC]"`

- Takes a topic idea or outline
- Creates initial draft with proper Pelican metadata
- Outputs to `agents/handoffs/draft-{slug}.md`

### 2. Editor Agent
**Invoke with:** `claude "Read agents/editor.md and edit agents/handoffs/draft-{slug}.md"`

- Reviews draft for clarity, grammar, and flow
- Ensures consistent tone with existing posts
- Outputs to `agents/handoffs/edited-{slug}.md`

### 3. SEO Agent
**Invoke with:** `claude "Read agents/seo.md and optimize agents/handoffs/edited-{slug}.md"`

- Optimizes tags for discoverability
- Reviews title and slug for engagement
- Outputs to `agents/handoffs/final-{slug}.md`

### 4. Publisher Agent
**Invoke with:** `claude "Read agents/publisher.md and publish agents/handoffs/final-{slug}.md"`

- Moves file to `content/posts/` with proper naming
- Sets final publication date
- Runs `make html` to verify build
- Optionally deploys with `make github`

## File Naming Convention

```
agents/handoffs/draft-{slug}.md    # After Writer
agents/handoffs/edited-{slug}.md   # After Editor
agents/handoffs/final-{slug}.md    # After SEO
content/posts/{date}-{slug}.md     # After Publisher
```

## Quick Start

```bash
# Full pipeline example
claude "Read agents/writer.md and create a post about Python packaging best practices"
claude "Read agents/editor.md and edit agents/handoffs/draft-python-packaging-best-practices.md"
claude "Read agents/seo.md and optimize agents/handoffs/edited-python-packaging-best-practices.md"
claude "Read agents/publisher.md and publish agents/handoffs/final-python-packaging-best-practices.md"
```

## Handoffs Directory

The `handoffs/` subdirectory is the working area where drafts move between agents. Files here are intermediate and can be cleaned up after publishing.
