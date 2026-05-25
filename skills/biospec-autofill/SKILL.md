---
name: biospec-autofill
description: Use when the user provides external source documents (notes, manuscripts, grant proposals, attached files, repository docs) and asks to populate or fill BioSpec templates. Extracts only high-confidence, cited content. Reserved for source-driven fills — if the user dictates content directly, route to biospec-edit instead.
---

# biospec-autofill

**NEVER INVENT. EVERY NONTRIVIAL FILL MUST CITE A SOURCE PATH AND EXCERPT.**

## Route check

If the user dictated specific content directly and no external source is involved → this is `biospec-edit`. Autofill is for extracting from user-provided sources (attachments, named file paths, or — with explicit consent — a repo scan).

## Core Pattern

1. **Pre-flight.** Confirm `biospec/` exists. Missing singleton overviews → stop, recommend `biospec-setup`.
2. **Scope.** Parse for any scope lock (named cohort, project, component). Apply strictly — ignore other-project content in the same source.
3. **Source resolution**, in order: attached/pasted files → named file paths → repo scan **only with explicit user yes**.
4. **Extract.** Map content to fields. For every nontrivial fill (anything beyond a single proper noun), record source path + short excerpt.
5. **Reference vs implementation.** Method/tool/dataset mentions are *background* unless the project explicitly commits. Background → *Prior Work & Inspiration*. Uncertain → *Option (unconfirmed)*. Only confirmed commitments populate `analyses/`, `datasets/`, `project_resources.md`.
6. **Propose, then apply.** Per-field summary with citations; ask approval; apply on yes; update `last_updated`.
7. **Report.** Path classes scanned and skipped; fields filled and left blank; citation map.

## Scan policy (when the user authorises a repo scan)

**Read**: `README*`, `PROJECT*`, `docs/**`, proposal/grant/manuscript/methods files, `pyproject.toml` / `renv.lock` / `environment.yml` / `requirements.txt`, `Snakefile` / `nextflow.config` / `*.nf` / `*.wdl`, `Dockerfile` / `Singularity`, workflow configs, `.github/ISSUE_TEMPLATE/*`.

**Skip and report**: raw data (`*.fastq*`, `*.bam`, `*.h5*`, `*.zarr`), large binaries, `.env*` and secret/credential files, notebook outputs (parse `.ipynb` cells but ignore `outputs`), `node_modules/`, `__pycache__/`, build artefacts, anything inside an access-controlled clinical/genomic tree.

**Technical-stack inference** from file presence (no content read): extensions → language/runtime; `Snakefile`/`*.nf` → workflow system. Use *only* if the user authorised this inference path.

## Source-filtering kernel (for multi-project sources)

When a source spans multiple projects:

- **Verbatim retention.** Do not paraphrase; include or drop sections wholesale.
- **Deletion only.** Filter by removal, never addition.
- **Conservative.** When in doubt about relevance, keep it.
- **Preserve structure.** Maintain markdown structure; drop empty headers after filtering.

## Common Mistakes

- Inferring methods from prior-work mentions and adding to `analyses/` — that's background.
- Filling `analysis.md` Methods from a `pyproject.toml` — presence ≠ commitment.
- Silently overwriting existing content that conflicts with the source. Append `[From source: <path>]` and flag for the user.
- Filling ambiguous fields. Leave blank.

## Red Flags

| Excuse | Override |
|---|---|
| "It's clearly implied — I don't need a citation." | If nontrivial, cite. Otherwise leave blank. |
| "The README mentions tool X, so I'll add it to resources." | Reference vs implementation. Only commitments. |
| "I'll scan the `.env` file just this once." | No. Skipped path classes are skipped. **Period.** |
| "The user dictated content while attaching a file." | Dictated parts → `biospec-edit`. Only source-extracted parts go through autofill. |
