# Source Parsing Guide

Use this when autofill sources include grants, manuscripts, slide decks, spreadsheets, office/PDF documents, or a pre-existing research codebase. Prefer structured parsers over ad hoc text extraction when available, and keep citations precise enough for a human to find the evidence again.

## Artifact Triage

**Grants and proposals**: Inspect title/abstract, Specific Aims, Research Strategy/Approach, milestones/timeline, expected outcomes, Human Subjects, data sharing, authentication/resource sharing, facilities/resources, budget justification, biosketch roles, references, and appendices. Map aims to intents; hypotheses and endpoints to intent hypotheses/success criteria; milestones and deliverables to outputs; Human Subjects/Data Sharing to dataset governance; facilities/budget to project resources. Treat cited methods and preliminary data as background unless the proposal explicitly commits to using them.

**Manuscripts and protocols**: Inspect abstract, methods, cohort/table 1, figure captions, supplementary tables, data/code availability, ethics statement, and limitations. Cohort tables often contain sample counts, inclusion/exclusion criteria, batches, modalities, accessions, and QC exclusions. Data/code availability often contains provenance, repository URLs, licenses, and workflow commitments.

**Slides and posters**: Inspect slide titles, section dividers, speaker notes, figure captions, axis labels, tables, cohort diagrams, legends, appendix/backup slides, comments, and alt text when accessible. One slide may carry only fragments: combine cited title + caption + table cells when filling a field. Use slide numbers and, for tables, row/column labels in citations.

**Spreadsheets and manifests**: Inspect sheet names, headers, data dictionaries, comments, named ranges, hidden sheets if accessible, and summary tabs before row-level data. Good signals include sample IDs, modality, assay, processing stage, consent/DUA flags, batch variables, excluded samples, file paths, and identifier conventions. Avoid copying participant-level rows into excerpts; cite header plus aggregate or redacted examples.

**Codebases**: Inspect README/docs first, then workflow files, configs, notebooks without outputs, scripts/entrypoints, tests, lockfiles, containers, sample sheets, and output path conventions. Stronger evidence comes from runnable workflows, active configs, tests, and documented commands; weaker evidence comes from installed packages or unused imports. Map workflow steps to `analysis.md` Analysis Flow only when the file shows an executable or documented step.

## Field Signals

- `project_overview.md`: title/abstract, aims, summary slides, keywords, biological system, outputs, scope, prior work.
- `project_resources.md`: facilities/resources, budget justification, Docker/Singularity, lockfiles, HPC configs, storage/SOP docs.
- `intent*.md`: specific aims, research questions, hypotheses, endpoints, success thresholds, decision/falsifier language.
- `dataset*.md`: cohort tables, manifests, sample sheets, accessions, DUA/license, IRB/ethics, consent, QC, modalities.
- `analysis*.md`: approach/methods, workflow configs, notebooks, scripts, tests, expected outputs, validation and sensitivity plans.

## Evidence Handling

Classify each candidate fill as `confirmed commitment`, `observed implementation`, `background/reference`, or `option (unconfirmed)`. Do not upgrade evidence because it is plausible. If source documents conflict, flag the conflict and prefer the user's current message over attachments, existing BioSpec docs, and repo scan in that order.
