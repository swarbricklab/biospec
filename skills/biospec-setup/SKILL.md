---
name: biospec-setup
description: Use when the user asks to initialise BioSpec, scaffold biospec/ templates, set up a project spec, or create the BioSpec directory structure in a repo.
---

# biospec-setup

**NEVER WRITE WITHOUT EXPLICIT USER APPROVAL.**

## Core Pattern

1. **Pre-flight.** Check whether `biospec/` already exists in the repo root. If it contains BioSpec files, **STOP** and warn the user: "biospec/ already exists; overwriting will lose data." Ask for explicit overwrite confirmation or abort.
2. **Plan one bundle.** Create `biospec/`, `biospec/intents/`, `biospec/datasets/`, `biospec/analyses/`, `biospec/registers/`; copy root templates from `assets/templates/`; instantiate only `subtemplates/decisions.md` as `biospec/registers/decisions.md`; stamp `last_updated` with today's runtime date; offer the bootstrap snippet for `AGENTS.md` and/or `CLAUDE.md`; ask whether to git-add + commit.
3. **Use the helper.** Dry-run first: `python3 <this-skill-dir>/scripts/scaffold_biospec.py --repo-root .` plus `--bootstrap AGENTS.md` and/or `--bootstrap CLAUDE.md`. Resolve `<this-skill-dir>` relative to this `SKILL.md`. The helper copies bundled masters and changes only `last_updated`, avoiding Markdown regeneration.
4. **Ask once.** Present the proposal in one bundle. Do not run a wizard.
5. **Apply after approval.** Rerun the helper with `--apply`; add `--overwrite` only if explicitly approved. Commit only if requested. Report changed paths.

## Bootstrap snippet (offer to append to AGENTS.md / CLAUDE.md)

> This repository uses BioSpec. The `biospec/` directory contains the authoritative project specification (intents, datasets, analyses, dependencies, project overview, resources, and a decisions register). Before planning, editing, or reviewing scientific content, read the relevant BioSpec files. Use the BioSpec skills for any writes: `biospec-setup`, `biospec-autofill`, `biospec-edit`, `biospec-review`, `biospec-sync`. Never invent data, methods, or hypotheses; never delete files without explicit confirmation.

## Quick Reference

Root templates: `project_overview.md`, `project_resources.md`, `intent_overview.md`, `dataset_overview.md`, `analysis_overview.md`, `dependencies.md`.

Decisions register: copy `subtemplates/decisions.md` to `registers/decisions.md`.

Do **not** copy intent/dataset/analysis subtemplates at setup time; `biospec-edit` / `biospec-autofill` instantiate them per component.

## Common Mistakes

- Copying the `subtemplates/` directory wholesale into `biospec/`. Do not — only `decisions.md` is instantiated at setup time.
- Hard-coding a date in `last_updated`. Read today's date from the runtime and substitute per file.
- Rewriting template Markdown by hand. Use `scripts/scaffold_biospec.py` when available; it copies masters and changes only `last_updated`.
- Running a multi-step wizard. One proposal, one confirmation.
- Adding a "set initial version to 0.1" line to the commit message. The schema_version is baked into each template's frontmatter; don't add a project-version concept that BioSpec doesn't have.

## Red Flags

| Excuse | Override |
|---|---|
| "biospec/ already exists but the user clearly wants it overwritten." | Ask anyway. Single confirmation is cheap; lost data isn't. |
| "I'll skip the bootstrap snippet — they'll figure it out." | Offer it. Default yes. State that declining is fine. |
| "I'll commit the scaffold without asking." | No. Git is opt-in. Present the commit as part of the bundle. |
