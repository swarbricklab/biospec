#!/bin/bash
# BioSpec - Create Instance
# Creates a new intent, dataset, or analysis instance from templates
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

usage() {
    echo "Usage: $0 <type> [number]"
    echo ""
    echo "Types:"
    echo "  intent    - Create a new research intent"
    echo "  dataset   - Create a new dataset specification"
    echo "  analysis  - Create a new analysis objective"
    echo ""
    echo "Options:"
    echo "  number    - Instance number (auto-detected if not specified)"
    echo ""
    echo "Examples:"
    echo "  $0 intent        # Creates intent-1.md (or next available)"
    echo "  $0 dataset 3     # Creates dataset-3.md"
    echo "  $0 analysis      # Creates analysis-1.md (or next available)"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

TYPE="$1"
NUMBER="$2"

# Validate type
case "$TYPE" in
    intent|dataset|analysis)
        ;;
    *)
        echo -e "${RED}Error: Invalid type '$TYPE'${NC}"
        usage
        ;;
esac

# Set paths based on type
TEMPLATE="$PROJECT_ROOT/.biospec/subtemplates/${TYPE}.md"
TARGET_DIR="$PROJECT_ROOT/project/${TYPE}s"

# Check template exists
if [ ! -f "$TEMPLATE" ]; then
    echo -e "${RED}Error: Template not found: $TEMPLATE${NC}"
    exit 1
fi

# Ensure target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
    echo -e "${GREEN}Created directory: $TARGET_DIR${NC}"
fi

# Auto-detect next number if not specified
if [ -z "$NUMBER" ]; then
    NUMBER=1
    while [ -f "$TARGET_DIR/${TYPE}-${NUMBER}.md" ]; do
        ((NUMBER++))
    done
fi

TARGET_FILE="$TARGET_DIR/${TYPE}-${NUMBER}.md"

# Check if file already exists
if [ -f "$TARGET_FILE" ]; then
    echo -e "${RED}Error: File already exists: $TARGET_FILE${NC}"
    echo "Specify a different number or remove the existing file"
    exit 1
fi

# Copy template and replace placeholders
cp "$TEMPLATE" "$TARGET_FILE"

# Replace {n} with the instance number
sed -i "s/{n}/${NUMBER}/g" "$TARGET_FILE"

# Update last_updated date
TODAY=$(date +%Y-%m-%d)
sed -i "s/YYYY-MM-DD/${TODAY}/g" "$TARGET_FILE"

echo -e "${GREEN}Created: $TARGET_FILE${NC}"
echo ""
echo "Next steps:"
echo "  1. Open $TARGET_FILE in your editor"
echo "  2. Fill in the template fields"
echo "  3. Update the ${TYPE}_overview.md to include this instance"
echo ""
