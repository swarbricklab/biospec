---
template_name: Project Overview
schema_version: 0.3.1
last_updated: YYYY-MM-DD
---

---
**Navigation**: [Project Overview](project_overview.md) | [Intent Overview](intent_overview.md) | [Dataset Overview](dataset_overview.md) | [Analysis Overview](analysis_overview.md) | [Dependencies](dependencies.md) | [Project Resources](project_resources.md)

---

# Project Overview
<!-- High-level overview of your project -->

## Basic Information
- **Project Title**: <!-- Descriptive, report-style title -->
<!--
Common project types:
- exploratory: Open-ended data investigation, pattern discovery
- targeted: Testing specific hypotheses with defined success criteria
- method development: Building new analytical approaches or algorithms
- package development: Building reusable tools, libraries, or software
- workflow development: Creating reproducible pipelines (Snakemake, Nextflow, etc.)
- workflow application: Applying established pipelines to new data
- benchmarking: Systematic comparison of methods or tools
- shared task: Multi-site collaboration on common objectives
-->
- **Project Type**:
- **Start Date**: <!-- ISO date if known (YYYY-MM-DD); otherwise YYYY-Qn or YYYY-MM -->
- **Expected Duration**: <!-- E.g., "6 months", "2 years", "open-ended" -->
- **Principal Investigator/Lead**: <!-- Name; optionally affiliation + ORCID -->
- **Teams & Collaborators**: <!-- Internal teams plus external collaborators (clinical sites, consortia, industry) -->
- **Primary Repository**: <!-- URL or Name. Source of truth for the project repo URL; project_resources.md links here, do not redeclare. -->
- **Funding / Grant**:
  <!-- Funder, scheme, grant code, award ID. E.g., "NHMRC Ideas Grant 2020042; NIH R01CA123456". Required for acknowledgements in publications. -->
- **Conflict of interest / Disclosures**:
  <!-- Declared COIs at the project level, or "None declared". -->

## Brief Summary
<!-- A clear, concise paragraph (3-5 sentences) describing the project's purpose, goals, and main cohort/dataset. Aim for something a non-specialist collaborator could read in 30 seconds. -->

## Governance
<!--
Project-level governance separate from per-dataset terms (which live in
dataset.md → Governance). Use this section for approvals and commitments
that span the whole project.
-->
- **Ethics approval**:
  <!-- Project-level HREC / IRB number(s) covering the work as a whole; e.g., "HREC/2024/0123". Per-dataset ethics live in datasets/dataset-{n}.md → Governance. -->
- **Pre-registration**:
  <!-- OSF / clinicaltrials.gov / protocols.io / internal protocol registration ID where applicable. -->
- **Data sharing & FAIR plan**:
  <!-- Target repository for deposition (GEO, EGA, ArrayExpress, Zenodo, Figshare), embargo policy, and any FAIR commitments (controlled vocabularies, persistent identifiers, metadata standards). Funders increasingly require this upfront. -->

## Keywords
<!-- Words or phrases (separated by commas ',') that best describe the project -->

## Scientific Context
<!-- For tool/method development projects not tied to a specific biological system, this section may be brief or N/A -->

- **Biological System**: 
  - Organism(s): <!-- E.g., human, mouse -->
  - Organ/Tissue Type(s): <!-- E.g., normal breast tissue, liver -->
  - Cell Types(s): <!-- E.g., immune cells -->
  - Developmental Stage: <!-- E.g., adult -->

<!--
Modalities / assays intended across the project. Per-dataset specifics
(platform, chemistry, reference genome) live in datasets/dataset-{n}.md
under each `### Modality {m}` block; this field is the project-wide scope.
Group your entries along three axes:
  - Omics layer: e.g. genomic, transcriptomic, proteomic, metabolomic, multi-omic
  - Assay / platform: e.g. scRNA-seq, WTS, WGS, Visium, Xenium, Phenocycler, SNP microarray, H&E pathology
  - Sample model: e.g. primary tissue, organoid, PDX, cell line
-->
- **Modalities & Assays**:
  - Omics layer:
  - Assay / platform:
  - Sample model:

- **Key Biological Processes of Interest**: <!-- Bullet-point list e.g., pathways, interactions, architectures -->

## Expected Project Outputs

- **Primary outputs**: <!-- E.g., single/multiple publications, visualisation dashboard, guideline recommendation -->

- **Secondary outputs**: <!-- E.g., dataset annotations, analysis tutorial notebook -->

## Project Scope

### Activities in Scope
<!-- A bullet-point list of computational methods, biological investigations and technical frameworks that are viable given the project's context -->

### Activities out of Scope 
<!-- A bullet-point list of approaches or investigations that are beyond the project's current scope e.g. development of novel methods/tools, training generative models, usage of proprietary software -->

## Prior Work & Inspiration
- **Reference Studies**: <!-- Prior studies that inspired or have methods/data included in the present project -->
- **Methods to Adapt**: <!-- Computational tools, methods or strategies of interest: either GitHub repositories or publications. Treat as candidates for adaptation, not commitments. -->
- **Key Papers/Resources**: <!-- Background reading or related work to help others familiarise themselves with the project. Could be a link to a citation repository. -->
