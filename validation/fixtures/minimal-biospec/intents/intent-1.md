---
template_name: Intent Document
intent_id: 1
intent_type: aim
schema_version: 0.3.0
last_updated: 2026-05-25
---

# Intent 1: TIL subsets vs RFS

## Statement
**Type**: Aim

**Statement**: Identify tumour-infiltrating lymphocyte subsets whose
abundance is associated with recurrence-free survival in a 40-patient
breast cancer cohort.

**Mode**: targeted

**Priority**: High

**Decision rule / what would change our mind**:
If no subset shows |HR| > 1.3 with FDR < 0.1, conclude no robust association
at this cohort size and recommend expansion or alternative modality.

<details>
<summary>Associated Hypotheses</summary>

- **Does this intent have associated hypotheses?**: Yes

### Hypothesis 1 Details
- **Short ID**: H1-exhausted-CD8
- **Statement**: Higher abundance of exhausted CD8+ T cells associates with shorter RFS.
- **Rationale**: Prior breast cancer studies suggest exhausted CD8+ TILs predict poor outcome.
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
