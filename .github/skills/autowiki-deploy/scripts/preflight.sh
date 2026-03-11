#!/bin/bash
# AutoWiki Pre-flight Checks
# Verifies all prerequisites before deployment

set -e

echo "🔍 AutoWiki Pre-flight Checks"
echo "=============================="

# Check git
if command -v git &> /dev/null; then
    echo "✅ git is installed ($(git --version))"
else
    echo "❌ git is not installed. Please install git first."
    exit 1
fi

# Check gh CLI
if command -v gh &> /dev/null; then
    echo "✅ gh CLI is installed ($(gh --version | head -1))"
else
    echo "❌ GitHub CLI (gh) is not installed."
    echo "   Install it: brew install gh"
    exit 1
fi

# Check gh auth
if gh auth status &> /dev/null; then
    echo "✅ gh CLI is authenticated"
    GITHUB_USER=$(gh api user -q .login 2>/dev/null || echo "unknown")
    echo "   Logged in as: $GITHUB_USER"
else
    echo "❌ gh CLI is not authenticated."
    echo "   Run: gh auth login"
    exit 1
fi

# Check if docs/index.html exists
if [ -f "docs/index.html" ]; then
    echo "✅ docs/index.html exists"
else
    echo "⚠️  docs/index.html not found (will be generated)"
fi

echo ""
echo "All pre-flight checks passed! Ready to deploy."
