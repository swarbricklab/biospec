---
template_name: Dependencies
schema_version: 0.3.0
last_updated: YYYY-MM-DD
---

---
**Navigation**: [Project Overview](project_overview.md) | [Intent Overview](intent_overview.md) | [Dataset Overview](dataset_overview.md) | [Analysis Overview](analysis_overview.md) | [Dependencies](dependencies.md) | [Project Resources](project_resources.md)

---

# Dependencies
<!-- Overview diagram (mermaid format) of links between intents, datasets and analyses -->

The diagram below summarises the interconnections between this project's intents, datasets and analyses. 

## Dependency Diagram

Edit the diagram below to suit your project, or run `/biospec.diagram`. 

```mermaid
graph LR
    %% Nodes
    D1["Dataset 1:<br/>Bulk RNA-seq"]
    D2["Dataset 2:<br/>Single-cell RNA-seq"]
    
    A1["Analysis 1:<br/>Differential Expression"]
    A2["Analysis 2:<br/>Pathway Enrichment"]
    A3["Analysis 3:<br/>Cell Type Clustering"]
    A4["Analysis 4:<br/>Trajectory Inference"]
    
    I1["Intent 1:<br/>Identify Biomarkers"]
    I2["Intent 2:<br/>Characterize Heterogeneity"]

    %% Data to Analysis
    D1 --> A1
    D2 --> A1
    D1 --> A2
    D2 --> A2
    D2 --> A3
    D2 --> A4

    %% Analysis to Intent
    A1 --> I1
    A2 --> I1
    A3 --> I1
    A4 --> I2
```

<!-- Update the diagram above to reflect your project's actual dependencies -->

## Links to Individual Components

### Dataset Links
<!-- Links to individual dataset files -->
- [Dataset {n}: {Name/Identifier}](datasets/dataset-1.md)
- [Dataset {n}: {Name/Identifier}](datasets/dataset-2.md)

### Intent Links
<!-- Links to individual intent files -->
- [Intent {n}: {Short Identifier}](intents/intent-1.md)
- [Intent {n}: {Short Identifier}](intents/intent-2.md)

### Analysis Links

- [Analysis {n}: {Descriptor}](analyses/analysis-1.md)
- [Analysis {n}: {Descriptor}](analyses/analysis-2.md)