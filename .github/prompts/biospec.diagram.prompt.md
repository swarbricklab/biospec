---
description: Generate a Mermaid dependency diagram from project artifacts
name: biospec.diagram
agent: BioSpec
---

## User Input

```text
$ARGUMENTS
```

## Outline

Your task is to generate a Mermaid dependency diagram that visualizes the relationships between the project's Datasets, Analyses, and Intents. You will scan the project components, construct the graph, and update the `project/dependencies.md` file.

## Workflow Overview

**Use the `manage_todo_list` tool to create and track a checklist for this process.** This ensures systematic completion and visibility into progress. The checklist should include:

1. **Pre-flight checks** (validate setup)
2. **Discovery** (scan components and extract links)
3. **Construction** (generate Mermaid graph)
4. **Update** (write to dependencies file)
5. **Review** (validate output)

Mark each task as `in-progress` before starting work, and `completed` immediately upon finishing.

## Detailed Steps

**Create a todo list at the start of the process** to track these steps:

### ☑️ Checklist Item 1: Validate BioSpec Setup

Before proceeding, check that the `project/` directory and `project/dependencies.md` exist.
- If `project/dependencies.md` does not exist, stop and inform the user that they must run the setup command first (e.g. `/biospec.setup`).

### ☑️ Checklist Item 2: Discovery Phase

**Scan the project structure:**
- Read all files in `project/intents/`
- Read all files in `project/datasets/`
- Read all files in `project/analyses/`

**Extract Component Metadata:**
For each file, extract:
1.  **ID**: The file number (e.g., `1` from `dataset-1.md`).
2.  **Type**: Intent (I), Dataset (D), or Analysis (A).
3.  **Title**: The short descriptive name from the file header or title.
4.  **Links**: Look for the "Related Components" section or any markdown links to other component files (e.g., `../datasets/dataset-2.md`).

### ☑️ Checklist Item 3: Graph Construction

**Node Definition:**
- Create a node for every component found.
- Use the format: `PrefixID["Title with<br/>Line Break"]`
  - **Datasets**: `D{n}["Dataset {n}:<br/>{Short Title}"]`
  - **Analyses**: `A{n}["Analysis {n}:<br/>{Short Title}"]`
  - **Intents**: `I{n}["Intent {n}:<br/>{Short Title}"]`
- Keep titles concise. Insert `<br/>` to wrap long titles.

**Edge Definition:**
- Create directional arrows (`-->`) based on the links found in the files.
- **Directionality**:
  - Dataset → Analysis (`D{n} --> A{m}`)
  - Analysis → Intent (`A{n} --> I{m}`)
  - Analysis → Analysis (`A{n} --> A{m}`) (if one analysis depends on another)
  - Dataset → Intent (`D{n} --> I{m}`) (direct link, less common but possible)
- Ensure edges are unique (deduplicate).

**Layout:**
- Use `graph LR` (Left to Right) orientation.
- Group nodes by type using comments (e.g., `%% Nodes`, `%% Data to Analysis`).

### ☑️ Checklist Item 4: File Update

**Target File:** `project/dependencies.md`

**Action:**
1.  **Read** `project/dependencies.md`.
2.  **Replace** the existing Mermaid block with the newly generated one.
3.  **Update** the "Links to Individual Components" section below the graph.
    - List all Datasets, Intents, and Analyses with proper markdown links.
    - Format: `- [Dataset {n}: {Title}](datasets/dataset-{n}.md)`

### ☑️ Checklist Item 5: Final Review & Recommendation

**After updating the file:**
- Check if the graph looks disconnected (many isolated nodes).
- If so, append a message to your response:
  > "Some components appear disconnected. Run `/biospec.links` to scan for and validate missing relationships between your project elements."

## Checklist Summary Template

When starting the process, create a todo list with these items:

```
1. [not-started] Validate BioSpec setup exists
2. [not-started] Discovery: Scan components and extract links
3. [not-started] Construction: Generate Mermaid graph
4. [not-started] Update project/dependencies.md
5. [not-started] Final Review: Check connectivity
```