---
name: biospec-templates
description: Use when answering questions about BioSpec template structure, schema field meanings, the difference between overview and subtemplate files, restoring a corrupted template instance, or looking up the current schema version. Reference for the master templates under assets/templates/.
---

# biospec-templates

**THESE MASTERS ARE PRISTINE — NEVER MODIFY `assets/templates/` DIRECTLY. RESTORE BY COPY, NOT EDIT.**

## Core Pattern

1. **Field / structure question** → consult `references/schema.md`; quote the relevant section.
2. **Restoration** → copy the master from `assets/templates/` to the project location. Never edit the master.
3. **"Add a new field" requests** → decline. Master changes require a schema bump; recommend an issue / PR.

Current schema version: **0.3.0**.

## Quick Reference

| Location | Contents |
|---|---|
| `assets/templates/*.md` | Singleton overview masters (project, intents, datasets, analyses, dependencies, resources) |
| `assets/templates/subtemplates/intent.md` | Per-intent master |
| `assets/templates/subtemplates/dataset.md` | Per-dataset master |
| `assets/templates/subtemplates/analysis.md` | Per-analysis master |
| `assets/templates/subtemplates/decisions.md` | Decisions register master |
| `references/schema.md` | Field-by-field schema reference |

## Red Flags

| Excuse | Override |
|---|---|
| "It's just a small tweak to the master." | No. Masters are pristine. Bump schema if a field needs to change. |
| "The user dropped a section — I'll remove it from the master too." | No. Restore from master into the project instance. |
| "I'll add a new field they asked for." | Out of scope. Issue / PR. |
| "I'll collapse the repeated `### Step {s}` headers into a table." | No. The repeated-header format is the schema. |
