#!/bin/bash
# BioSpec - Setup Project Structure
# Creates the project directory structure with template copies
# Portions of this file are adapted from GitHub's spec-kit tool.
# Copyright (c) GitHub, Inc.
# Licensed under the MIT License - see THIRD_PARTY_LICENSES.md.

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo -e "${CYAN}BioSpec - Project Setup${NC}"
echo "========================="
echo ""

# Check if .biospec directory exists
if [ ! -d "$PROJECT_ROOT/.biospec" ]; then
    echo -e "${RED}Error: .biospec directory not found${NC}"
    echo "Please ensure you're running this from a BioSpec project root"
    exit 1
fi

# Create project directory if it doesn't exist
PROJECT_DIR="$PROJECT_ROOT/project"
if [ ! -d "$PROJECT_DIR" ]; then
    mkdir -p "$PROJECT_DIR"
    echo -e "${GREEN}Created project directory${NC}"
fi

# Create subdirectories
mkdir -p "$PROJECT_DIR/intents"
mkdir -p "$PROJECT_DIR/datasets"
mkdir -p "$PROJECT_DIR/analyses"
echo -e "${GREEN}Created subdirectories: intents, datasets, analyses${NC}"

# Copy overview templates if they don't exist
TEMPLATES=(
    "project_overview.md"
    "intent_overview.md"
    "dataset_overview.md"
    "analysis_overview.md"
    "project_resources.md"
    "status.md"
)

for template in "${TEMPLATES[@]}"; do
    if [ ! -f "$PROJECT_DIR/$template" ]; then
        if [ -f "$PROJECT_ROOT/.biospec/$template" ]; then
            cp "$PROJECT_ROOT/.biospec/$template" "$PROJECT_DIR/$template"
            echo -e "${GREEN}Copied $template${NC}"
        else
            echo -e "${RED}Warning: Template not found: $template${NC}"
        fi
    else
        echo -e "${CYAN}Skipped $template (already exists)${NC}"
    fi
done

echo ""
echo -e "${GREEN}Project structure setup complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Edit project/project_overview.md with your project details"
echo "  2. Use 'create-instance.sh intent' to create research intents"
echo "  3. Use 'create-instance.sh dataset' to add datasets"
echo "  4. Use 'create-instance.sh analysis' to define analyses"
echo ""
