---
name: biospec-review
description: Use when the user asks to discuss, review, critique, brainstorm, weigh trade-offs, or stress-test BioSpec docs ("review intent-1", "are the success criteria specific enough?", "what other clustering methods are worth considering?", "is this hypothesis testable?"). Read-only — never writes. Routes to Exploratory or Critical mode based on phrasing; states the assumed mode in one sentence when ambiguous.
---

# biospec-review

**NEVER WRITE TO BIOSPEC FILES. IF THE USER ASKS FOR AN EDIT, ROUTE TO `biospec-edit`.**

## Mode selection

State the assumed mode in one sentence at the top of your reply when ambiguous.

- **Critical** — phrasing like *review*, *critique*, *check*, *is this rigorous*, *poke holes*, *stress-test*. Load `references/scientific-rigor.md` for the design checklist.
- **Exploratory** — phrasing like *discuss*, *brainstorm*, *what else could*, *what other options*, *help me think through*. Look for possibilities, not flaws. Generate options with trade-offs.

Explicit signals ("be critical", "brainstorm with me") override phrasing inference.

## Core Pattern

1. **Identify scope.** Which file(s) / fields are in scope? If vague, ask — do not interpret "review my project" as "read everything in `biospec/`".
2. **Read the relevant set**, not the universe:
   - `biospec/project_overview.md`
   - `biospec/project_resources.md`
   - `biospec/dependencies.md`
   - The named subtemplate(s) plus one-hop dependencies (linked datasets/analyses).
   - Relevant `registers/decisions.md` entries.
3. **Apply truth & precedence**: attachments and the user's current message can override what's in `biospec/`. Conflicts → flag and ask; never silently take one side.
4. **Respond.** Critical mode → structured critique (Observation / Issue / Why it matters / Alternatives / Question). Exploratory mode → options + trade-offs, Socratic follow-ups.
5. **Close.** If actionable changes emerged, name them and recommend `biospec-edit` (do not draft the edit yourself).

## Read-set escalation

If the user explicitly asks for a project-wide review ("review my project end to end"), escalate to reading every file under `biospec/`. State the expanded read-set in one sentence before responding.

## Critical-mode output template (use literally)

```
Mode: Critical (assumed from phrasing — say if you want Exploratory instead).

## Major Concerns
**Observation**: <quote or specific reference>
**Issue**: <the scientific or practical flaw>
**Why it matters**: <the consequence>
**Alternatives & Suggestions**: <concrete alternatives, pros/cons>
**Question/Prompt**: <a question that forces the user to resolve it>

## Minor Clarifications
...

## Missing Information
...
```

## Exploratory-mode shape

Conversational, options-first. Use *"Have you considered…"* / *"Another angle…"*. Surface trade-offs explicitly. Avoid correctness words (*right*, *fix*, *improve*). Do not produce one "best" answer — surface 2–3 paths.

## Common Mistakes

- Drafting an edit in either mode. If you have a rewrite in mind, recommend `biospec-edit` and let it draft.
- Reading every file in `biospec/` for a single-field critique. Use the named subtree + one-hop dependencies.
- Praising defensively in Critical mode. Be direct. Avoid softening every concern.
- Generating critique in Exploratory mode (the user wanted options, not flaws).

## Red Flags

| Excuse | Override |
|---|---|
| "The user said discuss but I see real issues — I'll critique." | Stay in Exploratory. Mention concerns as *trade-offs*, not flaws. If you'd rather critique, say so and ask to switch modes. |
| "I'll fix the wording for them." | No writes. Recommend `biospec-edit`. |
| "I'll skip stating my assumed mode." | State it. One sentence. **No exceptions.** |
| "I'll read every file just to be safe." | No — named subtree + one-hop. Escalate only when the user asks for a project-wide review. |
