---
template_name: Project Graph
schema_version: 0.3.1
last_updated: 2026-05-25
---

# Project Graph

```mermaid
graph LR
    D1["Dataset 1:<br/>TIL scRNA-seq"]
    A1["Analysis 1:<br/>TIL annotation +<br/>survival"]
    I1["Intent 1:<br/>TIL subsets vs RFS"]
    DR1["DR1:<br/>Batch correction tool"]

    D1 --> A1
    A1 --> I1
    DR1 -.-> A1
```

## See also

- [Intent Overview](intent_overview.md)
- [Dataset Overview](dataset_overview.md)
- [Analysis Overview](analysis_overview.md)
- [Decisions Register](registers/decisions.md)
