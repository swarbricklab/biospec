---
name: biospec-edit
description: Use when the user dictates specific changes to BioSpec docs ("update intent-1 to say…", "remove dataset-2", "change the success criteria"). Proposes a Before/After diff and applies only on explicit approval. Reserved for user-dictated content; if the user attaches external sources (notes, manuscripts, proposals) and asks to populate fields, route to biospec-autofill instead.
---

# biospec-edit

**NEVER APPLY EDITS BEFORE PRESENTING A BEFORE/AFTER PROPOSAL AND RECEIVING APPROVAL.**

## Route check (run before reading further)

If the user provided an external source (file, attachment, URL, large paste) **and** asked for content extracted from it → this is autofill, not edit. Route to `biospec-autofill`. Edit is reserved for content the user dictates directly.

## Core Pattern

1. **Locate the target.** Map "project overview", "intent 1", "dataset 2", etc. to a concrete file under `biospec/`. If ambiguous, ask — never guess.
2. **Verify suitability.** Check the requested field belongs in the target. If the content fits a different file better, flag it in the proposal and offer to edit the better-fit file instead or in addition.
3. **Scope lock.** If the user named one component, stay within it. Cross-component cascades require an explicit widen.
4. **Draft.** Pick update type: refine/rewrite, extend, or re-organise (no meaning change). Preserve structure, headings, `<details>` blocks, repeated `### Step {s}` headers, and `<!-- guidance -->` comments.
5. **Propose.** Before/After diff per field, plus the reasoning. Then ask: "Shall I apply these changes? (Yes / No / Request changes)". Do not edit yet.
6. **Apply on approval.** Use file-edit tools. Update `last_updated` to today's date in every touched file.
7. **Post-edit.** Summarise what changed and remind the user to review / git-commit.

For deletions, ambiguity handling, and placement-decision examples, see `references/edit-protocol.md`.

## Common Mistakes

- Skipping the Before/After because the change "feels obvious".
- Collapsing repeated `### Step {s}` blocks in `analysis.md` into a table during a reorganisation. Don't — the repeated-header format is the schema.
- Dropping `<!-- guidance -->` comments to "tidy up". Preserve unless explicitly replacing the placeholder.
- Cascading edits into the overview file when the user only asked to edit one component. Stay within scope; mention overview consistency separately.
- Editing the masters under `skills/biospec-templates/assets/templates/`. Out of scope; those are pristine.

## Red Flags

| Excuse | Override |
|---|---|
| "The user clearly wants this — propose is overkill." | Propose first. **No exceptions.** |
| "It's just a typo, I can skip the diff." | Show the diff. Even typos. |
| "I'll delete the file; the user said remove." | Stop. Open `references/edit-protocol.md` and run the deletion protocol. |
| "The user attached notes; I'll extract content while editing." | That's autofill, not edit. Route to `biospec-autofill`. |
| "I'll improve the wording in adjacent fields while I'm here." | Stay in scope. Mention them in your summary; do not edit. |
