---
name: biospec-autofill
description: Use when external sources (grants, manuscripts, slides, spreadsheets, repository docs/code, attachments) should populate BioSpec templates from cited evidence. Source-driven only; direct dictation routes to biospec-edit.
---

# biospec-autofill

**NEVER INVENT. EVERY NONTRIVIAL FILL MUST CITE A SOURCE PATH AND EXCERPT.**

## Route check

If the user dictated content directly and no external source is involved -> `biospec-edit`. Autofill extracts from attachments, named paths, or repo scans with explicit consent.

## Core Pattern

1. **Pre-flight.** Confirm `biospec/` exists; read current BioSpec context and target template(s). Missing singleton overviews -> stop, recommend `biospec-setup`.
2. **Scope.** Parse any scope lock (cohort, project, component) and ignore unrelated source content.
3. **Resolve sources.** Use attached/pasted files -> named file paths -> repo scan **only with explicit user yes**.
4. **Triage and route.** For artifact parsing, target fields, orchestration, and new-vs-existing components, read `references/source-parsing.md` and `references/routing-and-atomicity.md`.
5. **Extract.** Map to fields. For every nontrivial fill, record source path + locator (page/slide/cell/section) + short excerpt.
6. **Classify evidence.** Use `confirmed commitment`, `observed implementation`, `background/reference`, or `option (unconfirmed)`. Only the first two may populate `analyses/`, `datasets/`, or `project_resources.md`; label observed implementation.
7. **Propose, then apply.** Summarise per-field fills with citations; ask approval; apply on yes; update `last_updated`; preserve provenance inline or in Notes/citation map.
8. **Report.** Path classes scanned/skipped; fields filled/blank; citation map.

## Scan policy (when the user authorises a repo scan)

**Read**: `README*`, `PROJECT*`, `docs/**`, proposal/grant/manuscript/methods, PDF/Office/spreadsheet/manifest/config files, env/lock/container files, workflow files, `.github/ISSUE_TEMPLATE/*`.

**Skip and report**: raw data (`*.fastq*`, `*.bam`, `*.h5*`, `*.zarr`), large binaries, `.env*` and secrets, notebook outputs, dependency/cache/build artefacts. For access-controlled clinical/genomic trees, do not bulk-scan; read only explicitly named metadata/docs, avoid raw participant tables, redact identifiers in excerpts.

**Technical-stack inference** from file presence (no content read): extensions -> language/runtime; `Snakefile`/`*.nf` -> workflow system. Use *only* if the user authorised this inference path.

## Source-filtering kernel (for multi-project sources)

When a source spans multiple projects:

- **Build scoped evidence by deletion.** Include or drop source sections wholesale; preserve structure and drop empty headers.
- **Conservative.** When in doubt about relevance, keep the source section but mark uncertainty.
- **Extraction may synthesize.** BioSpec fields may combine multiple cited snippets; cite each one.

## Common Mistakes

- Inferring methods from prior-work mentions and adding to `analyses/` — that's background.
- Filling `analysis.md` Methods from a `pyproject.toml` — presence ≠ commitment.
- Silently overwriting existing conflicts. Append `[From source: <path>]` and flag.
- Filling ambiguous fields. Leave blank.
- Losing page/slide/cell provenance after applying edits.

## Red Flags

| Excuse | Override |
|---|---|
| "It's clearly implied — I don't need a citation." | If nontrivial, cite. Otherwise leave blank. |
| "The README mentions tool X, so I'll add it to resources." | Reference vs implementation. Only commitments. |
| "I'll scan the `.env` file just this once." | No. Skipped path classes are skipped. **Period.** |
| "The user dictated content while attaching a file." | Dictated parts → `biospec-edit`. Only source-extracted parts go through autofill. |
