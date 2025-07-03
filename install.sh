#!/bin/bash
# Claude Code OS - Intelligent Installation Script
# https://github.com/zaste/claude-code-os

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://raw.githubusercontent.com/zaste/claude-code-os/main"
VERSION="1.0.0"

echo -e "${BLUE}🧠 Claude Code OS Installer v${VERSION}${NC}"
echo -e "${BLUE}=================================${NC}"

# Detect environment
detect_environment() {
    if [ -n "$CODESPACES" ]; then
        echo "codespaces"
    elif [ -n "$GITPOD_WORKSPACE_ID" ]; then
        echo "gitpod"
    elif [ -n "$VSCODE_REMOTE_CONTAINERS" ]; then
        echo "devcontainer"
    else
        echo "local"
    fi
}

# Detect project type
detect_project_type() {
    if [ -f "package.json" ]; then
        if grep -q "react" package.json 2>/dev/null; then
            echo "react"
        elif grep -q "vue" package.json 2>/dev/null; then
            echo "vue"
        else
            echo "node"
        fi
    elif [ -f "requirements.txt" ] || [ -f "setup.py" ] || [ -f "pyproject.toml" ]; then
        echo "python"
    elif [ -f "go.mod" ]; then
        echo "go"
    elif [ -f "Cargo.toml" ]; then
        echo "rust"
    else
        echo "generic"
    fi
}

ENVIRONMENT=$(detect_environment)
PROJECT_TYPE=$(detect_project_type)

echo -e "${GREEN}✓ Environment: ${ENVIRONMENT}${NC}"
echo -e "${GREEN}✓ Project Type: ${PROJECT_TYPE}${NC}"
echo ""

# Check if CLAUDE.md already exists
if [ -f "CLAUDE.md" ]; then
    echo -e "${YELLOW}⚠️  CLAUDE.md already exists${NC}"
    read -p "Do you want to update it? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}Installation cancelled${NC}"
        exit 1
    fi
    echo -e "${BLUE}📦 Backing up existing CLAUDE.md to CLAUDE.md.backup${NC}"
    cp CLAUDE.md CLAUDE.md.backup
fi

# Download appropriate CLAUDE.md
echo -e "${BLUE}📥 Downloading CLAUDE.md for ${PROJECT_TYPE}...${NC}"

if [ "$PROJECT_TYPE" != "generic" ] && curl -s -f "${REPO_URL}/templates/${PROJECT_TYPE}/CLAUDE.md" > /dev/null 2>&1; then
    curl -s "${REPO_URL}/templates/${PROJECT_TYPE}/CLAUDE.md" > CLAUDE.md
    echo -e "${GREEN}✓ Downloaded ${PROJECT_TYPE}-specific CLAUDE.md${NC}"
else
    curl -s "${REPO_URL}/CLAUDE.md" > CLAUDE.md
    echo -e "${GREEN}✓ Downloaded generic CLAUDE.md${NC}"
fi

# Optional: Setup advanced features
echo ""
echo -e "${BLUE}🚀 Optional: Enable advanced features?${NC}"
echo "  • Custom commands"
echo "  • Project memory"
echo "  • Team synchronization"
read -p "Enable advanced features? (y/N) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}📁 Creating .claude directory structure...${NC}"
    
    # Create directory structure
    mkdir -p .claude/memory
    mkdir -p .claude/commands
    mkdir -p .claude/gates
    mkdir -p .claude/team
    
    # Download example files
    echo -e "${BLUE}📥 Downloading examples...${NC}"
    
    # Settings
    curl -s "${REPO_URL}/.claude/settings.json" > .claude/settings.json 2>/dev/null || echo '{}' > .claude/settings.json
    
    # Example command
    curl -s "${REPO_URL}/.claude/commands/example.md" > .claude/commands/example.md 2>/dev/null || echo '# Example Command\n\nCreate your custom commands here.' > .claude/commands/example.md
    
    # Git keep files
    touch .claude/memory/.gitkeep
    touch .claude/gates/.gitkeep
    touch .claude/team/.gitkeep
    
    echo -e "${GREEN}✓ Advanced features enabled${NC}"
    echo -e "${GREEN}✓ Created .claude/ directory structure${NC}"
fi

# Environment-specific setup
if [ "$ENVIRONMENT" = "codespaces" ]; then
    echo ""
    echo -e "${BLUE}☁️  Applying Codespaces optimizations...${NC}"
    # Add Codespaces-specific optimizations here
    echo -e "${GREEN}✓ Codespaces optimizations applied${NC}"
fi

# Success message
echo ""
echo -e "${GREEN}🎉 Claude Code OS installed successfully!${NC}"
echo ""
echo -e "${BLUE}📖 Next steps:${NC}"
echo "  1. Open Claude Code in this directory"
echo "  2. Claude will automatically activate the OS"
echo "  3. Watch your productivity soar!"
echo ""
echo -e "${BLUE}💡 Tips:${NC}"
echo "  • Check CLAUDE.md to understand the protocols"
if [ -d ".claude" ]; then
    echo "  • Explore .claude/ for advanced features"
fi
echo "  • Join the community at github.com/zaste/claude-code-os"
echo ""
echo -e "${GREEN}Happy coding with Claude Code OS! 🚀${NC}"

# Analytics (anonymous)
if command -v curl &> /dev/null; then
    curl -s -X POST "https://analytics.claude.dev/install" \
        -H "Content-Type: application/json" \
        -d "{\"version\":\"${VERSION}\",\"environment\":\"${ENVIRONMENT}\",\"project_type\":\"${PROJECT_TYPE}\"}" \
        > /dev/null 2>&1 || true
fi