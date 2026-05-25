---
template_name: Dataset
dataset_id: {n}
schema_version: 0.3.1
last_updated: YYYY-MM-DD
---

---
**Navigation**: [Project Overview](../project_overview.md) | [Intent Overview](../intent_overview.md) | [Dataset Overview](../dataset_overview.md) | [Analysis Overview](../analysis_overview.md) | [Dependencies](../dependencies.md) | [Project Resources](../project_resources.md)

---

# Dataset {n}: {Short Descriptor}
<!--
This template represents a single dataset.

Scope boundary: cohort-level inclusion/exclusion lives here under Cohort
Characteristics. Per-analysis subsetting (e.g. "drop samples with low UMI for
this clustering run") lives in analysis.md → Input Data → Subset/filters.
-->

## Extended Name
<!-- Full descriptive name for this dataset, e.g., "TCGA Breast Cancer RNA-seq Cohort" -->

## Dataset-Level Context

**Source Cohort(s)**: <!-- Summarise the cohorts from which this dataset was obtained -->

**Sample Selection Logic**: <!-- Criteria for selecting or excluding particular samples (cohort-level). For per-analysis subsetting, use analysis.md → Input Data → Subset/filters. -->

**Access**: Public | In-house

**Citation**: <!-- BibTeX key, DOI, or freeform reference -->

## Provenance & Identifiers
<!--
External references that uniquely identify this dataset version. Fill in any
that apply; leave blank rather than guessing.
-->
**Accession**:
<!-- E.g., "GEO: GSE123456", "EGA: EGAD00001000000", "dbGaP: phs000178" -->

**Version**:
<!-- E.g., "Internal v1.0", "GENCODE v44 reprocess", "freeze-2026-03-15" -->

**DOI / PID**:
<!-- E.g., "10.5281/zenodo.000000", or other persistent identifier -->

## Governance
<!--
Who can use this data, under what terms, and for what purposes. Filling this
in early prevents downstream surprises when sharing analyses or results.
-->
**License/DUA**:
<!-- E.g., "CC-BY 4.0", "Institutional DUA (contact: foo@bar)", "Restricted to project members" -->

**Ethics/Consent/IRB**:
<!-- HREC / IRB reference, type of consent, any restrictions on secondary use -->

**Sensitive-data classification**:
<!--
Tier definitions (BioSpec house convention; align with institutional policy):
- Public: openly released, no access controls
- Tier 1 de-identified: aggregate or fully de-identified individual-level data
- Tier 2 clinical+genomic: linked clinical+omics; controlled access (e.g. dbGaP-style DUA)
- Tier 3 identifiable: direct identifiers retained; strictest controls
Use your institution's tier labels if they differ, but keep the rationale explicit.
-->

**Permitted uses**:
<!-- Bullet list. Be explicit (e.g., "TIL characterisation", "survival modelling").
     Paraphrase from the DUA; cite the DUA section if legal accuracy matters. -->
-

**Forbidden uses**:
<!-- Bullet list (e.g., "patient re-identification", "commercial redistribution", "third-party sharing without DUA") -->
-

**Embargo / release date**:
<!-- If applicable: when the dataset becomes shareable beyond the project team, or YYYY-MM-DD release into a public archive. -->

**Data steward / contact**:
<!-- Person responsible for governance questions and access requests. -->

## Quality status
<!--
One short paragraph: has QC been performed? At what scope (per-sample,
per-modality, per-cell)? What was excluded and why? What known data quality
issues should downstream analyses account for?
-->

## Modalities
<!-- This dataset may include multiple modalities (assays).
Use one table row and one detail subsection per modality.
We assume one sample sheet per modality (it's okay if this is not the case). -->

| Modality | Format | Data Location | Sample Sheet Location | Processing Stage |
| --- | --- | --- | --- | --- |
|  |  |  |  |  |

<details>
<summary>Modality Details (expand for per-modality specifications)</summary>

<!-- Duplicate this section for each modality, replacing {m} with a number (1, 2, 3...) -->

### Modality {m}: {Short Descriptor}

**Modality**:
<!-- The data type / measurement, e.g. "scRNA-seq", "Visium spatial transcriptomics", "WGS", "H&E imaging" -->

**Format**:
<!-- File format / object type, e.g. "Anndata (h5ad)", "BAM", "FASTQ.gz", "OME-TIFF" -->

**Assay platform / chemistry**:
<!-- E.g., "10x Chromium 3' v3.1", "Visium FFPE", "Illumina NovaSeq 6000", "Xenium Prime 5K", "Phenocycler-Fusion" -->

**Library prep kit**:
<!-- E.g., "Chromium Next GEM Single Cell 3' Kit v3.1", "TruSeq Stranded mRNA" -->

**Reference genome + annotation**:
<!-- E.g., "GRCh38 / GENCODE v44", "T2T-CHM13 v2.0 / RefSeq", "GRCm39 / GENCODE vM33". Critical for joint analysis across datasets. -->

**Sequencing depth / coverage target**:
<!-- E.g., "50k reads/cell median", "30× WGS", "100M paired reads/sample". For imaging: pixel size / resolution. -->

**Read length / configuration**:
<!-- E.g., "2×150 paired-end", "single-end 75bp", "R1=28+R2=90 (10x v3 chemistry)" -->

**Multiplexing / pooling**:
<!-- E.g., "cell hashing (HTO)", "MULTI-seq lipid barcoding", "donor pooling + demuxlet", "none" -->

**Spike-ins / controls**:
<!-- E.g., "ERCC", "lambda phage", "SIRV", "none" -->

**Data Location**:

**Sample Sheet Location**: <!-- Relative path or URL to a samplesheet or document containing unique identifiers for the samples included -->

**Processing Stage**: <!-- E.g. Raw, aligned, count matrix -->

**Upstream pipeline / processed-by**:
<!-- Pipeline name + version (e.g. "nf-core/scrnaseq v2.4.1") and a link to the lockfile/container digest if known. Distinguish raw vs derived datasets here. -->

**Supplementary Data Types (and formats)**:
<!-- Cell metadata, spatial coordinates, etc. -->

**Additional or Reference Data Required**:

**Total size**:
<!-- Approximate on-disk volume (GB / TB) and file count, useful for storage planning. -->

**Checksums / manifest**:
<!-- Path to md5/sha256 manifest or note that none exists. -->

</details>

<details>
<summary>Sample Information (expand for detailed sample metadata)</summary>

**Total Samples**: <!-- Count of unique biological units represented in this dataset (e.g., participants or biospecimens) -->

**Batch Variables**: <!-- Variables that may introduce batch effects, e.g., sequencing run, processing date, collection site -->

**Identifier Convention**: <!-- E.g., sample IDs follow pattern: {cohort}_{subject}_{sample} -->

### Required metadata
<!-- In addition to the primary data, what other information is needed per sample (typically from the modality sample sheet)? E.g., disease status, age, medical history. -->
-

### Availability
<!-- For each item above, note whether it is fully available, partial, or missing. -->
-

### Data dictionary / codebook
<!-- Path or URL to a data dictionary that defines variables, units, controlled vocabularies (Cell Ontology, EFO, HPO, MONDO, etc.). -->

</details>

<details>
<summary>Cohort Characteristics (expand for clinical / cohort datasets)</summary>

<!--
For clinical, epidemiological, or biospecimen-cohort datasets. Distinct from
Sample Selection Logic (which is about samples) — this block describes the
*population* the samples came from. Mark fields N/A for non-cohort datasets
(e.g. cell-line benchmarks, public reference databases).
-->

**Inclusion criteria**:
<!-- Bullet list. E.g., "adult women aged 18-75", "primary breast cancer, treatment-naive", "ECOG 0-1" -->
-

**Exclusion criteria**:
<!-- Bullet list. E.g., "prior chemotherapy", "neoadjuvant treatment", "BRCA1/2 germline carriers" -->
-

**Recruitment site(s)**:
<!-- Institution / clinic / consortium. List each if multi-site. -->

**Recruitment period**:
<!-- YYYY-MM to YYYY-MM, or YYYY-MM to present. -->

**Demographic distribution**:
<!-- Age (median + range), sex/gender breakdown, ancestry / self-reported race where available and ethically appropriate. Aggregate, not per-participant. -->

**Missingness profile**:
<!-- Short prose: which key variables are missing in what proportion. E.g., "treatment response missing in 18/120 (15%); follow-up <12mo in 8 patients." -->

**Follow-up / censoring**:
<!-- For survival / longitudinal cohorts: median follow-up time, censoring rule, last-event-or-contact date. -->

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
