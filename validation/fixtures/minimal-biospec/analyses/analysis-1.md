---
template_name: Computational Task/Analysis
analysis_id: 1
schema_version: 0.3.1
last_updated: 2026-05-25
---

# Analysis 1: TIL annotation + survival

## Description
Cluster scRNA-seq cells, annotate TIL subsets, quantify per-patient
subset abundance, fit Cox proportional-hazards models against RFS.

## Input Data
- **Primary input**: [Dataset 1](../datasets/dataset-1.md) — TIL scRNA-seq counts
- **Subset/filters**: T-lineage cells only (CD3 expression > 0)
- **Required preprocessing**: scran normalisation, batch correction (Harmony)

## Priority
**Priority Level**: Must Have

**Priority Rationale**: This is the project's primary analytical objective.

## Analysis Flow

### Step 1: QC + normalisation
- Drop cells failing nFeature/percent.mt thresholds (already in dataset)
- Normalise counts (scran size-factor)
- Identify HVGs

### Step 2: Batch correction + clustering
- Harmony on capture date + library prep batch
- Leiden clustering at resolution 0.6 and 1.0 (sensitivity analysis)
- UMAP for visualisation only

## Execution & Reproducibility
- **Environment**: R 4.4, Seurat 5.0.3, Harmony 1.2.0; lockfile pinned in `renv.lock`
- **Random seeds**: 42 for clustering, 7 for UMAP
- **Compute**: Single 64GB node; expected wall-time ~6 hours
- **Output location**: `/shared/projects/example/results/analysis-1/`

## Expected Outputs
**Primary Outputs**:
- Clustered + annotated Anndata
- Per-patient TIL subset abundance table
- Cox model results table

**Intermediate/Additional Files**:
- HVG list, Harmony embeddings, cluster marker tables

**Visualizations to Create**:
- UMAP by cluster, UMAP by patient
- Forest plot of HRs per subset

## Assumptions & Limitations
- T cells captured representatively across patients
- 40 patients yields adequate power to detect HR ≥ 1.3
- Batch effects fully modelled by Harmony on capture + prep batch

## Success Criteria
**Criteria**:
- ≥4 reproducible TIL subsets across resolutions 0.6 and 1.0
- Cox models converge with proportional-hazards assumption met

## Validation Strategy

### Controls
- Healthy donor PBMC reference panel as a sanity check on annotation

### Sanity checks
- Marker gene specificity per cluster (canonical CD8, CD4, FOXP3)

### Information leakage
- Survival outcome must not be used in clustering or HVG selection

### Sensitivity analysis
- Repeat at resolutions 0.4, 0.6, 1.0, 1.2 — annotation must be stable
- Drop-one-batch survival re-fit

### Multiple testing
- BH FDR across subsets; report q-values

### Failure modes
- If proportional-hazards fails: switch to time-varying or stratified Cox
- If no subset reaches HR threshold: report null per Intent 1 Falsifier

## Related Components
**Addresses Intents**:
- [Intent 1: TIL subsets vs RFS](../intents/intent-1.md)

**Uses Datasets**:
- [Dataset 1: TIL scRNA-seq](../datasets/dataset-1.md)

**Back to Overview**: [Analysis Overview](../analysis_overview.md)

## Notes
Fixture analysis — the two-step storyboard above (Step 1 + Step 2) is
deliberately repeated-header format to exercise template-integrity tests.
Editors must NOT collapse this into a table.
