# BioSpec

**Research project specifications to organise your analyses and guide agent-assisted computational biology**

## Overview

BioSpec provides schemas and commands for specifying biomedical project context as a stable anchor for coding agents and humans during development. It formalizes the components of a biomedical research project—description, scientific intent, datasets, and resource constraints—as human- and agent-readable templates.

## Quickstart

1. Clone the repository to obtain templates and prompts
2. Review template structure in `.biospec/`
3. Use prompts in `.github/prompts/` to populate project specifications

## Directory Structure

### Template Organization

BioSpec uses a **granular template structure** that separates reusable master templates from project-specific instances:

```
.biospec/                          # Master templates (do not modify)
├── subtemplates/                  # Master subtemplates for repeating components
│   ├── intent.md                 # Single research question/aim/goal + hypothesis
│   ├── dataset.md                # Single dataset specification
│   └── analysis.md               # Single analysis objective
├── intent_overview.md            # Orchestrator/index for all intents
├── dataset_overview.md           # Orchestrator/index for all datasets
├── project_overview.md           # Project-level metadata
├── project_resources.md          # Computing resources and environment
└── relationships.md              # Cross-component relationships

project/                           # Your project instance (created via prompts)
├── intents/                      # Individual intent instances
│   ├── intent-1.md              # Research question/aim + hypothesis
│   ├── intent-2.md
│   └── ...
├── datasets/                     # Individual dataset instances
│   ├── dataset-1.md             # Single dataset specification
│   ├── dataset-2.md
│   └── ...
├── analyses/                     # Individual analysis instances
│   ├── analysis-1.md            # Single analysis objective
│   └── ...
├── intent_overview.md           # Index linking to all intents
├── dataset_overview.md          # Index linking to all datasets
├── project_overview.md
├── project_resources.md
└── relationships.md
```

### Key Concepts

#### Subtemplates vs. Overview Files

- **Subtemplates** (`.biospec/subtemplates/*.md`): Master templates that get instantiated for each component
  - One `intent.md` template → many `intent-1.md`, `intent-2.md` instances
  - One `dataset.md` template → many `dataset-1.md`, `dataset-2.md` instances
  - One `analysis.md` template → many `analysis-1.md`, `analysis-2.md` instances

- **Overview files** (`*_overview.md`): Orchestrators that aggregate and link to granular components
  - `intent_overview.md`: Lists all intents with summary table and project-level milestones
  - `dataset_overview.md`: Lists all datasets with summary table and integration strategy

#### Terminology

- **Intent**: A research question, aim, or goal, optionally with an associated hypothesis
  - Each intent is a separate file for independent versioning and review
  
- **Dataset**: A single dataset or cohort specification
  - Each dataset is a separate file with its own metadata

- **Analysis**: A single analysis objective or computational task
  - Each analysis is a separate file with priority, dependencies, and methods

## File Pathing

To work correctly, prompt files must be stored in your project/workspace root under `.github/prompts` (e.g., `.github/prompts/biospec.create_project.prompt.md`). 

Templates are expected to be stored in your project/workspace root under `.biospec/`. 

Note: These folders can appear as hidden on some systems. VS Code should display them in its explorer.

## Naming Conventions

- **Subtemplate files**: Singular names (`intent.md`, `dataset.md`, `analysis.md`)
- **Overview files**: Plural with `_overview` suffix (`intent_overview.md`, `dataset_overview.md`)
- **Instance files**: Type + number (`intent-1.md`, `dataset-1.md`, `analysis-1.md`)
- **Cross-references**: Relative paths (`intents/intent-1.md`, `datasets/dataset-1.md`)

## Working with Granular Templates

### Creating a New Project

When you run `/biospec.create_project`:
1. Master templates are copied to `project/`
2. Subtemplates are instantiated based on your project description:
   - Each research question/aim → `project/intents/intent-{n}.md`
   - Each dataset → `project/datasets/dataset-{n}.md`
   - Each analysis objective → `project/analyses/analysis-{n}.md`
3. Overview files are populated with links to all instances
4. Relationships are mapped between components

## Manual Editing

Manual editing of templates in the `project` directory is supported and encouraged!

## Background

From ABACBS Abstract:

**BioSpec: Research project specifications to guide agent-assisted computational biology**

Large language model (LLM) coding agents can rapidly draft scripts for computational analyses. However, insufficient guidance, guardrails, or clarity in a user's request can lead to over-engineered outputs, analytical drift, and incompatible code. Moreover, their lack of contextual memory poses limitations for multi-task research workflows. While agents can be prompted to create ad-hoc "project context" documents based on existing artefacts, these rarely provide a consistent, complete schema that captures a project's description, intent, and constraints. Paradoxically, the very documentation needed to establish this context is often produced last, after code is written. 

To address this, we introduce BioSpec, a set of schemas and commands for iteratively specifying biomedical project context as a stable anchor for coding agents and humans during development. BioSpec formalises the components of a biomedical research project—its description, scientific intent, datasets, and resource constraints—as human- and agent-readable templates. It provides agent-agnostic commands to populate fields using user input, project notes, or pre-existing code. Additional commands are provided to validate completeness, flag ambiguities, and pose constructive questions that challenge design assumptions. The resulting context can be manually edited, version-controlled, and shared with other stakeholders, such as principal investigators and collaborators. 

We demonstrate an end-to-end use of BioSpec across a typical computational biology workflow and show how its outputs complement existing context management tools. By making project context explicit before code generation, BioSpec supports reproducible, project-grounded implementations. The toolkit will be released under an open-source licence.

