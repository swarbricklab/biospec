---
template_name: Intent Document
intent_id: 1
intent_type: aim
schema_version: 0.3.1
last_updated: 2026-05-25
---

# Intent 1: TIL subsets vs RFS

## Statement
**Type**: Aim

**Statement**: Identify tumour-infiltrating lymphocyte subsets whose
abundance is associated with recurrence-free survival in a 40-patient
breast cancer cohort.

**Mode**: confirmatory

**Priority**: High

**Falsifier**:
If no subset shows |HR| > 1.3 with FDR < 0.1, conclude no robust association
at this cohort size and recommend expansion or alternative modality.

## Framing
- **PICO / PECO**:
  - Population: adult women with primary breast cancer, treatment-naive
  - Intervention / Exposure: TIL subset composition (high vs low for each subset)
  - Comparator: contrast across the cohort (no separate control arm)
  - Outcome: recurrence-free survival (time to recurrence or death)
- **Expected effect size / minimum detectable effect (MDE)**: HR ~1.5 for the leading subset; MDE at this cohort size approximately |HR| = 1.3 with 80% power.
- **Prior literature anchors**:
  - Savas et al. (2018) — single-cell TIL atlas in breast cancer.
  - Bassez et al. (2021) — pre/post-treatment TIL dynamics.
- **Stakeholders / audience**: Example Lab; collaborating oncology clinic; downstream meta-analysis project.
- **Time horizon / exit criteria**: Park this intent if cohort accrual cannot reach 40 evaluable patients by 2026-12.
- **Pre-registration link**: N/A (internal protocol BRCA-TIL-001).

<details>
<summary>Associated Hypotheses</summary>

- **Does this intent have associated hypotheses?**: Yes

### Hypothesis 1 Details
- **Short ID**: H1-exhausted-CD8
- **Statement**: Higher abundance of exhausted CD8+ T cells associates with shorter RFS.
- **Rationale**: Prior breast cancer studies suggest exhausted CD8+ TILs predict poor outcome.
- **Pre-specified**: Yes
- **Direction**: directional
- **Null Hypothesis**: No association between exhausted CD8+ TIL fraction and RFS.
- **Alternative Hypothesis**: Higher exhausted CD8+ fraction → shorter RFS.

</details>

## Success Criteria
**Criteria**:
- At least one TIL subset reaches HR significance (|HR| > 1.3, FDR < 0.1)
- Result reproducible across two independent batches

## Related Components

**Related Datasets**:
- [Dataset 1: TIL scRNA-seq](../datasets/dataset-1.md)

**Related Analyses**:
- [Analysis 1: TIL annotation + survival](../analyses/analysis-1.md)

**Back to Overview**: [Intent Overview](../intent_overview.md)

## Notes
Fixture intent — used for validation. Do not depend on its specific wording in tests.
