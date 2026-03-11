#!/bin/bash
# AutoWiki Deploy Script
# Deploys docs/index.html to GitHub Pages

set -e

TOPIC="${1:-DevOps Wiki}"
REPO_NAME="${2:-autowiki-$(echo "$TOPIC" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')}"

echo "🚀 AutoWiki Deployment"
echo "======================"
echo "Topic: $TOPIC"
echo "Repo:  $REPO_NAME"
echo ""

# Ensure docs directory exists
if [ ! -f "docs/index.html" ]; then
    echo "❌ docs/index.html not found. Generate the page first."
    exit 1
fi

# Initialize git if needed
if [ ! -d ".git" ]; then
    echo "📦 Initializing git repository..."
    git init
    git branch -M main
fi

# Check for remote
if ! git remote get-url origin &> /dev/null; then
    echo "🌐 Creating GitHub repository: $REPO_NAME"
    gh repo create "$REPO_NAME" --public --source=. --push --description "AutoWiki: $TOPIC Documentation"
else
    REMOTE_URL=$(git remote get-url origin)
    echo "📡 Remote already exists: $REMOTE_URL"
fi

# Commit and push
echo "📝 Committing changes..."
git add docs/
git commit -m "AutoWiki: Add $TOPIC documentation page" --allow-empty 2>/dev/null || echo "No new changes to commit"

echo "⬆️  Pushing to GitHub..."
git push -u origin main 2>/dev/null || git push origin main

# Get repo info
REPO_FULL=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null)
OWNER=$(echo "$REPO_FULL" | cut -d'/' -f1)
REPO=$(echo "$REPO_FULL" | cut -d'/' -f2)

# Enable GitHub Pages
echo "🌍 Enabling GitHub Pages..."
# Try to create pages (will fail if already exists)
gh api "repos/$REPO_FULL/pages" \
    -X POST \
    -f "source[branch]=main" \
    -f "source[path]=/docs" \
    2>/dev/null || \
gh api "repos/$REPO_FULL/pages" \
    -X PUT \
    -f "source[branch]=main" \
    -f "source[path]=/docs" \
    2>/dev/null || \
echo "⚠️  GitHub Pages may already be configured"

# Build the URL
PAGES_URL="https://${OWNER}.github.io/${REPO}/"
REPO_URL="https://github.com/${REPO_FULL}"

echo ""
echo "============================================"
echo "✅ AutoWiki Deployment Complete!"
echo "============================================"
echo ""
echo "📄 Topic:      $TOPIC"
echo "🔗 Live URL:   $PAGES_URL"
echo "📦 Repository: $REPO_URL"
echo "📚 Study resources are included on the page"
echo ""
echo "⏳ Note: GitHub Pages may take 1-2 minutes to go live."
echo "============================================"
