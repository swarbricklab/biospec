---
template_name: Dataset
dataset_id: {n}
schema_version: 0.2.0
last_updated: YYYY-MM-DD
---

---
**Navigation**: [Project Overview](../project_overview.md) | [Intent Overview](../intent_overview.md) | [Dataset Overview](../dataset_overview.md) | [Analysis Overview](../analysis_overview.md) | [Dependencies](../dependencies.md) | [Project Resources](../project_resources.md) | [Status](../status.md)

---

# Dataset {n}: {Short Descriptor}
<!-- This template represents a single dataset -->

## Extended Name
<!-- Full descriptive name for this dataset, e.g., "TCGA Breast Cancer RNA-seq Cohort" -->

## Dataset-Level Context

**Source Cohort(s)**: <!-- Summarise the cohorts from which this dataset was obtained -->

**Sample Selection Logic**: <!-- Criteria for selecting or excluding particular samples from a dataset for analysis -->

**Access**: Public | In-house

**Citation**:

## Modalities
<!-- This dataset may include multiple modalities.
Use one table row and one detail subsection per modality.
We assume one sample sheet per modality (it's okay if this it not the case). -->

| Modality | Format | Data Location | Sample Sheet Location | Processing Stage |
| --- | --- | --- | --- | --- |
|  |  |  |  |  |

<details>
<summary>Modality Details (expand for per-modality specifications)</summary>

<!-- Duplicate this section for each modality -->

### Modality {m}: {Short Descriptor}

**Modality and Format**:
<!-- Example: scRNA-seq expression matrix (Anndata) -->

**Data Location**:

**Sample Sheet Location**: <!-- Relative path or URL to a samplesheet or document containing unique identifiers for the samples included -->

**Processing Stage**: <!-- E.g. Raw, aligned, count matrix -->

**Supplementary Data Types (and formats)**:
<!-- Cell metadata, spatial coordinates, etc. -->

**Additional or Reference Data Required**:

</details>

<details>
<summary>Sample Information (expand for detailed sample metadata)</summary>

**Total Samples**: <!-- Count of unique biological units represented in this dataset (e.g., participants or biospecimens) -->

**Batch Variables**: <!-- Variables that may introduce batch effects, e.g., sequencing run, processing date, collection site -->

**Identifier Convention**: <!-- E.g., sample IDs follow pattern: {cohort}_{subject}_{sample} -->

## Required Metadata & Availability
<!-- In addition to the primary data, what other information is available/needed per sample (typically from the modality sample sheet)? E.g., disease status, age, medical history. -->
-

</details>

## Related Components
<!-- Links to related components -->

**Addresses Intents**:
<!-- List intent IDs this dataset can help address -->
- [Intent {n}: {Short Identifier}](../intents/intent-{n}.md)

**Used in Analyses**:
<!-- List analysis IDs that use this dataset -->
- [Analysis {n}: {Descriptor}](../analyses/analysis-{n}.md)

**Back to Overview**: [Dataset Overview](../dataset_overview.md)

## Notes
<!-- Any additional free text notes or considerations -->
