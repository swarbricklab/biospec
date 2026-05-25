---
name: using-biospec
description: Use when planning, editing, or reviewing in a repository with biospec/ or when the user mentions BioSpec, intents, datasets, analyses, or "the project spec". Loads BioSpec invariants: context first, no invention, scope lock, source precedence, and verb-skill routing.
---

# using-biospec

**READ BIOSPEC CONTEXT BEFORE PLANNING, EDITING, OR REVIEWING ANYTHING IN `biospec/`.**

## Core Rules

1. Read `biospec/project_overview.md` + `biospec/project_resources.md`, named subtemplate, and one-hop dependencies.
2. **Truth & precedence**: user's current message > attachments > existing BioSpec docs > repo scan. Conflicts -> flag and ask.
3. **Scope lock**: if the user names a cohort, intent, dataset, or analysis, ignore unrelated components.
4. **Reference vs implementation**: source mentions of tools/methods are background unless the project commits.
5. Route writes to verb-skills. `biospec-autofill` direct-fills cited facts; `biospec-edit`, `biospec-sync`, and setup confirmations use approval-first writes. Each carries its own Iron Law.

## Red Flags

| Excuse | Override |
|---|---|
| "No biospec marker — I can skip context." | If `biospec/` exists, load context. **No exceptions.** |
| "The overview is enough." | Read the named subtemplate plus dependencies. |
| "I'll merge the conflicting sources." | Flag the conflict. Ask. Do not silently merge. |
