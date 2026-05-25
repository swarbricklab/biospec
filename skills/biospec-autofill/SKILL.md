---
name: biospec-autofill
description: Use when external sources should populate BioSpec templates from cited evidence: grants, manuscripts, slides, spreadsheets, repository docs/code, attachments. Direct dictation routes to biospec-edit.
---

# biospec-autofill

**NEVER INVENT. DIRECT-FILL ONLY HIGH-CONFIDENCE CITED FACTS; ASK ON CONFLICTS, DELETIONS, OR LOW CONFIDENCE.**

## Route check

User-dictated content with no external source -> `biospec-edit`. Autofill extracts from attachments, named paths, or consented repo scans.

## Core Pattern

1. **Pre-flight.** Confirm `biospec/` exists; read context/templates. Missing overviews -> stop, recommend `biospec-setup`.
2. **User options.** If unclear, ask project areas, not doc names: all likely (default), overview/governance, questions/aims, datasets/cohorts, analyses/workflows, resources. For repo scans, ask depth and allow free-text paths.
3. **Scope and sources.** Parse scope lock; use attachments/pastes -> named paths -> repo scan **only with explicit user yes**.
4. **Orchestrate.** For parsing, inspectors/subagents, fields, and component boundaries, read `references/source-parsing.md` and `references/routing-and-atomicity.md`.
5. **Extract.** Map fields; record path + locator (page/slide/cell/section) + excerpt for nontrivial fills.
6. **Classify evidence.** Use `confirmed commitment`, `observed implementation`, `background/reference`, or `option`. Only the first two populate `analyses/`, `datasets/`, or `project_resources.md`; label observed implementations.
7. **Apply autofill.** Direct-write high-confidence, non-conflicting fills; update `last_updated`; preserve structure. No full diffs/proposals unless asked.
8. **Attribute.** Add/update bottom `## Source Attribution` or Notes map with path + locator + excerpt.
9. **Compact report.** Changed paths + fill counts; path classes scanned/skipped; fields left blank; conflicts or low-confidence candidates needing user input.

## Scan policy (authorised repo scans)

**Read**: `README*`, `PROJECT*`, `docs/**`, proposals/grants/manuscripts/methods, PDF/Office/spreadsheets, manifests/configs, env/lock/container/workflow files, `.github/ISSUE_TEMPLATE/*`.

**Skip/report**: raw data (`*.fastq*`, `*.bam`, `*.h5*`, `*.zarr`), large binaries, `.env*`/secrets, notebook outputs, dependency/cache/build artefacts. In controlled clinical/genomic trees, read named metadata/docs only; redact identifiers.

File-presence inference only with consent: extensions -> language/runtime; `Snakefile`/`*.nf` -> workflow system.

## Multi-project sources

Drop irrelevant source sections wholesale; preserve structure; keep uncertain sections labelled. Field fills may synthesize multiple cited snippets.

## Common Mistakes

- Inferring methods from prior-work mentions and adding to `analyses/` — background.
- Filling `analysis.md` Methods from `pyproject.toml` — presence ≠ commitment.
- Asking users to choose internal doc names. Offer project areas and default to all likely areas.
- Printing full proposed diffs for straightforward autofill. Save tokens; write cited fills and report compactly.
- Silently overwriting existing conflicts. Ask which source wins.
- Losing page/slide/cell provenance after applying edits.

## Red Flags

| Excuse | Override |
|---|---|
| "It's clearly implied — I don't need a citation." | If nontrivial, cite. Otherwise leave blank. |
| "Autofill means I can guess the rest." | No. Autofill means source-driven direct writes, not invention. |
| "The README mentions tool X, so I'll add it to resources." | Reference vs implementation. Only commitments. |
| "I'll scan the `.env` file just this once." | No. Skipped path classes are skipped. |
| "Inspectors can patch the files they inspect." | No. Inspectors gather evidence; the orchestrator writes. |
| "The user dictated content while attaching a file." | Dictated parts → `biospec-edit`. Only source-extracted parts go through autofill. |
