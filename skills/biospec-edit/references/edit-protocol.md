# biospec-edit · supplementary protocols

## Contents
- [Component deletion protocol](#component-deletion-protocol)
- [Ambiguity handling](#ambiguity-handling)
- [Placement-decision examples](#placement-decision-examples)

## Component deletion protocol

Triggered when the user asks to **remove**, **delete**, or **drop** a component (intent, dataset, analysis, or decision entry).

1. **Identify the target file.** Map "intent 2", "the RNA-seq dataset", etc. to a concrete path under `biospec/`. Verify it exists.
2. **Identify references.** Scan every file in `biospec/` for cross-references to the target:
   - Overview files (`intent_overview.md`, `dataset_overview.md`, `analysis_overview.md`) for table rows and link lists.
   - Other component files for "Related Components" links.
   - `dependencies.md` for diagram nodes and edges.
   - `registers/decisions.md` for any decision that referenced the target.
3. **Formulate the deletion plan.**
   - File to delete (the target).
   - Files to edit (each one with the specific line / row / mermaid node that must come out).
4. **Present the plan and warn.** Exactly this shape:

   > This will permanently delete `biospec/<target>`. The following files will also be edited to remove references: `<list>`. Ensure you have a backup or version-control commit before proceeding. Are you sure?

5. **Wait for explicit "yes" or equivalent.** Anything ambiguous → ask again.
6. **Apply.** Delete the target, edit each referencing file, regenerate the dependency diagram if the deletion changed graph structure.
7. **Report.** Summarise what was deleted and what was updated. Recommend a git commit.

**Never** delete without the explicit confirmation step. The warning text matters — quote-it-verbatim text isn't optional.

## Ambiguity handling

When the user's instruction is unclear or partially contradictory, **do not edit**. Pick the right tactic:

- **Conflict between sources.** "Your message says X but `intent-1.md` says Y." Ask which wins; do not silently merge.
- **Vague field reference.** "Update the success criteria" — ask which file, or which criterion, before drafting.
- **Multiple plausible interpretations of the new content.** Offer 2–3 candidate phrasings with different assumptions clearly labelled, then ask which is closest. Do not pick one and present a single proposal — that hides the ambiguity.
- **Better-fit target.** If the content really belongs in a different file (e.g. analysis parameters arriving via an intent ask), say so explicitly in the proposal and offer to edit the better-fit file instead or in addition.

## Placement-decision examples

Heuristics for when the user's request looks like it belongs in a different file than they named.

| User says | Intended target | Better fit | Action |
|---|---|---|---|
| "Add to intent-1: we'll use Harmony for batch correction at resolution 0.6." | `intent-1.md` | `analysis-1.md` Analysis Flow → Step | Propose edit to `analysis-1.md`; note that the intent is the *why*, the analysis is the *how*. |
| "Update the dataset to say we lost 4 samples to QC." | `dataset-1.md` | `dataset-1.md` → *Quality status* | Edit the Quality status field, not a free-text Notes append. |
| "Note that we picked Seurat over Bioconductor — they were too slow." | "Notes" anywhere | `registers/decisions.md` | Propose a Decisions register entry; offer to also add a one-line link from `project_resources.md`. |
| "Add this dataset to intent-1 as a primary source." | `intent-1.md` Related Components | `intent-1.md` + `dataset-N.md` Related Components | Edit both for bidirectional consistency. |
