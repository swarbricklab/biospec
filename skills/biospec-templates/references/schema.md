# BioSpec schema reference (v0.3.0)

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
- [Changes since 0.2.0](#changes-since-020)

## Frontmatter (all templates)

Every template begins with a YAML block. The required fields are:

- `template_name`: human-readable name (do not edit when instantiating).
- `schema_version`: pinned to the BioSpec release that defines the field set.
- `last_updated`: ISO-8601 date (`YYYY-MM-DD`) when the file was last meaningfully changed.

Subtemplates add an `_id` field (`intent_id`, `dataset_id`, `analysis_id`). Intent subtemplates also add `intent_type` (one of `question | aim | goal`).

## project_overview.md

Singleton. One per project.

- **Basic Information**: project title, type, start date, expected duration, PI, teams, primary repository URL.
- **Brief Summary**: one-paragraph description.
- **Keywords**: comma-separated, for indexing.
- **Scientific Context**: biological system (organism, tissue, cell types, developmental stage), biological scale, key biological processes.
- **Expected Project Outputs**: primary and secondary outputs.
- **Project Scope**: in-scope and out-of-scope activities.
- **Prior Work & Inspiration**: reference studies, methods of interest, key papers.

Project types: `exploratory`, `targeted`, `method development`, `package development`, `workflow development`, `workflow application`, `benchmarking`, `shared task`.

## project_resources.md

Singleton. Hardware, HPC/cloud, data storage, version control, environment management, software stack, SOPs.

## intent_overview.md

Singleton index. Lists all intents with a summary table linking to `intents/intent-{n}.md` files.

## dataset_overview.md

Singleton index. Lists all datasets with modality/access summary linking to `datasets/dataset-{n}.md`. Includes a data-integration plan and cross-dataset considerations.

## analysis_overview.md

Singleton index. Lists analyses by priority (Must Have / Nice to Have / Future Considerations) and a summary table. The summary table has a per-row **Status** column (values: `Planned | In Progress | Blocked | Complete | Deferred`) — this is a planning artefact and is distinct from the dropped `status.md` workflow.

## dependencies.md

Singleton. Mermaid `graph LR` of interrelationships between intents, datasets, analyses. Node prefixes: `D` for datasets, `A` for analyses, `I` for intents. Edge directionality: Dataset → Analysis, Analysis → Intent, Analysis → Analysis (sequential dependency).

## subtemplates/intent.md

Instantiated as `biospec/intents/intent-{n}.md`. Fields:

- **Type** (Question | Aim | Goal)
- **Statement**: the research question/aim/goal text.
- **Mode** (new in 0.3.0): `targeted | exploratory | methods-dev`. Signals downstream tools how to interpret the intent (e.g., critical-mode review applies stricter rigor to `targeted`).
- **Priority**: High | Medium | Low.
- **Decision rule / what would change our mind** (new in 0.3.0): the objective falsifier — the specific result that would cause the team to abandon, pivot, or escalate. If left blank or filled with "nothing", the intent is not yet well-posed.
- **Associated Hypotheses** (collapsible): repeated `### Hypothesis {h} Details` blocks with Short ID, Statement, Rationale, Null Hypothesis, Alternative Hypothesis. Skip the block entirely for exploratory or methods-dev intents.
- **Expected Outcomes** (collapsible): repeated `**Outcome {n}**` blocks with Statement, How measured, How communicated/visualised.
- **Success Criteria**.
- **Related Components**: relative-path links to datasets and analyses.

## subtemplates/dataset.md

Instantiated as `biospec/datasets/dataset-{n}.md`. Fields:

- **Extended Name**.
- **Dataset-Level Context**: source cohort(s), sample selection logic, access (Public | In-house), citation.
- **Provenance & Identifiers** (new in 0.3.0): version/accession/DOI. Examples: `GEO: GSE123456`, `EGA: EGAD00001000000`, `Internal v1.0`, `10.5281/zenodo.000000`.
- **Governance** (new in 0.3.0):
  - **License/DUA**: licence or data use agreement reference.
  - **Ethics/Consent/IRB**: HREC/IRB number and consent type.
  - **Sensitive-data classification**: `Public | Tier 1 de-identified | Tier 2 clinical+genomic | Tier 3 identifiable`.
  - **Permitted uses**: bullet list.
  - **Forbidden uses**: bullet list (e.g. re-identification, commercial redistribution).
- **Quality status** (new in 0.3.0): one paragraph on QC, exclusions, known issues.
- **Modalities**: one table row + one `### Modality {m}` block per modality. Format, location, sample-sheet path, processing stage.
- **Sample Information** (collapsible): total samples, batch variables, identifier convention, required metadata.
- **Related Components**.

## subtemplates/analysis.md

Instantiated as `biospec/analyses/analysis-{n}.md`. Fields:

- **Description**.
- **Input Data**: primary input, subset/filters, required preprocessing.
- **Priority** and **Priority Rationale**.
- **Analysis Flow** (new in 0.3.0): storyboarded sequence of `### Step {s}` blocks. Each block has What runs / Inputs / Outputs / Key choices. **Repeat the header** per step — do NOT collapse to a table. The repeated-header format is the schema and is what allows per-step review and inline commenting.
- **Execution & Reproducibility** (new in 0.3.0): environment (language + lockfile), random seeds, compute profile + expected wall-time, output location.
- **Expected Outputs**: primary, intermediate, visualisations.
- **Assumptions & Limitations**.
- **Success Criteria**.
- **Validation Strategy** (split in 0.3.0):
  - **Controls** — positive/negative controls.
  - **Sanity checks** — quick spot-checks of intermediates.
  - **Leakage** — boundaries that must not be crossed.
  - **Sensitivity** — robustness to parameter choices, batches, tools.
  - **Multiple testing** — correction method, family, threshold.
  - **Failure modes** — what failure looks like and the fallback plan. Should reference the intent's decision rule.
- **Related Components**.

## subtemplates/decisions.md

New in 0.3.0. Instantiated as `biospec/registers/decisions.md` (one file per project, not one per decision — entries append within the file).

Each entry follows this shape:

- **id**: `D{n}` — monotonically increasing, never reused.
- **date**: `YYYY-MM-DD` — when the decision was made.
- **topic**: short topic line.
- **decision**: the choice made.
- **rationale**: why this choice over the alternatives.
- **alternatives_considered**: the options that were rejected, with brief reasons.
- **revisit_when**: the condition that would cause this decision to re-open.

Superseded decisions should be marked superseded and reference the new entry's `id`. Do not edit historic entries in place.

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
- To an overview: `../intent_overview.md`, `../dataset_overview.md`, `../analysis_overview.md`.
- To the dependency map: `../dependencies.md`.

From overviews (root of `biospec/`):
- To subtemplate instances: `intents/intent-1.md`, `datasets/dataset-1.md`, `analyses/analysis-1.md`.
- To another overview: `intent_overview.md`, etc.

## Changes since 0.2.0

- **Added** `intent.md` fields: `Mode`, `Decision rule / what would change our mind`.
- **Added** `dataset.md` blocks: `Provenance & Identifiers`, `Governance`, `Quality status`.
- **Replaced** `analysis.md` "Methods & Tools" with the storyboarded `Analysis Flow` (repeated `### Step {s}` blocks).
- **Added** `analysis.md` block: `Execution & Reproducibility`.
- **Split** `analysis.md` "Validation Strategy" into Controls / Sanity checks / Leakage / Sensitivity / Multiple testing / Failure modes.
- **Added** `subtemplates/decisions.md`.
- **Removed** `status.md` and the per-template Status nav link. The `biospec.status` workflow is dropped; the `Status` column inside `analysis_overview.md`'s summary table is unaffected.
- **Bumped** `schema_version` to `0.3.0` everywhere.
