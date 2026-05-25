---
template_name: Dataset
dataset_id: 1
schema_version: 0.3.1
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
**Accession**: none yet (pending submission)
**Version**: Internal v1.0
**DOI / PID**: N/A

## Governance
**License/DUA**: Institutional DUA, contact: example@example.org
**Ethics/Consent/IRB**: HREC/2024/0123; informed consent for research use only
**Sensitive-data classification**: Tier 2 (de-identified clinical + genomic)
**Permitted uses**: TIL characterisation, survival modelling
**Forbidden uses**: Patient re-identification; commercial redistribution
**Embargo / release date**: Embargoed until first publication; estimated 2027-Q1
**Data steward / contact**: example@example.org

## Quality status
QC passed Seurat default thresholds (nFeature 200-6000, %mt < 15). 4/44 samples excluded. Per-cell QC at the cell level; per-sample QC summary in `/shared/projects/example/processed/qc_summary.csv`.

## Modalities

| Modality | Format | Data Location | Sample Sheet Location | Processing Stage |
| --- | --- | --- | --- | --- |
| scRNA-seq | Anndata (h5ad) | /shared/projects/example/processed/til.h5ad | /shared/projects/example/samplesheet.csv | Count matrix |

<details>
<summary>Modality Details</summary>

### Modality 1: scRNA-seq

**Modality**: scRNA-seq
**Format**: Anndata (h5ad)
**Assay platform / chemistry**: 10x Chromium 3' v3
**Library prep kit**: Chromium Next GEM Single Cell 3' Kit v3
**Reference genome + annotation**: GRCh38 / GENCODE v44
**Sequencing depth / coverage target**: 40k reads/cell median
**Read length / configuration**: R1=28 + R2=90 (10x v3 chemistry)
**Multiplexing / pooling**: none
**Spike-ins / controls**: none
**Data Location**: /shared/projects/example/processed/til.h5ad
**Sample Sheet Location**: /shared/projects/example/samplesheet.csv
**Processing Stage**: Cell-by-gene count matrix (post-CellRanger, post-QC)
**Upstream pipeline / processed-by**: nf-core/scrnaseq v2.4.1; lockfile at `pipelines/scrnaseq/lockfile.txt`
**Supplementary Data Types**: Patient metadata, tumour grade
**Additional or Reference Data Required**: GRCh38 reference bundle
**Total size**: ~95 GB across 40 samples
**Checksums / manifest**: /shared/projects/example/processed/MANIFEST.sha256

</details>

<details>
<summary>Sample Information</summary>

**Total Samples**: 40 patients (post-QC)
**Batch Variables**: Capture date, library prep batch
**Identifier Convention**: TIL_{patient_id}_{capture_date}

### Required metadata
- Age at diagnosis
- Tumour grade
- Recurrence-free survival time
- Recurrence event
- Treatment regimen

### Availability
- Age at diagnosis: available (40/40)
- Tumour grade: available (40/40)
- Recurrence-free survival time: available (40/40)
- Recurrence event: available (40/40)
- Treatment regimen: partial (32/40)

### Data dictionary / codebook
/shared/projects/example/processed/data_dictionary.csv

</details>

<details>
<summary>Cohort Characteristics</summary>

**Inclusion criteria**:
- Adult women aged 18-75
- Primary invasive breast cancer, treatment-naive at surgery
- ≥30% tumour purity by pathology review

**Exclusion criteria**:
- Prior chemotherapy or radiotherapy
- Neoadjuvant treatment
- Metastatic disease at presentation

**Recruitment site(s)**: Example Lab partner clinic (single site)

**Recruitment period**: 2024-03 to 2026-02

**Demographic distribution**: Median age 58 (range 34-74); 100% female (cohort-defined); ancestry self-report not collected.

**Missingness profile**: Treatment regimen missing in 8/40 (20%); all other clinical fields complete.

**Follow-up / censoring**: Median follow-up 14 months (range 6-22); censored at last contact or 2026-04-01, whichever earlier.

</details>

## Related Components
**Addresses Intents**:
- [Intent 1: TIL subsets vs RFS](../intents/intent-1.md)

**Used in Analyses**:
- [Analysis 1: TIL annotation + survival](../analyses/analysis-1.md)

**Back to Overview**: [Dataset Overview](../dataset_overview.md)

## Notes
Fixture dataset — used for validation.
