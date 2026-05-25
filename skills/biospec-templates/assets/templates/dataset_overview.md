---
template_name: Dataset Overview
schema_version: 0.3.1
last_updated: YYYY-MM-DD
---

# Dataset Overview

<!-- This file orchestrates and aggregates all datasets/cohorts for the project -->

---
**Navigation**: [Project Overview](project_overview.md) | [Intent Overview](intent_overview.md) | [Dataset Overview](dataset_overview.md) | [Analysis Overview](analysis_overview.md) | [Dependencies](dependencies.md) | [Project Resources](project_resources.md)

---

## Datasets
<!-- Links to individual dataset files -->

### List of Datasets
1. [Dataset 1: {Short Descriptor}](datasets/dataset-1.md)
2. [Dataset 2: {Short Descriptor}](datasets/dataset-2.md)
<!-- Add new datasets by creating dataset-{n}.md in datasets/ and adding a row to the table below -->

### Summary Table
<!--
Aggregated view of all atomic datasets.
Values should be consistent with the corresponding dataset file (see subtemplate: `.biospec/subtemplates/dataset.md`).

Column mapping guidance:
- Dataset: link text should match the dataset title (`Dataset {n}: {Short Descriptor}`), where possible.
- Source Cohort(s): from **Source Cohort(s)**.
- Modalities: comma-separated list from the **Modalities** table (Modality column).
- Total Samples: from **Total Samples**.
- Access: from **Access** (Public | In-house).
- Processing Stage (Summary): summarize the per-modality processing stages; if multiple, use `Mixed: ...`.
-->

| Dataset | Source Cohort(s) | Modalities | Total Samples | Access | Processing Stage (Summary) |
| :--- | :--- | :--- | ---: | :--- | :--- |
| [Dataset 1: {Short Descriptor}](datasets/dataset-1.md) | {Cohort(s)} | {Modality 1, Modality 2} | {N} | {Public/In-house} | {Raw/Aligned/Count matrix/Processed/Mixed: ...} |
| [Dataset 2: {Short Descriptor}](datasets/dataset-2.md) | {Cohort(s)} | {Modality 1} | {N} | {Public/In-house} | {Raw/Aligned/Count matrix/Processed} |


## Global Data Strategy
<!-- High-level data management considerations across all datasets -->

### Data Integration Plan
<!-- How will multiple datasets be integrated or combined? -->
<!--
Capture decisions that affect multiple datasets 
Examples:
- Which atomic datasets are co-analysed vs kept separate?
- What is the integration unit (participant, sample, cell)?
-->
- 

### Cross-Dataset Considerations
<!-- Batch effects, normalization strategies, etc. -->
- 

### Data Sharing & Publication
<!--
Cross-dataset reconciliation only — where licences, embargoes, or release
timing conflict across datasets and need a unified plan. Per-dataset
governance (licence, DUA, embargo end date, permitted/forbidden uses) lives
in datasets/dataset-{n}.md → Governance and is the source of truth.

Project-level FAIR commitments and primary deposition target live in
project_overview.md → Data sharing & FAIR plan.
-->
-
