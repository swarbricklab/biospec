# BioSpec

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0) ![Python](https://img.shields.io/badge/python-3.10+-blue)

## Overview

BioSpec provides structured templates and VS Code chat commands to help you document your computational projects. The resulting specifications are intended to benefit both human researchers and AI coding/research agents.

## 📑 Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Workflow](#workflow)
- [Available Commands](#available-commands)
- [Agent & Models](#agent--models)
- [Templates & Directory Structure](#templates--directory-structure)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Features

- **Standardized Templates**: Use structured templates to document your project and organize your plans.
- **AI-Assisted Documentation**: Automatically populate project specifications from your existing notes, presentations and reports.
- **VS Code Integration**: Integrated into your development environment via Copilot Chat.
- **Iterative Refinement**: Tools for brainstorming, reviewing, and tracking the progress of your project specs.

## Installation

### Prerequisites

BioSpec requires the following:

- **[uv](https://docs.astral.sh/uv/)**: Python package manager. Used for installing the BioSpec Command Line Interface (CLI) tool.
- **[VS Code](https://code.visualstudio.com/)**: Required for the chat interface.
- **[GitHub Copilot Chat for VS Code](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat)**.
- **A GitHub Account**: Needed to access Copilot, but also recommended for version control.

These are also recommended, but not expected:
- **[markitdown](https://github.com/microsoft/markitdown)**: Free command-line tool for converting many formats (e.g., PDF, Powerpoint) to markdown. It also offers an MCP option.
- **A [Copilot Subscription](https://github.com/features/copilot)**: For improved model support and usage.
- **[GitHub MCP Server](https://github.com/github/github-mcp-server)**: Improves agent interactions with GitHub.

### Install BioSpec CLI

**Option 1: Persistent Installation (Easiest)**

Install globally using `uv`:

```bash
uv tool install biospec-cli --from git+https://github.com/swarbricklab/BioSpec.git
```

Then use the tool directly:

```bash
# Create a new project directory and add BioSpec templates/commands
biospec init {project-directory-name}

# Or, add BioSpec templates/commands to the current directory
biospec init --here
```

You'll be prompted to choose a script type to use (bash or PowerShell, depending on your operating system).

To upgrade to the latest version:

```bash
uv tool install biospec-cli --force --from git+https://github.com/swarbricklab/BioSpec.git
```

**Option 2: One-time Usage**

Run `biospec init` without installing the CLI:

```bash
uvx --from git+https://github.com/swarbricklab/BioSpec.git biospec init <project-directory-name>
```

Once set up in your project directory, you'll notice that a `github` and `biospec` folder have been added to your workspace. These contain command and agent files, and clean templates, respectively. Avoid editing these. The `/biospec.setup` command will set up templates for you.

## Using Copilot Chat in VS Code

See the [official documentation](https://code.visualstudio.com/docs/copilot/chat/copilot-chat) for full usage instructions. BioSpec relies on two key features:
1. **Custom agents**: Beyond the inbuilt `ask`, `plan`, `agent` modes, VS Code supports custom agent definitions. These are selected in the bottom left dropdown box of the chat window. The BioSpec agent uses a predefined toolset to improve transparency and context management. 
1. **Slash (`/`) commands**: Access chat commands by typing `/` in the chat window. These commands are effectively agent prompts, with the ability to specify the custom agent to use and tool restrictions.

### Recommended Models for Copilot

BioSpec has been tested on the base Copilot models, but yields the best results with:
- **Gemini 3 Pro**
- **Claude Sonnet 4.5**

We strongly recommend these for the `biospec.autofill` command, for better instruction following and interpretation of any provided project materials. 

## Workflow

BioSpec is designed for an iterative workflow. Start with a template skeleton, populate it with your materials, and refine it through discussion.

1.  **Initialize**: Run `biospec init` to initialize your project.
2.  **Setup**: Open the project in VS Code (`code .`) and type `/biospec.setup` in GitHub Copilot Chat. This command creates the `project/` directory and copies the master templates. The agent will prompt you to enable Git version control (recommended). 
3.  **Autofill**: Automatically populate templates using your existing project materials. Type `/biospec.autofill` and attach your materials by drag-and-drop or using `#`. 
- You can also direct the agent to focus on particular elements, or ignore certain details. 
- Text and markdown files are preferred for `autofill`. As mentioned above, we recommend `markitdown` for easily creating markdown files from your existing materials.
- The agent only edits fields when confident, though reliability depends on the model.
- This process may take a few minutes.

4.  **Refine**:

    Autofill provides a starting point. We recommend iterating on the outputs manually or using the commands below.

    *   **`/biospec.discuss`** — Brainstorm ideas or explore alternatives for specific components. Use this as a sounding board for open-ended discussion.
        - *Example*: "What alternative analyses could I run considering my available data?"
        - *Example*: "Help me think through possible confounders in my analysis plan"

    *   **`/biospec.review`** — Receive critical, structured peer review on specific aspects of your project.
        - *Example*: "Review the hypothesis and success criteria in intent-1. Are they specific enough?"

    *   **`/biospec.edit`** — Make targeted edits to specific fields. The agent proposes changes for your approval before applying them.
        - *Example*: "I've settled on my hypotheses for the ligand-receptor analysis, can you add these to intent-2?" (attach your notes or text)
        - *Example*: "I've been given GPU access and 500GB storage. Update my resources file and move deep learning approaches into scope in the project overview."
        - Unlike `autofill`, which is more hands-off, `edit` shows you proposed changes and lets you refine them before application.

5.  **Track & Organize**: 
    *   **`/biospec.status`** — Update `status.md` to track progress. Get completion percentages for each template and identify what still needs attention.

    *   **`/biospec.links`** — Validate cross-references and identify missing relationships between intents, datasets, and analyses. Keeps your specification internally consistent.

## Available Commands

BioSpec provides a suite of slash commands (prompts) to help you manage your project specification. These are available in GitHub Copilot Chat once the project is initialized.

| Command | Description |
| :--- | :--- |
| `/biospec.setup` | **Initialize Project**: Creates the `project/` directory structure and copies master templates. Run this first. |
| `/biospec.autofill` | **Populate Templates**: Automatically fill templates using project resources. |
| `/biospec.discuss` | **Brainstorm & Explore**: Open-ended scientific discussion. Use this to generate ideas, explore alternatives, or weigh pros/cons. |
| `/biospec.review` | **Peer Review**: Provides structured, critical feedback on specific fields or sections. Identifies flaws, missing controls, or clarity issues. |
| `/biospec.edit` | **Targeted Edits**: Makes edits to specific fields based on your instructions. |
| `/biospec.status` | **Check Progress**: Updates `project/status.md` to reflect the completion status of your templates. |
| `/biospec.links` | **Manage References**: Validates existing links and suggests new cross-references between intents, datasets, and analyses. |

Experimental commands (Work in progress):

- `/biospec.experimental.filter`: Filter provided project materials to remove text not related to a specified project. 

## Agent & Models

### BioSpec Agent
All BioSpec commands use a custom agent with restricted tool usage. This design adds guardrails, reduces context overhead, and prevents bloating your main Copilot instructions.

## Templates & Directory Structure

### Core Templates

The templates follow three design principles:
1. **Granularity**: Overview templates for summaries, and specific templates for detailed components.
2. **Atomicity**: Minimize repetition.
3. **Sufficiency**: Capture essential project details with minimal fields.

Currently, the templates are:

| Template | Description |
| :--- | :--- |
| `project_overview.md` | **Project Metadata**: Title, summary, scientific context, scope, and key stakeholders. |
| `project_resources.md` | **Environment**: Computing resources, software stack, hardware, and data storage requirements. |
| `intent_overview.md` | **Research Aims Index**: Lists all research questions/aims with a summary table and project-level milestones. |
| `dataset_overview.md` | **Data Index**: Lists all datasets with a summary table and integration strategy. |
| `analysis_overview.md` | **Analysis Index**: Lists all analysis objectives with priorities and dependencies. |
| `status.md` | **Progress Tracker**: Tracks the completion status of all templates and fields. |

### Subtemplates (Granular Components)

These templates are instantiated multiple times—once for each distinct component of your project.

| Template | Description | Location |
| :--- | :--- | :--- |
| `intent.md` | **Research Question**: A single aim, goal, or hypothesis. | `project/intents/intent-{n}.md` |
| `dataset.md` | **Data Source**: A single dataset or cohort specification. | `project/datasets/dataset-{n}.md` |
| `analysis.md` | **Computational Task**: A single analysis objective or method. | `project/analyses/analysis-{n}.md` |

### Directory Layout

```
.biospec/                          # Master templates (do not modify)
├── subtemplates/                  # Master subtemplates for repeating components
│   ├── intent.md
│   ├── dataset.md
│   └── analysis.md
├── *_overview.md                  # Master overview templates
└── status.md                      # Master status template

project/                           # Your active project specification
├── intents/                       # Individual intent instances
│   ├── intent-1.md
│   └── ...
├── datasets/                      # Individual dataset instances
│   ├── dataset-1.md
│   └── ...
├── analyses/                      # Individual analysis instances
│   ├── analysis-1.md
│   └── ...
├── intent_overview.md             # Index linking to all intents
├── dataset_overview.md            # Index linking to all datasets
├── analysis_overview.md           # Index linking to all analyses
├── project_overview.md            # Project-level metadata
├── project_resources.md           # Computing resources
└── status.md                      # Completion tracking
```

### Additional Information
- To enable external agents to become explicitly aware of your BioSpec-created project specifications, copy the summary text from `optional-agent-instructions.md` into your agent's memory file (e.g. `copilot-instructions.md`, `CLAUDE.md`).

## Contributing

The approach for contributions is currently being decided. Please check back later for more details.

## License

See [LICENSE.md](LICENSE.md) for details.

## Acknowledgments

BioSpec is partly inspired by [GitHub's spec-kit](https://github.com/github/spec-kit), and the BioSpec CLI is adapted from their open-source codebase. We encourage you to try spec-kit for planning and implementing the downstream tasks defined in your BioSpec project specifications.
