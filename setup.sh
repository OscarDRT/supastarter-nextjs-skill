#!/bin/bash
# Quick setup script for supastarter-nextjs-skill repository

set -e

echo "🚀 Setting up supastarter-nextjs-skill repository..."
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Error: git is not installed"
    exit 1
fi

# Get user info
read -p "Enter your GitHub username: " GITHUB_USER
read -p "Enter your name for LICENSE: " AUTHOR_NAME
read -p "Enter repository name (default: supastarter-nextjs-skill): " REPO_NAME
REPO_NAME=${REPO_NAME:-supastarter-nextjs-skill}

echo ""
echo "📝 Configuration:"
echo "   GitHub User: $GITHUB_USER"
echo "   Author Name: $AUTHOR_NAME"
echo "   Repo Name: $REPO_NAME"
echo ""

read -p "Is this correct? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

# Update LICENSE with author name
echo "📄 Updating LICENSE..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s/\[Your Name\]/$AUTHOR_NAME/g" LICENSE
else
    # Linux
    sed -i "s/\[Your Name\]/$AUTHOR_NAME/g" LICENSE
fi

# Update README.md with GitHub username
echo "📄 Updating README.md..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/YOUR-USERNAME/$GITHUB_USER/g" README.md
else
    sed -i "s/YOUR-USERNAME/$GITHUB_USER/g" README.md
fi

# Update marketplace.json
echo "📄 Updating marketplace.json..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/Your Name/$AUTHOR_NAME/g" marketplace.json
    sed -i '' "s/YOUR-USERNAME/$GITHUB_USER/g" marketplace.json
else
    sed -i "s/Your Name/$AUTHOR_NAME/g" marketplace.json
    sed -i "s/YOUR-USERNAME/$GITHUB_USER/g" marketplace.json
fi

# Initialize git if not already
if [ ! -d .git ]; then
    echo "🔧 Initializing git repository..."
    git init
    git branch -M main
fi

# Create initial commit
echo "📦 Creating initial commit..."
git add .
git commit -m "feat: initial release of supastarter-nextjs skill v1.0.0

- Complete supastarter architecture documentation
- Coding conventions from official guide
- Code patterns for common tasks
- Quick reference and troubleshooting
- Progressive disclosure support"

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo ""
echo "1. Create a new repository on GitHub:"
echo "   https://github.com/new"
echo "   Name: $REPO_NAME"
echo "   Description: Agent Skill for supastarter Next.js development"
echo "   Public repository"
echo ""
echo "2. Add the remote and push:"
echo "   git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git"
echo "   git push -u origin main"
echo ""
echo "3. Create a release on GitHub:"
echo "   - Go to Releases > Create new release"
echo "   - Tag: v1.0.0"
echo "   - Title: supastarter Next.js Skill v1.0.0"
echo "   - Description: Initial release"
echo ""
echo "4. Your skill will be available at:"
echo "   npx skills add $GITHUB_USER/$REPO_NAME"
echo ""
echo "5. (Optional) Add topics to your repo:"
echo "   agent-skills, claude-code, supastarter, nextjs, saas-boilerplate"
echo ""
echo "🎉 Happy sharing!"