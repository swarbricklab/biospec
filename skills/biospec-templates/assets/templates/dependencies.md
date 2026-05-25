---
template_name: Project Graph
schema_version: 0.3.1
last_updated: YYYY-MM-DD
---

---
**Navigation**: [Project Overview](project_overview.md) | [Intent Overview](intent_overview.md) | [Dataset Overview](dataset_overview.md) | [Analysis Overview](analysis_overview.md) | [Dependencies](dependencies.md) | [Project Resources](project_resources.md)

---

# Project Graph
<!--
Overview diagram (mermaid format) of the relationships between intents,
datasets, analyses, and decisions for this project.

Filename note: kept as `dependencies.md` for backwards compatibility; the
content covers all component relationships, not only dependencies.
-->

<!--
Source of truth: this file is a **derived view** of the cross-links recorded
in intent.md, dataset.md, analysis.md, decisions.md, and the three overview
summary tables. When in conflict, the per-component Related Components blocks
win. Regenerate or hand-update after meaningful changes to those files (see
`/biospec.diagram` if your project has tooling for this).
-->

The diagram below summarises the interconnections between this project's
intents, datasets, analyses, and decision records.

## Project Graph

Edit the diagram below to suit your project, or run `/biospec.diagram`.

```mermaid
graph LR
    %% =========================================================
    %% Node prefixes:
    %%   I{n}  = Intent
    %%   D{n}  = Dataset
    %%   A{n}  = Analysis
    %%   DR{n} = Decision Record (from registers/decisions.md)
    %%
    %% Edge syntax (Mermaid):
    %%   A --> B            depends on / produces input for (default)
    %%   A -->|produces| B  A produces B (e.g. derived dataset)
    %%   A -->|validates| B A validates B (replication, sensitivity)
    %%   A -->|supersedes| B A replaces B
    %%   A -->|blocked-by| B B must clear before A can run
    %%   A <-->|compares-to| B benchmark / cross-comparison
    %%   DR1 -.-> A2        dotted = decision gates / informs target
    %% =========================================================

    %% Legend (delete or keep in your project file as you prefer)
    subgraph Legend [Legend]
        LI[I = Intent]
        LD[D = Dataset]
        LA[A = Analysis]
        LDR[DR = Decision Record]
    end

    %% Nodes
    D1["Dataset 1:<br/>Bulk RNA-seq"]
    D2["Dataset 2:<br/>Single-cell RNA-seq"]

    A1["Analysis 1:<br/>Differential Expression"]
    A2["Analysis 2:<br/>Pathway Enrichment"]
    A3["Analysis 3:<br/>Cell Type Clustering"]
    A4["Analysis 4:<br/>Trajectory Inference"]

    I1["Intent 1:<br/>Identify Biomarkers"]
    I2["Intent 2:<br/>Characterize Heterogeneity"]

    DR1["DR1:<br/>Batch correction tool"]

    %% Data to Analysis (default edge = "is input to")
    D1 --> A1
    D2 --> A1
    D1 --> A2
    D2 --> A2
    D2 --> A3
    D2 --> A4

    %% Analysis to Intent ("addresses")
    A1 --> I1
    A2 --> I1
    A3 --> I1
    A4 --> I2

    %% Example labelled edges (uncomment / adapt as needed)
    %% A3 -->|produces| D3
    %% A2 -->|validates| A1
    %% A4 -->|blocked-by| D3
    %% A1 <-->|compares-to| A2

    %% Decisions gate analyses (dotted edge)
    DR1 -.-> A1
    DR1 -.-> A3

    %% Status overlay — applies the analysis_overview.md Status column.
    %% Apply to any node with: `class A1 inProgress;`
    classDef planned   fill:#eee,stroke:#888,color:#222;
    classDef inProgress fill:#fff3b0,stroke:#b08900,color:#222;
    classDef blocked    fill:#ffd0d0,stroke:#a33,color:#222;
    classDef complete   fill:#d3f9d3,stroke:#2a7,color:#222;
    classDef deferred   fill:#e0e0ff,stroke:#558,color:#222;

    %% Example status assignments (uncomment / adapt as needed)
    %% class A1 complete;
    %% class A4 blocked;
```

<!-- Update the diagram above to reflect your project's actual relationships. -->

## See also

- [Intent Overview](intent_overview.md) — list of intents and their summaries.
- [Dataset Overview](dataset_overview.md) — list of datasets and their summaries.
- [Analysis Overview](analysis_overview.md) — list of analyses with priority and status.
- [Decisions Register](registers/decisions.md) — log of decision records (DR{n}).
