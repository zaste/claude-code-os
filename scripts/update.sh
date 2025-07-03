#!/bin/bash
# Claude Code OS Update Script
# Checks for updates and applies them if available

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Configuration
REPO_URL="https://api.github.com/repos/zaste/claude-code-os"
RAW_URL="https://raw.githubusercontent.com/zaste/claude-code-os/main"
CURRENT_VERSION=$(grep "Version:" CLAUDE.md 2>/dev/null | sed 's/.*Version: //' | awk '{print $1}' || echo "0.0.0")

echo -e "${BLUE}🔄 Claude Code OS Update Check${NC}"
echo -e "${BLUE}==============================${NC}"
echo -e "Current version: ${YELLOW}${CURRENT_VERSION}${NC}"

# Check for updates
echo -e "\n${BLUE}🔍 Checking for updates...${NC}"

# Get latest version from GitHub
LATEST_VERSION=$(curl -s "${REPO_URL}/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/' || echo "${CURRENT_VERSION}")

if [ "$LATEST_VERSION" = "$CURRENT_VERSION" ]; then
    echo -e "${GREEN}✓ You're running the latest version!${NC}"
    exit 0
fi

echo -e "${YELLOW}⚠️  New version available: ${LATEST_VERSION}${NC}"
echo ""
read -p "Do you want to update? (y/N) " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Update cancelled${NC}"
    exit 1
fi

# Backup current CLAUDE.md
echo -e "\n${BLUE}📦 Backing up current CLAUDE.md...${NC}"
cp CLAUDE.md "CLAUDE.md.backup.$(date +%Y%m%d-%H%M%S)"
echo -e "${GREEN}✓ Backup created${NC}"

# Download new version
echo -e "\n${BLUE}📥 Downloading new version...${NC}"

# Detect project type to get appropriate template
if [ -f "package.json" ]; then
    if grep -q "react" package.json 2>/dev/null; then
        PROJECT_TYPE="react"
    else
        PROJECT_TYPE="node"
    fi
elif [ -f "requirements.txt" ] || [ -f "setup.py" ]; then
    PROJECT_TYPE="python"
elif [ -f "go.mod" ]; then
    PROJECT_TYPE="go"
else
    PROJECT_TYPE="generic"
fi

# Try to download project-specific version first
if [ "$PROJECT_TYPE" != "generic" ]; then
    if curl -s -f "${RAW_URL}/templates/${PROJECT_TYPE}/CLAUDE.md" > CLAUDE.md.new 2>/dev/null; then
        echo -e "${GREEN}✓ Downloaded ${PROJECT_TYPE}-specific update${NC}"
    else
        curl -s "${RAW_URL}/CLAUDE.md" > CLAUDE.md.new
        echo -e "${GREEN}✓ Downloaded generic update${NC}"
    fi
else
    curl -s "${RAW_URL}/CLAUDE.md" > CLAUDE.md.new
    echo -e "${GREEN}✓ Downloaded update${NC}"
fi

# Apply update
mv CLAUDE.md.new CLAUDE.md

# Update other files if .claude directory exists
if [ -d ".claude" ]; then
    echo -e "\n${BLUE}🔄 Updating .claude configuration...${NC}"
    
    # Update settings.json if it exists
    if [ -f ".claude/settings.json" ]; then
        # Merge settings (in a real implementation, this would be smarter)
        curl -s "${RAW_URL}/.claude/settings.json" > .claude/settings.json.new
        # TODO: Implement proper JSON merging
        echo -e "${YELLOW}⚠️  Please review .claude/settings.json.new for new settings${NC}"
    fi
fi

echo -e "\n${GREEN}🎉 Update completed successfully!${NC}"
echo -e "${GREEN}Version ${CURRENT_VERSION} -> ${LATEST_VERSION}${NC}"
echo ""
echo -e "${BLUE}💡 What's new:${NC}"
echo "  Check the release notes at:"
echo "  https://github.com/zaste/claude-code-os/releases/tag/v${LATEST_VERSION}"
echo ""
echo -e "${GREEN}Happy coding with Claude Code OS! 🚀${NC}"