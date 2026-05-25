---
template_name: Dataset
dataset_id: 1
schema_version: 0.3.0
last_updated: 2026-05-25
---

# Dataset 1: TIL scRNA-seq

## Extended Name
Tumour-infiltrating lymphocyte scRNA-seq cohort (40 patients, breast cancer)

## Dataset-Level Context
**Source Cohort(s)**: Example Lab 2024 breast cancer recruitment

**Sample Selection Logic**: Treatment-naive primary tumours; ≥30% tumour purity by pathology review.

**Access**: In-house

**Citation**: Unpublished

## Provenance & Identifiers
**Version/Accession/DOI**: Internal v1.0; no public accession yet.

## Governance
**License/DUA**: Institutional DUA, contact: example@example.org
**Ethics/Consent/IRB**: HREC/2024/0123; informed consent for research use only
**Sensitive-data classification**: Tier 2 (de-identified clinical + genomic)
**Permitted uses**: TIL characterisation, survival modelling
**Forbidden uses**: Patient re-identification; commercial redistribution

## Quality status
QC passed Seurat default thresholds (nFeature 200-6000, %mt < 15). 4/44 samples excluded.

## Modalities

| Modality | Format | Data Location | Sample Sheet Location | Processing Stage |
| --- | --- | --- | --- | --- |
| scRNA-seq | Anndata (h5ad) | /shared/projects/example/processed/til.h5ad | /shared/projects/example/samplesheet.csv | Count matrix |

<details>
<summary>Modality Details</summary>

### Modality 1: scRNA-seq
**Modality and Format**: 10x Genomics 3' v3 scRNA-seq, Anndata
**Data Location**: /shared/projects/example/processed/til.h5ad
**Sample Sheet Location**: /shared/projects/example/samplesheet.csv
**Processing Stage**: Cell-by-gene count matrix (post-CellRanger, post-QC)
**Supplementary Data Types**: Patient metadata, tumour grade
**Additional or Reference Data Required**: GRCh38 reference

</details>

<details>
<summary>Sample Information</summary>

**Total Samples**: 40 patients (post-QC)
**Batch Variables**: Capture date, library prep batch
**Identifier Convention**: TIL_{patient_id}_{capture_date}

## Required Metadata & Availability
- Age at diagnosis (available)
- Tumour grade (available)
- Recurrence-free survival time (available)
- Recurrence event (available)
- Treatment regimen (partial)

</details>

## Related Components
**Addresses Intents**:
- [Intent 1: TIL subsets vs RFS](../intents/intent-1.md)

**Used in Analyses**:
- [Analysis 1: TIL annotation + survival](../analyses/analysis-1.md)

**Back to Overview**: [Dataset Overview](../dataset_overview.md)

## Notes
Fixture dataset — used for validation.
