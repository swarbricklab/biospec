---
template_name: Decisions Register
schema_version: 0.3.1
last_updated: 2026-05-25
---

# Decisions Register

A running log of project-level decisions: what was chosen, why, what
alternatives were considered, and when to revisit.

## Decision 1
- **id**: DR1
- **date**: 2026-04-15
- **title**: Batch correction tool
- **status**: active
- **decision**: Use Harmony over BBKNN or scVI
- **rationale**: Faster on this cohort size; team familiar with the API
- **alternatives_considered**: BBKNN (graph-only, harder to inspect), scVI (probabilistic, longer training)
- **scope / affects**: A1
- **decision_maker(s)**: Dr Example (PI)
- **reversibility**: two-way door
- **confidence**: medium
- **evidence**: Internal benchmark notebook `benchmarks/batch_correction.ipynb`; Tran et al. (2020) benchmark.
- **supersedes**: N/A
- **superseded_by**: N/A
- **revisit_when**: Cohort size exceeds 200 patients or batches grow beyond 8

## Decision 2
- **id**: DR2
- **date**: 2026-04-20
- **title**: Two-cluster annotation resolution
- **status**: active
- **decision**: Report results at Leiden resolutions 0.6 and 1.0 (sensitivity comparison)
- **rationale**: Single-resolution choices are fragile; reporting two resolutions makes the sensitivity-analysis claim concrete
- **alternatives_considered**: single resolution 0.8 (rejected — no robustness check), four resolutions (rejected — figure clutter)
- **scope / affects**: A1
- **decision_maker(s)**: Dr Example (PI)
- **reversibility**: two-way door
- **confidence**: high
- **evidence**: Common-practice in scRNA-seq QC literature; team prior experience.
- **supersedes**: N/A
- **superseded_by**: N/A
- **revisit_when**: Annotation found unstable across both resolutions; or downstream survival modelling sensitive to resolution choice.

## Related Components

**Affects Intents**:
- [Intent 1: TIL subsets vs RFS](../intents/intent-1.md)

**Affects Datasets**:
- [Dataset 1: TIL scRNA-seq](../datasets/dataset-1.md)

**Affects Analyses**:
- [Analysis 1: TIL annotation + survival](../analyses/analysis-1.md)
