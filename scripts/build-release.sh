#!/bin/bash
# BioSpec - Build Release Assets
# Packages template files into ZIP assets for GitHub releases
# Portions of this file are adapted from GitHub's spec-kit tool.
# Copyright (c) GitHub, Inc.
# Licensed under the MIT License - see THIRD_PARTY_LICENSES.md.

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo -e "${CYAN}BioSpec - Build Release Assets${NC}"
echo "================================"
echo ""

# Extract version from pyproject.toml
VERSION=$(grep -E '^version = ' "$PROJECT_ROOT/pyproject.toml" | sed 's/version = "\(.*\)"/\1/')
if [ -z "$VERSION" ]; then
    echo -e "${RED}Error: Could not extract version from pyproject.toml${NC}"
    exit 1
fi

echo -e "Version: ${GREEN}$VERSION${NC}"
echo ""

# Create dist directory
DIST_DIR="$PROJECT_ROOT/dist"
mkdir -p "$DIST_DIR"

# Create temporary build directory
BUILD_DIR=$(mktemp -d)
trap "rm -rf $BUILD_DIR" EXIT

# Function to build a release asset
build_asset() {
    local SCRIPT_TYPE="$1"
    local ASSET_NAME="biospec-template-${SCRIPT_TYPE}-v${VERSION}"
    local ASSET_DIR="$BUILD_DIR/$ASSET_NAME"

    echo -e "${CYAN}Building $ASSET_NAME...${NC}"

    # Create asset directory
    mkdir -p "$ASSET_DIR"

    # Copy .biospec templates
    if [ -d "$PROJECT_ROOT/.biospec" ]; then
        cp -r "$PROJECT_ROOT/.biospec" "$ASSET_DIR/.biospec"
        echo -e "  ${GREEN}+${NC} .biospec/"
    else
        echo -e "  ${RED}Error: .biospec directory not found${NC}"
        exit 1
    fi

    # Copy .github files (Copilot instructions, agents, prompts)
    if [ -d "$PROJECT_ROOT/.github" ]; then
        cp -r "$PROJECT_ROOT/.github" "$ASSET_DIR/.github"
        echo -e "  ${GREEN}+${NC} .github/"
    else
        echo -e "  ${RED}Error: .github directory not found${NC}"
        exit 1
    fi

    # Create project directory structure
    mkdir -p "$ASSET_DIR/project/intents"
    mkdir -p "$ASSET_DIR/project/datasets"
    mkdir -p "$ASSET_DIR/project/analyses"
    echo -e "  ${GREEN}+${NC} project/ (empty structure)"

    # Copy scripts based on script type
    mkdir -p "$ASSET_DIR/.biospec-scripts"
    if [ "$SCRIPT_TYPE" = "sh" ]; then
        if [ -d "$PROJECT_ROOT/scripts/bash" ]; then
            cp -r "$PROJECT_ROOT/scripts/bash" "$ASSET_DIR/.biospec-scripts/bash"
            echo -e "  ${GREEN}+${NC} .biospec-scripts/bash/"
        fi
    elif [ "$SCRIPT_TYPE" = "ps" ]; then
        if [ -d "$PROJECT_ROOT/scripts/powershell" ]; then
            cp -r "$PROJECT_ROOT/scripts/powershell" "$ASSET_DIR/.biospec-scripts/powershell"
            echo -e "  ${GREEN}+${NC} .biospec-scripts/powershell/"
        fi
    fi

    # Create .vscode/settings.json for recommended extensions
    mkdir -p "$ASSET_DIR/.vscode"
    cat > "$ASSET_DIR/.vscode/settings.json" << 'EOF'
{
    "markdown.validate.enabled": true,
    "files.associations": {
        "*.md": "markdown"
    },
    "editor.wordWrap": "on",
    "[markdown]": {
        "editor.defaultFormatter": null,
        "editor.wordWrap": "on"
    }
}
EOF
    echo -e "  ${GREEN}+${NC} .vscode/settings.json"

    # Create .gitignore
    cat > "$ASSET_DIR/.gitignore" << 'EOF'
# BioSpec gitignore

# OS files
.DS_Store
Thumbs.db

# Editor files
*.swp
*.swo
*~

# Temporary files
*.tmp
*.temp

# Data files (uncomment if needed)
# *.csv
# *.tsv
# *.xlsx

# Large data files (uncomment if needed)
# *.h5
# *.hdf5
# *.rds
# *.RData
EOF
    echo -e "  ${GREEN}+${NC} .gitignore"

    # Create README.md
    cat > "$ASSET_DIR/README.md" << EOF
# BioSpec Project

This project uses BioSpec - a structured specifications framework for computational biology research.

## Project Structure

- \`.biospec/\` - Master templates (do not modify)
- \`project/\` - Your project specifications
- \`.github/\` - GitHub Copilot prompts and agent configuration
- \`.biospec-scripts/\` - Helper scripts

## Getting Started

1. Open this project in VS Code with GitHub Copilot
2. Use \`@BioSpec /biospec.setup\` to initialize the project structure
3. Use \`@BioSpec /biospec.create_project\` to create your project from a description

## Available Prompts

- \`/biospec.setup\` - Initialize template structure
- \`/biospec.create_project\` - Create project from description
- \`/biospec.start_project\` - Interactive project kickoff
- \`/biospec.edit\` - Fine-grained template edits
- \`/biospec.status\` - Track completion status
- \`/biospec.validate_fields\` - Field validation
- \`/biospec.review\` - Overall review
- \`/biospec.gaps\` - Identify missing information

## Documentation

For more information, visit: https://github.com/swarbricklab/BioSpec
EOF
    echo -e "  ${GREEN}+${NC} README.md"

    # Create ZIP archive
    cd "$BUILD_DIR"
    zip -r "$DIST_DIR/$ASSET_NAME.zip" "$ASSET_NAME" -x "*.DS_Store" -x "*__pycache__*"
    cd "$PROJECT_ROOT"

    # Get file size
    local SIZE=$(ls -lh "$DIST_DIR/$ASSET_NAME.zip" | awk '{print $5}')
    echo -e "  ${GREEN}Created:${NC} $ASSET_NAME.zip ($SIZE)"
    echo ""
}

# Build both asset types
build_asset "sh"
build_asset "ps"

echo -e "${GREEN}Build complete!${NC}"
echo ""
echo "Release assets in $DIST_DIR:"
ls -lh "$DIST_DIR"/biospec-template-*.zip
echo ""
echo "Next steps:"
echo "  1. Create a new GitHub release with tag v$VERSION"
echo "  2. Upload the ZIP files as release assets"
echo "  3. Users can then run: biospec init my-project"
echo ""
