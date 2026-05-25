# BioSpec schema reference (v0.3.1)

## Contents
- [Frontmatter (all templates)](#frontmatter-all-templates)
- [project_overview.md](#project_overviewmd)
- [project_resources.md](#project_resourcesmd)
- [intent_overview.md](#intent_overviewmd)
- [dataset_overview.md](#dataset_overviewmd)
- [analysis_overview.md](#analysis_overviewmd)
- [dependencies.md](#dependenciesmd)
- [subtemplates/intent.md](#subtemplatesintentmd)
- [subtemplates/dataset.md](#subtemplatesdatasetmd)
- [subtemplates/analysis.md](#subtemplatesanalysismd)
- [subtemplates/decisions.md](#subtemplatesdecisionsmd)
- [Repeated-block conventions](#repeated-block-conventions)
- [Cross-link conventions](#cross-link-conventions)
- [Source-of-truth precedence](#source-of-truth-precedence)
- [Changes since 0.3.0](#changes-since-030)

## Frontmatter (all templates)

Every template begins with a YAML block. The required fields are:

- `template_name`: human-readable name (do not edit when instantiating).
- `schema_version`: pinned to the BioSpec release that defines the field set.
- `last_updated`: ISO-8601 date (`YYYY-MM-DD`) when the file was last meaningfully changed.

Subtemplates add an `_id` field (`intent_id`, `dataset_id`, `analysis_id`). Intent subtemplates also add `intent_type` (one of `question | aim | goal`).

## project_overview.md

Singleton. One per project.

- **Basic Information**: project title, type, start date, expected duration, PI, teams & collaborators, primary repository URL, **funding/grant** (new in 0.3.1), **conflict of interest** (new in 0.3.1).
- **Brief Summary**: one-paragraph description.
- **Governance** (new in 0.3.1): project-level **ethics approval**, **pre-registration**, and **data sharing & FAIR plan**. Distinct from per-dataset governance in `dataset.md`.
- **Keywords**: comma-separated, for indexing.
- **Scientific Context**: biological system (organism, tissue, cell types, developmental stage), **Modalities & Assays** (renamed from `Biological Scale` in 0.3.1; structured as omics layer / assay-platform / sample model), key biological processes.
- **Expected Project Outputs**: primary and secondary outputs.
- **Project Scope**: in-scope and out-of-scope activities.
- **Prior Work & Inspiration**: reference studies, methods to adapt, key papers.

Project types: `exploratory`, `targeted`, `method development`, `package development`, `workflow development`, `workflow application`, `benchmarking`, `shared task`.

Source of truth for the primary repository URL is `project_overview.md → Primary Repository`; `project_resources.md → Repository Location` mirrors it.

## project_resources.md

Singleton. Hardware, HPC/cloud, data storage, version control, environment management, software stack, SOPs.

Project-wide defaults; per-analysis deviations live in `analysis.md → Execution & Reproducibility`.

## intent_overview.md

Singleton index. Lists all intents with a summary table linking to `intents/intent-{n}.md` files.

The summary table includes a `Mode` column (mirrors `intent.md → Mode`) and a `Falsifier set?` column (Yes/No — flags ill-posed intents). Includes an `Overall Intent Strategy` section with an `Open Questions / Candidate Intents` subsection, and a `Intent Sequencing` section for narrative ordering (authoritative edge list lives in `dependencies.md`).

## dataset_overview.md

Singleton index. Lists all datasets with modality/access summary linking to `datasets/dataset-{n}.md`. Includes a data-integration plan and cross-dataset considerations. The `Data Sharing & Publication` section is scoped to cross-dataset reconciliation; per-dataset governance lives in `dataset.md → Governance`.

## analysis_overview.md

Singleton index. Lists analyses by priority (Must Have / Nice to Have / Future Considerations) and a summary table. The summary table has a per-row **Status** column (values: `Planned | In Progress | Blocked | Complete | Deferred`).

The `Execution Order & Artefact Reuse` and `Sequencing Notes` sections (renamed in 0.3.1 from `Analysis Pipeline` / `Cross-Analysis Dependencies`) carry narrative orderings only; the authoritative analysis-to-analysis edge list lives in `dependencies.md`.

## dependencies.md

Singleton. Mermaid `graph LR` of interrelationships between intents, datasets, analyses, and decision records.

- Filename stays `dependencies.md` for backwards compatibility; the H1 is **Project Graph** (renamed in 0.3.1).
- Node prefixes: `D` for datasets, `A` for analyses, `I` for intents, `DR` for decision records (new in 0.3.1).
- Default edge (`-->`) = "is input to / depends on".
- Labelled edges: `produces`, `validates`, `supersedes`, `blocked-by`, `compares-to`. Dotted edges (`-.->`) for decisions gating analyses.
- A `subgraph Legend` block and a `classDef`-based status overlay (keyed to `analysis_overview.md → Status`) are shipped with the template.
- **Derived view**: this file is a derived view of cross-links in the per-component Related Components blocks and the overview summary tables. When in conflict, the per-component blocks win.

## subtemplates/intent.md

Instantiated as `biospec/intents/intent-{n}.md`. Fields:

- **Type** (Question | Aim | Goal)
- **Statement**: the research question/aim/goal text.
- **Mode** (renamed values in 0.3.1): `confirmatory | exploratory | methodological` (was `targeted | exploratory | methods-dev`). Signals downstream tools how to interpret the intent (e.g., critical-mode review applies stricter rigor to `confirmatory`).
- **Priority**: High | Medium | Low.
- **Falsifier** (renamed in 0.3.1 from `Decision rule / what would change our mind`): the objective falsifier — the specific result that would cause the team to abandon, pivot, or escalate. If left blank or filled with "nothing", the intent is not yet well-posed.
- **Framing** (new in 0.3.1): PICO/PECO, expected effect size / minimum detectable effect, prior literature anchors, stakeholders/audience, time horizon / exit criteria, pre-registration link.
- **Associated Hypotheses** (collapsible): repeated `### Hypothesis {h} Details` blocks with Short ID, Statement, Rationale, **Pre-specified** flag (new in 0.3.1), **Direction** flag (new in 0.3.1), Null Hypothesis, Alternative Hypothesis. Skip the block entirely for exploratory or methodological intents.
- **Expected Outcomes** (collapsible): repeated `**Outcome {n}**` blocks with Statement, How measured, How communicated/visualised.
- **Success Criteria**: scientific success (analytic/statistical thresholds belong in `analysis.md → Success Criteria`).
- **Related Components**: relative-path links to datasets and analyses.

## subtemplates/dataset.md

Instantiated as `biospec/datasets/dataset-{n}.md`. Fields:

- **Extended Name**.
- **Dataset-Level Context**: source cohort(s), sample selection logic (cohort-level; per-analysis subsetting belongs in `analysis.md`), access (Public | In-house), citation.
- **Provenance & Identifiers**: **Accession**, **Version**, **DOI / PID** (split in 0.3.1 from a single fused field).
- **Governance**:
  - **License/DUA**.
  - **Ethics/Consent/IRB**: HREC/IRB number and consent type.
  - **Sensitive-data classification**: `Public | Tier 1 de-identified | Tier 2 clinical+genomic | Tier 3 identifiable` (tier descriptors inlined in 0.3.1).
  - **Permitted uses** / **Forbidden uses**: bullet lists.
  - **Embargo / release date** (new in 0.3.1).
  - **Data steward / contact** (new in 0.3.1).
- **Quality status**: one paragraph on QC, exclusions, known issues.
- **Modalities**: one table row + one `### Modality {m}` block per modality. The per-modality block (expanded in 0.3.1) carries: **Modality**, **Format** (split from a single fused field), **Assay platform / chemistry**, **Library prep kit**, **Reference genome + annotation**, **Sequencing depth / coverage target**, **Read length / configuration**, **Multiplexing / pooling**, **Spike-ins / controls**, **Data Location**, **Sample Sheet Location**, **Processing Stage**, **Upstream pipeline / processed-by**, **Supplementary Data Types**, **Additional or Reference Data Required**, **Total size**, **Checksums / manifest**.
- **Sample Information** (collapsible): total samples, batch variables, identifier convention, **Required metadata** + **Availability** (split in 0.3.1), **Data dictionary / codebook**. Heading levels demoted in 0.3.1 so subsections stay inside the `<details>` block.
- **Cohort Characteristics** (collapsible; new in 0.3.1): inclusion criteria, exclusion criteria, recruitment site(s), recruitment period, demographic distribution, missingness profile, follow-up / censoring. Mark N/A for non-cohort datasets (cell lines, public references).
- **Related Components**.

## subtemplates/analysis.md

Instantiated as `biospec/analyses/analysis-{n}.md`. Fields:

- **Description**.
- **Input Data**: primary input, subset/filters, required preprocessing.
- **Priority** and **Priority Rationale**.
- **Analysis Flow**: storyboarded sequence of `### Step {s}` blocks. Each block has What runs / Inputs / Outputs / **Parameters & choices** (renamed in 0.3.1 from `Key choices`). **Repeat the header** per step — do NOT collapse to a table. Material/cross-cutting choices should also be logged in `registers/decisions.md` with a `DR{n}` reference.
- **Execution & Reproducibility**: environment (language + lockfile), random seeds, compute profile + expected wall-time, output location.
- **Expected Outputs**: primary, intermediate, visualisations.
- **Assumptions & Limitations**.
- **Success Criteria**: operational/statistical criteria (scientific success belongs in `intent.md → Success Criteria`).
- **Validation Strategy**:
  - **Controls** — positive/negative controls.
  - **Sanity checks** — quick spot-checks of intermediates.
  - **Information leakage** (renamed in 0.3.1 from `Leakage`) — boundaries that must not be crossed; worked example inlined.
  - **Sensitivity analysis** (renamed in 0.3.1 from `Sensitivity`) — robustness to parameter choices, batches, tools. Distinct from biostatistical sensitivity/specificity.
  - **Multiple testing** — correction method, family, threshold.
  - **Failure modes** — what failure looks like and the fallback plan. Should reference the intent's `Falsifier`.
- **Related Components**.

## subtemplates/decisions.md

Instantiated as `biospec/registers/decisions.md` (one file per project, not one per decision — entries append within the file).

Each entry follows this shape:

- **id**: `DR{n}` (renamed in 0.3.1 from `D{n}` to avoid clashing with Dataset nodes in `dependencies.md`) — monotonically increasing, never reused.
- **date**: `YYYY-MM-DD` — when the decision was made.
- **title** (renamed in 0.3.1 from `topic`): short summary line.
- **status** (new in 0.3.1): `proposed | active | superseded | deferred | reversed`.
- **decision**: the choice made.
- **rationale**: why this choice over the alternatives.
- **alternatives_considered**: the options that were rejected, with brief reasons.
- **scope / affects** (new in 0.3.1): cross-link IDs of affected intents/datasets/analyses.
- **decision_maker(s)** (new in 0.3.1): who approved (PI sign-off for clinical/governance decisions).
- **reversibility** (new in 0.3.1): `one-way door | two-way door`.
- **confidence** (new in 0.3.1): `low | medium | high`.
- **evidence** (new in 0.3.1): references that informed the decision.
- **supersedes** (new in 0.3.1): `DR{m}` this entry replaces.
- **superseded_by** (new in 0.3.1): `DR{m}` that replaces this entry, when status is `superseded`.
- **revisit_when**: the condition that would cause this decision to re-open.

A new `## Related Components` section (new in 0.3.1) brings the register into the cross-link graph.

A `## When to log a decision here` block at the top of the template gives the rule of thumb: log here if the decision affects more than one component, is reversible-but-costly, or someone outside the author needs to find it later. Step-level parameter choices stay inline in `analysis.md`.

## Repeated-block conventions

Some sections use repeated headers to allow multiple instances:

- `### Hypothesis {h} Details` in `intent.md`
- `**Outcome {n}**` in `intent.md`
- `### Modality {m}` in `dataset.md`
- `### Step {s}` in `analysis.md`
- `## Decision {n}` in `decisions.md`

Replace `{h}`, `{n}`, `{m}`, `{s}` with monotonically increasing integers (1, 2, 3…) within the file. Numbers must be unique within their parent block. Repeated `### Step {s}` headers in `analysis.md` are deliberately not a table — editors must preserve the repeated-header format.

## Cross-link conventions

All cross-references between BioSpec files use **relative paths**, never absolute paths (no leading top-level directory prefix). This was true under the old `project` directory layout and remains true under the current `biospec` layout.

From subtemplates (`biospec/intents/intent-1.md`, etc.):
- To another subtemplate: `../datasets/dataset-1.md`, `../analyses/analysis-1.md`.
- To the decisions register: `../registers/decisions.md`.
- To an overview: `../intent_overview.md`, `../dataset_overview.md`, `../analysis_overview.md`.
- To the project graph: `../dependencies.md`.

From overviews (root of `biospec/`):
- To subtemplate instances: `intents/intent-1.md`, `datasets/dataset-1.md`, `analyses/analysis-1.md`.
- To another overview: `intent_overview.md`, etc.

## Source-of-truth precedence

Several concepts naturally appear in more than one file. The following precedence applies — overview/summary copies are *derived* and the subtemplate/canonical copy wins on conflict:

| Concept | Source of truth | Derived view(s) |
|---|---|---|
| Primary repository URL | `project_overview.md → Primary Repository` | `project_resources.md → Repository Location` |
| Project-wide governance (ethics, FAIR, pre-reg) | `project_overview.md → Governance` | — |
| Per-dataset governance | `datasets/dataset-{n}.md → Governance` | `dataset_overview.md → Data Sharing & Publication` (cross-dataset reconciliation only) |
| Per-analysis priority | `analyses/analysis-{n}.md → Priority Level` | `analysis_overview.md → Summary Table` |
| Component relationships (edges) | Per-component `Related Components` blocks + overview summary tables | `dependencies.md` (Project Graph) |
| Intent Falsifier / decision rule | `intents/intent-{n}.md → Falsifier` | summarised as `Falsifier set?` in `intent_overview.md` |
| Per-analysis env / compute | `analysis.md → Execution & Reproducibility` (overrides project defaults) | `project_resources.md` (project-wide defaults) |

## Changes since 0.3.0

Schema bumped to `0.3.1` everywhere.

**Renames (require search-and-replace in existing 0.3.0 biospec files):**

- `intent.md → Mode` values: `targeted | exploratory | methods-dev` → `confirmatory | exploratory | methodological`.
- `intent.md → Decision rule / what would change our mind` → `Falsifier`.
- `analysis.md → Analysis Flow → Step → Key choices` → `Parameters & choices`.
- `analysis.md → Validation Strategy → Leakage` → `Information leakage`.
- `analysis.md → Validation Strategy → Sensitivity` → `Sensitivity analysis`.
- `decisions.md → topic` → `title`.
- `decisions.md → id` prefix `D{n}` → `DR{n}` (avoids collision with Dataset nodes in `dependencies.md`).
- `project_overview.md → Biological Scale` → `Modalities & Assays` (and restructured into three sub-bullets: omics layer / assay-platform / sample model).
- `project_overview.md → Teams involved` → `Teams & Collaborators`.
- `project_overview.md → Methods of interest to Reproduce/Adapt` → `Methods to Adapt`.
- `analysis_overview.md → Analysis Pipeline` → `Execution Order & Artefact Reuse`.
- `analysis_overview.md → Cross-Analysis Dependencies` → `Sequencing Notes`.
- `dependencies.md` H1 `Dependencies` → `Project Graph` (filename unchanged for backwards compatibility).

**Field splits:**

- `dataset.md → Provenance & Identifiers → Version/Accession/DOI` split into `Accession`, `Version`, `DOI / PID`.
- `dataset.md → Modality {m} → Modality and Format` split into `Modality` and `Format`.
- `dataset.md → Sample Information → Required Metadata & Availability` split into `Required metadata` and `Availability`; heading demoted from `##` to `###` to stay inside the `<details>` block.

**New fields and sections:**

- `project_overview.md → Basic Information`: `Funding / Grant`, `Conflict of interest / Disclosures`.
- `project_overview.md → Governance` section (Ethics approval, Pre-registration, Data sharing & FAIR plan).
- `intent.md → Framing` block (PICO/PECO, expected effect size/MDE, prior literature anchors, stakeholders, time horizon, pre-registration link).
- `intent.md → Hypothesis {h} Details`: `Pre-specified` and `Direction` flags.
- `intent_overview.md`: `Mode` and `Falsifier set?` columns; `Overall Intent Strategy` and `Open Questions / Candidate Intents` sections; `Intent Sequencing` section.
- `dataset.md → Governance`: `Embargo / release date`, `Data steward / contact`.
- `dataset.md → Modality {m}`: `Assay platform / chemistry`, `Library prep kit`, `Reference genome + annotation`, `Sequencing depth / coverage target`, `Read length / configuration`, `Multiplexing / pooling`, `Spike-ins / controls`, `Upstream pipeline / processed-by`, `Total size`, `Checksums / manifest`.
- `dataset.md → Sample Information → Data dictionary / codebook`.
- `dataset.md → Cohort Characteristics` collapsible block (Inclusion / Exclusion criteria, Recruitment site(s), Recruitment period, Demographic distribution, Missingness profile, Follow-up / censoring).
- `decisions.md → Decision {n}`: `status`, `scope / affects`, `decision_maker(s)`, `reversibility`, `confidence`, `evidence`, `supersedes`, `superseded_by`.
- `decisions.md → Related Components` section.
- `decisions.md` top-of-file `When to log a decision here` guidance block.
- `dependencies.md` Mermaid template: `DR{n}` (decision record) node prefix; labelled edges (`produces`, `validates`, `supersedes`, `blocked-by`, `compares-to`); dotted edges for decisions gating analyses; `subgraph Legend` block; `classDef` status overlay.

**Drift-precedence comments added (no field removals):**

- `project_overview.md → Primary Repository` declared source of truth; `project_resources.md → Repository Location` references it.
- `project_resources.md → Environment Management` notes per-analysis deviations in `analysis.md` override these defaults.
- `analysis_overview.md → Summary Table` documents column-mapping and ID format.
- `analysis_overview.md → Execution Order` / `Sequencing Notes` declare `dependencies.md` as the authoritative edge list.
- `dataset_overview.md → Data Sharing & Publication` scoped to cross-dataset reconciliation.
- `dependencies.md` declared a derived view of per-component Related Components.

**Other:**

- `Sensitive-data classification` tier definitions inlined in `dataset.md` (previously undefined inline).
- Typos fixed in `project_overview.md`.
- `Citation` field in `dataset.md` clarified to accept BibTeX/DOI/freeform.
