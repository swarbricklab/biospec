---
template_name: Dependencies
schema_version: 0.3.0
last_updated: 2026-05-25
---

# Dependencies

```mermaid
graph LR
    D1["Dataset 1:<br/>TIL scRNA-seq"]
    A1["Analysis 1:<br/>TIL annotation +<br/>survival"]
    I1["Intent 1:<br/>TIL subsets vs RFS"]

    D1 --> A1
    A1 --> I1
```

## Links to Individual Components

### Dataset Links
- [Dataset 1: TIL scRNA-seq](datasets/dataset-1.md)

### Intent Links
- [Intent 1: TIL subsets vs RFS](intents/intent-1.md)

### Analysis Links
- [Analysis 1: TIL annotation + survival](analyses/analysis-1.md)
