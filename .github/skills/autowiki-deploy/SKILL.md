---
name: autowiki-deploy
description: "Deploy HTML wiki pages to GitHub Pages. Use when: deploying generated documentation, publishing wiki pages, setting up GitHub Pages, creating DevOps tool documentation sites."
argument-hint: "Topic name to generate and deploy"
---

# AutoWiki Deploy Skill

## When to Use
- Generate and deploy DevOps tool wiki pages to GitHub Pages
- Create professional HTML documentation for any DevOps technology
- Publish single-page documentation sites

## Procedure

### 1. Generate HTML

Create `docs/index.html` using the [HTML template](./assets/template.html) as a reference. Customize it with the requested topic's content.

### 2. Pre-flight Checks

Run the [pre-flight script](./scripts/preflight.sh) to verify:
- `git` is installed
- `gh` CLI is installed and authenticated
- The workspace is a valid git repository

### 3. Deploy

Run the [deploy script](./scripts/deploy.sh) to:
- Initialize git if needed
- Create GitHub repo if needed
- Commit and push the docs
- Enable GitHub Pages
- Return the live URL

## HTML Template Structure

The generated HTML must follow this structure:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- Meta, title, inline CSS -->
</head>
<body>
  <nav class="sidebar">
    <!-- Navigation links -->
  </nav>
  <main class="content">
    <header> <!-- Hero section --> </header>
    <section id="overview"> <!-- What & Why --> </section>
    <section id="features"> <!-- Feature table with icons --> </section>
    <section id="architecture"> <!-- How it works --> </section>
    <section id="getting-started"> <!-- Quick start --> </section>
    <section id="ecosystem"> <!-- Related tools table --> </section>
    <section id="resources"> <!-- Study links --> </section>
    <footer> <!-- Credits --> </footer>
  </main>
</body>
</html>
```

## Study Resources Categories

Always include these resource categories:
1. **Official Documentation** — Primary docs link
2. **Getting Started Guides** — Quickstart tutorials
3. **Video Tutorials** — YouTube/course links
4. **Community** — Forums, Discord, Reddit
5. **Certifications** — Official cert programs (if available)
6. **Books & Blogs** — Recommended reading
