---
name: using-biospec
description: Use when planning, editing, or reviewing in a repository that contains a biospec/ directory, or when the user mentions BioSpec, intents, datasets, analyses, or "the project spec". Loads invariant rules for BioSpec specs — read context before writes, propose-first, no invention, scope lock. Cross-references biospec-setup, biospec-edit, biospec-autofill, biospec-review, biospec-sync, biospec-templates.
---

# using-biospec

**READ BIOSPEC CONTEXT BEFORE PLANNING, EDITING, OR REVIEWING ANYTHING IN `biospec/`.**

## Core Rules

1. Read `biospec/project_overview.md` + `biospec/project_resources.md`, then the **named subtemplate** the user is asking about, plus one-hop dependencies. *Why: the named-subtemplate field is where the decision rules live.*
2. **Truth & precedence**: user's current message > attachments > existing BioSpec docs > repo scan. Conflicts → flag and ask. Never silently merge.
3. **Scope lock**: if the user names a cohort / intent / dataset / analysis, ignore everything else until they widen the scope.
4. **Reference vs implementation**: tool/method mentions in source documents are background unless the project explicitly commits. Background goes in *Prior Work*; uncommitted candidates are *Option (unconfirmed)*.
5. For writes, route to the verb-skills (`biospec-setup`, `biospec-edit`, `biospec-autofill`, `biospec-review`, `biospec-sync`). Each carries its own Iron Law — do not assume this skill was loaded.

## Red Flags

| Excuse | Override |
|---|---|
| "No biospec marker — I can skip context loading." | If `biospec/` exists, load context. **No exceptions.** |
| "The project overview is enough." | No — read the named subtemplate plus one-hop dependencies. |
| "I'll merge the conflicting sources." | Flag the conflict. Ask. Do not silently merge. |
