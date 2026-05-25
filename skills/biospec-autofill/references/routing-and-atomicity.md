# Routing and Atomicity Guide

Use this when autofill evidence may map to multiple BioSpec docs, create new components, or require reconciliation across artefacts.

## Collaboration Model

Use an orchestrator for every autofill job. The orchestrator loads BioSpec context, owns precedence/conflict handling, writes final edits, and gives the compact report. For one small source, the main agent can act as both orchestrator and inspector.

For many or messy artefacts, spawn inspectors/subagents when the host supports them. Inspectors are read-only and never edit BioSpec files. Each inspector returns an evidence ledger:

`source path | locator | excerpt | candidate doc/field | evidence class | confidence | existing/new component suggestion | conflicts/privacy notes`

The orchestrator reconciles ledgers, applies precedence, deduplicates entities, then writes high-confidence non-conflicting fills directly. It asks first only for repo scan consent, deletions, conflicting nonblank fields, low-confidence fills, or uncertain component creation. It should not print a full diff unless the user requests one. Inspectors may be split by artefact type (grant, slides, manifests, code) or by source folder.

## User Intake

When the source or fill scope is underspecified, ask one compact intake question before extraction. Use project domains instead of BioSpec filenames:

- **Area default**: all likely areas. Offer opt-in narrowing only if the user wants it: overview/governance, questions/aims, datasets/cohorts, analyses/workflows, resources.
- **Repo scan choices**: no scan; docs/metadata only; docs + configs/workflows; targeted paths from free text; broad scan using the skip policy.
- **Free text**: explicitly invite paths, folders, accessions, proposal sections, or notes the user wants prioritized.

If the user is unsure, keep all likely areas selected and use the narrowest scan that can answer the request. Do not ask them to choose `project_overview.md`, `dataset-{n}.md`, or other internal template names unless they already used those names.

## Write Order

Interpretation order can follow the strongest evidence, but write order should be stable:

1. Global docs: `project_overview.md`, `project_resources.md`.
2. Atomic components: `intents/`, `datasets/`, `analyses/`.
3. Derived indexes: `intent_overview.md`, `dataset_overview.md`, `analysis_overview.md`.
4. `dependencies.md` last, after component links are stable.

Avoid filling overviews first except as a temporary proposal. They should summarize component docs, not diverge from them.

## Routing Matrix

| Source signal | Target | Evidence threshold | Do not fill when |
|---|---|---|---|
| Title, abstract, summary slide | `project_overview.md` summary/title/keywords | Project-scoped, not just related work | It describes a cited prior study only |
| Specific Aim or research question | `intents/intent-{n}.md` | Distinct objective with outcome or decision value | It is only a task list item |
| Hypothesis, endpoint, falsifier | Intent hypothesis, success criteria, decision rule | Explicitly testable or decision-changing | Exploratory wording has no fixed endpoint |
| Cohort table, manifest, sample sheet | `datasets/dataset-{n}.md` | Identifies cohort/source, samples, modality, or file set | It is participant-level raw data to avoid |
| Accession, DOI, version, data availability | Dataset provenance/citation | Identifies data version/source | It is only a paper citation |
| DUA, license, IRB, consent, sharing limits | Dataset governance | Explicit usage or ethics constraint | It is generic institutional boilerplate |
| Workflow, notebook, documented command | `analyses/analysis-{n}.md` flow/reproducibility | Executable or documented analysis step | It is an installed but unused package |
| Lockfile, container, HPC/cloud config | `project_resources.md` or analysis reproducibility | Global environment or analysis-specific run context | Package presence alone implies method use |
| Output path, figure plan, milestone | Analysis outputs or project outputs | Tied to a deliverable | It is aspirational without commitment |
| Prior-work citation or method survey | Prior Work & Inspiration | Background only | It is mistaken for planned implementation |

## Atomicity Rules

**Intent**: create a new intent for a distinct decision-making objective with its own success criteria or decision rule. Edit an existing intent when evidence refines the same objective. A grant "Aim" is not automatically one intent; split only when subquestions could independently cause a pivot, abandonment, or escalation.

**Dataset**: create a new dataset for a distinct source cohort, accession/version, access/governance regime, or modality bundle requiring separate provenance/QC. A derived count matrix, embedding, or filtered file is usually a modality detail or processing stage unless provenance, governance, or QC changes materially.

**Analysis**: create a new analysis for a computational deliverable with its own inputs, outputs, execution path, and validation. Keep inseparable pipeline stages inside one `Analysis Flow`; split when outputs are reused independently, answer different intents, or need different validation/failure-mode review.

When uncertain whether something is new, propose both mappings and ask. Do not create components solely to house weak, background, or option-only evidence.
