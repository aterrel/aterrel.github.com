# Claude Code Content Pipeline

This directory contains agent configurations for a 4-stage content creation pipeline using Claude Code.

## Overview

The pipeline transforms a topic idea into a published blog post through four specialized agents:

```
Topic → Writer → Editor → SEO → Publisher → Live Post
```

**Automated handoffs**: Each agent automatically launches the next agent in the pipeline using the Task tool, so you only need to invoke the Writer to start the full workflow.

## Quick Start (Automated Pipeline)

Just invoke the Writer agent—it will automatically chain through all stages:

```bash
claude "Read agents/writer.md and create a post about [TOPIC]"
```

The pipeline will:
1. **Writer** creates draft → launches Editor
2. **Editor** refines draft → launches SEO
3. **SEO** optimizes → launches Publisher
4. **Publisher** publishes to `content/posts/`

## Manual Workflow

If you prefer to run each stage manually (for review between steps):

```bash
# Stage 1: Write
claude "Read agents/writer.md and create a post about Python packaging best practices"

# Stage 2: Edit (review draft first, then continue)
claude "Read agents/editor.md and edit agents/handoffs/draft-python-packaging-best-practices.md"

# Stage 3: SEO (review edits first, then continue)
claude "Read agents/seo.md and optimize agents/handoffs/edited-python-packaging-best-practices.md"

# Stage 4: Publish (review final draft, then continue)
claude "Read agents/publisher.md and publish agents/handoffs/final-python-packaging-best-practices.md"
```

## Agent Details

### 1. Writer Agent (`writer.md`)
- **Input**: Topic idea or outline
- **Output**: `agents/handoffs/draft-{slug}.md`
- **Next**: Launches Editor agent

### 2. Editor Agent (`editor.md`)
- **Input**: Draft from Writer
- **Output**: `agents/handoffs/edited-{slug}.md`
- **Next**: Launches SEO agent

### 3. SEO Agent (`seo.md`)
- **Input**: Edited draft
- **Output**: `agents/handoffs/final-{slug}.md`
- **Next**: Launches Publisher agent

### 4. Publisher Agent (`publisher.md`)
- **Input**: Final optimized draft
- **Output**: `content/posts/{date}-{slug}.md`
- **Final**: Reports publication status

## File Naming Convention

```
agents/handoffs/draft-{slug}.md    # After Writer
agents/handoffs/edited-{slug}.md   # After Editor
agents/handoffs/final-{slug}.md    # After SEO
content/posts/{date}-{slug}.md     # After Publisher
```

## Handoffs Directory

The `handoffs/` subdirectory is the working area where drafts move between agents. Files here are intermediate and are cleaned up after successful publication.

## How Agents Chain Together

Each agent uses the Task tool to launch the next:

```
Writer completes → Task(subagent_type="general-purpose",
                        prompt="Read agents/editor.md and edit agents/handoffs/draft-{slug}.md")

Editor completes → Task(subagent_type="general-purpose",
                        prompt="Read agents/seo.md and optimize agents/handoffs/edited-{slug}.md")

SEO completes → Task(subagent_type="general-purpose",
                     prompt="Read agents/publisher.md and publish agents/handoffs/final-{slug}.md")
```

This enables a fully automated content pipeline from topic to published post.
