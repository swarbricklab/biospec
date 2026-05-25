---
name: biospec-setup
description: Use when the user asks to initialise BioSpec, scaffold biospec/ templates, set up a project spec, or create the BioSpec directory structure in a repo. Creates biospec/{intents,datasets,analyses,registers}/ from masters, stamps today's date, and offers a portable bootstrap snippet for AGENTS.md / CLAUDE.md. One confirmation before writing anything.
---

# biospec-setup

**NEVER WRITE WITHOUT EXPLICIT USER APPROVAL.**

## Core Pattern

1. **Pre-flight.** Check whether `biospec/` already exists in the repo root. If it contains BioSpec files, **STOP** and warn the user: "biospec/ already exists; overwriting will lose data." Ask for explicit overwrite confirmation or abort.
2. **Plan the change set.** Assemble the proposal as a single bundle:
   - Directories to create: `biospec/`, `biospec/intents/`, `biospec/datasets/`, `biospec/analyses/`, `biospec/registers/`.
   - Files to copy from `assets/templates/` to `biospec/`: `project_overview.md`, `project_resources.md`, `intent_overview.md`, `dataset_overview.md`, `analysis_overview.md`, `dependencies.md`. **Do NOT copy `subtemplates/`** — those are instantiated per-component by `biospec-edit` / `biospec-autofill`.
   - One file to instantiate: `biospec/registers/decisions.md` from `assets/templates/subtemplates/decisions.md`.
   - Frontmatter: set `last_updated` to today's date in every copied file (read today's date from the runtime; do not hardcode).
   - Whether to append the bootstrap snippet (below) to `AGENTS.md` and/or `CLAUDE.md`.
   - Whether to git-add + commit the scaffolding.
3. **Present the proposal in one bundle and ask one confirmation.** Do not run a multi-step wizard. The user replies once with which parts to apply.
4. **Apply.** Create dirs, copy files, set `last_updated`, append snippet, commit (if requested). Report what changed.

## Bootstrap snippet (offer to append to AGENTS.md / CLAUDE.md)

> This repository uses BioSpec. The `biospec/` directory contains the authoritative project specification (intents, datasets, analyses, dependencies, project overview, resources, and a decisions register). Before planning, editing, or reviewing scientific content, read the relevant BioSpec files. Use the BioSpec skills for any writes: `biospec-setup`, `biospec-autofill`, `biospec-edit`, `biospec-review`, `biospec-sync`. Never invent data, methods, or hypotheses; never delete files without explicit confirmation.

## Quick Reference

| Source (assets/templates/) | Destination (biospec/) |
|---|---|
| `project_overview.md` | `project_overview.md` |
| `project_resources.md` | `project_resources.md` |
| `intent_overview.md` | `intent_overview.md` |
| `dataset_overview.md` | `dataset_overview.md` |
| `analysis_overview.md` | `analysis_overview.md` |
| `dependencies.md` | `dependencies.md` |
| `subtemplates/decisions.md` | `registers/decisions.md` |
| (intent/dataset/analysis subtemplates) | not copied — instantiated by autofill/edit |

## Common Mistakes

- Copying the `subtemplates/` directory wholesale into `biospec/`. Do not — only `decisions.md` is instantiated at setup time.
- Hard-coding a date in `last_updated`. Read today's date from the runtime and substitute per file.
- Running a multi-step wizard. One proposal, one confirmation.
- Adding a "set initial version to 0.1" line to the commit message. The schema_version is baked into each template's frontmatter; don't add a project-version concept that BioSpec doesn't have.

## Red Flags

| Excuse | Override |
|---|---|
| "biospec/ already exists but the user clearly wants it overwritten." | Ask anyway. Single confirmation is cheap; lost data isn't. |
| "I'll skip the bootstrap snippet — they'll figure it out." | Offer it. Default yes. State that declining is fine. |
| "I'll commit the scaffold without asking." | No. Git is opt-in. Present the commit as part of the bundle. |
