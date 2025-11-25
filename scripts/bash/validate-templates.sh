#!/bin/bash
# BioSpec - Validate Templates
# Checks template integrity and reports missing or incomplete files
# Portions of this file are adapted from GitHub's spec-kit tool.
# Copyright (c) GitHub, Inc.
# Licensed under the MIT License - see THIRD_PARTY_LICENSES.md.

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo -e "${CYAN}BioSpec - Template Validation${NC}"
echo "=============================="
echo ""

errors=0
warnings=0

# Check master templates
echo -e "${CYAN}Checking master templates (.biospec/)...${NC}"
MASTER_TEMPLATES=(
    ".biospec/project_overview.md"
    ".biospec/intent_overview.md"
    ".biospec/dataset_overview.md"
    ".biospec/analysis_overview.md"
    ".biospec/project_resources.md"
    ".biospec/status.md"
    ".biospec/subtemplates/intent.md"
    ".biospec/subtemplates/dataset.md"
    ".biospec/subtemplates/analysis.md"
)

for template in "${MASTER_TEMPLATES[@]}"; do
    if [ -f "$PROJECT_ROOT/$template" ]; then
        echo -e "  ${GREEN}OK${NC} $template"
    else
        echo -e "  ${RED}MISSING${NC} $template"
        ((errors++))
    fi
done

echo ""

# Check GitHub Copilot files
echo -e "${CYAN}Checking GitHub Copilot configuration...${NC}"
COPILOT_FILES=(
    ".github/copilot-instructions.md"
    ".github/agents/BioSpec.agent.md"
)

for file in "${COPILOT_FILES[@]}"; do
    if [ -f "$PROJECT_ROOT/$file" ]; then
        echo -e "  ${GREEN}OK${NC} $file"
    else
        echo -e "  ${RED}MISSING${NC} $file"
        ((errors++))
    fi
done

echo ""

# Check prompts directory
echo -e "${CYAN}Checking prompt files...${NC}"
PROMPTS_DIR="$PROJECT_ROOT/.github/prompts"
if [ -d "$PROMPTS_DIR" ]; then
    prompt_count=$(find "$PROMPTS_DIR" -name "*.prompt.md" -type f | wc -l)
    if [ "$prompt_count" -gt 0 ]; then
        echo -e "  ${GREEN}OK${NC} Found $prompt_count prompt files"
    else
        echo -e "  ${YELLOW}WARNING${NC} No prompt files found"
        ((warnings++))
    fi
else
    echo -e "  ${RED}MISSING${NC} .github/prompts directory"
    ((errors++))
fi

echo ""

# Check project directory if it exists
PROJECT_DIR="$PROJECT_ROOT/project"
if [ -d "$PROJECT_DIR" ]; then
    echo -e "${CYAN}Checking project instances...${NC}"

    # Count instances
    intent_count=$(find "$PROJECT_DIR/intents" -name "intent-*.md" -type f 2>/dev/null | wc -l)
    dataset_count=$(find "$PROJECT_DIR/datasets" -name "dataset-*.md" -type f 2>/dev/null | wc -l)
    analysis_count=$(find "$PROJECT_DIR/analyses" -name "analysis-*.md" -type f 2>/dev/null | wc -l)

    echo -e "  Intents: $intent_count"
    echo -e "  Datasets: $dataset_count"
    echo -e "  Analyses: $analysis_count"

    # Check for placeholder values in project files
    echo ""
    echo -e "${CYAN}Checking for unfilled placeholders...${NC}"
    placeholder_files=$(grep -l "YYYY-MM-DD\|{n}\|{Short\|{Name\|{Descriptor" "$PROJECT_DIR"/*.md 2>/dev/null || true)
    if [ -n "$placeholder_files" ]; then
        echo -e "  ${YELLOW}WARNING${NC} Files with placeholders:"
        echo "$placeholder_files" | while read -r file; do
            echo -e "    - $(basename "$file")"
        done
        ((warnings++))
    else
        echo -e "  ${GREEN}OK${NC} No obvious placeholders found"
    fi
else
    echo -e "${YELLOW}Note: project/ directory not yet created${NC}"
    echo "  Run setup-project.sh to create the project structure"
fi

echo ""
echo "=============================="
if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
    echo -e "${GREEN}Validation passed!${NC}"
elif [ $errors -eq 0 ]; then
    echo -e "${YELLOW}Validation passed with $warnings warning(s)${NC}"
else
    echo -e "${RED}Validation failed with $errors error(s) and $warnings warning(s)${NC}"
    exit 1
fi
