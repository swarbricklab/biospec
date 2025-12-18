---
template_name: Project Status
schema_version: 0.1.1
last_updated: YYYY-MM-DD
---

# Documentation Status

<!-- Track completion status of BioSpec templates and fields -->

---
**Navigation**: [Project Overview](project_overview.md) | [Intent Overview](intent_overview.md) | [Dataset Overview](dataset_overview.md) | [Analysis Overview](analysis_overview.md) | [Dependencies](dependencies.md) | [Project Resources](project_resources.md) | [Status](status.md)

---

## How to Use This Status File

Use the tables and checklists below to track progress for each BioSpec template and its major fields.

**Status Legend (per item or field)**  
- `[ ]` Incomplete – not started or no meaningful content  
- `[-]` In Progress – partially filled / draft  
- `[x]` Complete – field or template is filled to a usable standard  

You can update status in two ways:
- For high-level tracking, update the **Template Status Summary** table.
- For more detail, use the **Per-Template Field Checklists**.

---

## Template Status Summary

<!-- High-level status for each core template -->

| Template               | File / Location                 | Status         | Notes                            |
|------------------------|---------------------------------|----------------|-----------------------------------|
| Project Overview       | `project_overview.md`          | [ ]            |                                   |
| Project Resources      | `project_resources.md`         | [ ]            |                                   |
| Intent Overview        | `intent_overview.md`           | [ ]            |                                   |
| Intents (per-intent)   | `intents/`                     | [ ]            | Track per-file below              |
| Dataset Overview       | `dataset_overview.md`          | [ ]            |                                   |
| Datasets (per-dataset) | `datasets/`                    | [ ]            | Track per-file below              |
| Analysis Overview      | `analysis_overview.md`         | [ ]            |                                   |
| Analyses (per-analysis)| `analyses/`                    | [ ]            | Track per-file below              |

---

## Phase-Based Checklist (Coarse View)

### Phase 1: Project Setup
- [ ] `project_overview.md` – Basic information, scope, context
- [ ] `project_resources.md` – Computing environment, tools, SOPs

### Phase 2: Scientific Design
- [ ] `intent_overview.md` – Research questions, aims, goals
- [ ] Intents in `intents/` directory – One file per intent
- [ ] `dataset_overview.md` – Data sources and cohorts
- [ ] Datasets in `datasets/` directory – One file per dataset

### Phase 3: Analysis Planning
- [ ] `analysis_overview.md` – Computational objectives
- [ ] Analyses in `analyses/` directory – One file per analysis

---

## Per-Template Field Checklists

> Use these sections to mark status at the level of major fields within each template.  
> Update the status icon at the start of each line: `[ ]`, `[-]`, or `[x]`.

### 1. `project_overview.md`

| Field / Section                     | Status | Notes                          |
|-------------------------------------|--------|---------------------------------|
| Basic information (title, type, dates, team) | [ ]    |                                 |
| Brief summary                       | [ ]    |                                 |
| Keywords                            | [ ]    |                                 |
| Scientific context (biological system, scale, processes) | [ ]    |                                 |
| Expected project outputs            | [ ]    |                                 |
| Project scope (in/out of scope)     | [ ]    |                                 |
| Prior work & inspiration            | [ ]    |                                 |

---

### 2. `project_resources.md`

| Field / Section                     | Status | Notes                          |
|-------------------------------------|--------|---------------------------------|
| Hardware specifications             | [ ]    |                                 |
| HPC/Cloud details                   | [ ]    |                                 |
| Data storage                        | [ ]    |                                 |
| Version control (code management)   | [ ]    |                                 |
| Environment management              | [ ]    |                                 |
| Software stack                      | [ ]    |                                 |
| Standard operating procedures (SOPs)| [ ]    |                                 |

---

### 3. `intent_overview.md`

| Field / Section                         | Status | Notes                          |
|-----------------------------------------|--------|---------------------------------|
| Intents list (links to files)           | [ ]    |                                 |
| Summary table                           | [ ]    |                                 |
| Dependencies                            | [ ]    |                                 |

#### Per-Intent Status (files under `intents/`)

| Intent ID / File              | Status | Notes                  |
|------------------------------|--------|------------------------|
| `intents/intent-1.md`        | [ ]    |                        |
| `intents/intent-2.md`        | [ ]    |                        |
| …                            |        |                        |

---

### 4. `dataset_overview.md`

| Field / Section                          | Status | Notes                          |
|------------------------------------------|--------|---------------------------------|
| Datasets list (links to files)           | [ ]    |                                 |
| Summary table                            | [ ]    |                                 |
| Data integration plan                    | [ ]    |                                 |
| Cross-dataset considerations             | [ ]    |                                 |
| Data sharing & publication               | [ ]    |                                 |

#### Per-Dataset Status (files under `datasets/`)

| Dataset ID / File              | Status | Notes                  |
|--------------------------------|--------|------------------------|
| `datasets/dataset-1.md`        | [ ]    |                        |
| `datasets/dataset-2.md`        | [ ]    |                        |
| …                              |        |                        |

---

### 5. `analysis_overview.md`

| Field / Section                          | Status | Notes                          |
|------------------------------------------|--------|---------------------------------|
| Analyses by priority (Must Have / Nice to Have / Future) | [ ]    |                                 |
| Summary table                            | [ ]    |                                 |
| Analysis pipeline                        | [ ]    |                                 |
| Cross-analysis dependencies              | [ ]    |                                 |

#### Per-Analysis Status (files under `analyses/`)

| Analysis ID / File             | Status | Notes                  |
|--------------------------------|--------|------------------------|
| `analyses/analysis-1.md`       | [ ]    |                        |
| `analyses/analysis-2.md`       | [ ]    |                        |
| …                              |        |                        |

---

## Notes

<!-- Any general status notes or tracking information -->
- Use this section for free-form comments about progress, blockers, or decision points.