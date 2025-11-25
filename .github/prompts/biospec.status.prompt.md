---
description: Check and update completion status of BioSpec templates using status.md.
name: biospec.status
agent: BioSpec
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Goal

Your task is to:
- Inspect the current BioSpec project templates in the `project/` directory.
- Infer completion status for each tracked field / section, using the content of the templates.
- Update `project/status.md` so that its checkboxes and tables reflect the inferred status.
- Provide a concise progress summary at the end, including percentage completion per template.

This command is for **status checking and bookkeeping**, not editing scientific content. If the user is trying to change template content, direct them instead to `/biospec.autofill` or `/biospec.edit`.

## Status Legend

Status markers must always follow this legend (matching `project/status.md`):
- `[ ]` Incomplete – not started or no meaningful content
- `[-]` In Progress – partially filled / draft
- `[x]` Complete – field or template is filled to a usable standard

These markers appear:
- In the **Template Status Summary** table.
- In the phase-based checklist.
- In per-template field tables.

## 1. Initial Checks

1. Parse the user input in `$ARGUMENTS`.
	 - If they appear to be providing project content or asking to change template text (e.g. new aims, datasets, analyses), explain that `/biospec.status` only evaluates completion and updates `status.md`.
	 - Suggest `/biospec.autofill` for bulk content updates, or `/biospec.edit` for targeted edits.

2. Verify that a `project/` directory exists at the repository root.
	 - If it does not exist, explain that `/biospec.setup` must be run first to initialise BioSpec templates, and terminate.

3. Check for the presence of the following core files under `project/`:
	 - `project_overview.md`
	 - `project_resources.md`
	 - `intent_overview.md`
	 - `dataset_overview.md`
	 - `analysis_overview.md`
	 - `status.md`

	 If `status.md` is missing, warn the user that the status template appears not to be initialised and suggest re-running `/biospec.setup` or manually copying `.biospec/status.md` into `project/status.md`.

4. Identify any subdirectories that may contain per-entity files:
	 - `project/intents/`
	 - `project/datasets/`
	 - `project/analyses/`

	 You do **not** need to parse subtemplate schemas here, but you **may** use file presence and obvious content to mark per-intent/per-dataset/per-analysis rows in `status.md`.

## 2. Infer Completion Status from Templates

For each core template file, inspect the contents and infer status for the fields that are represented in `project/status.md`. Only rely on information that is explicitly present in the file. Avoid guessing.

### 2.1 General Rules for Inferring Field Status

For each field/section tracked in `status.md`:

- Map it to the corresponding section(s) in the template (e.g. headings and bullet lists in `project_overview.md`).
- Extract the text beneath the relevant heading or field label.
- Apply these rules:
	- If the field is completely empty or placeholder-only (e.g. just comments, labels, or default tokens like `-` or `{Descriptor}`), mark as `[ ]`.
	- If there is some substantive content but it is clearly partial or draft (short fragments, TODO notes, or obviously incomplete lists), mark as `[-]`.
	- If the field appears reasonably filled to a usable standard (coherent paragraph(s), complete tables, or well-formed lists), mark as `[x]`.

When in doubt about whether `[-]` or `[x]` is appropriate, prefer `[-]` and, if appropriate, note this ambiguity in a short comment in the `Notes` column in `status.md`.

### 2.2 Honouring Explicit Checklists in Templates

Some templates include their own **Checklist** section (e.g. `project_overview.md`, `project_resources.md`).

When these per-template checklists are present:

- Use them as a **signal** for completeness, but do not fully override your own content-based assessment.
- If a checklist item is marked `[x]` but the corresponding content appears clearly incomplete or placeholder-only, do **not** silently downgrade it. Instead:
	- Keep your content-based status assessment.
	- Record the discrepancy in your reasoning.
	- In your final user-facing summary, explicitly flag these discrepancies and ask the user to confirm whether the checklist should be updated.

Conversely, if a checklist item is `[ ]` but the content is clearly complete, prefer the content and update the checklist in `status.md` accordingly.

### 2.3 Mapping Between Templates and `status.md`

Use the `status.md` template in `.biospec/status.md` as the canonical structure for:
- The **Template Status Summary** table.
- The **Phase-Based Checklist**.
- The **Per-Template Field Checklists**.

You should preserve this structure in `project/status.md`, updating only:
- The status markers (`[ ]`, `[-]`, `[x]`).
- The `Notes` columns where appropriate.

Do **not** add or remove rows, headings, or sections unless the user explicitly asks to customise the status template.

#### Example mappings

- `project_overview.md`
	- "Project title & short name" → the `Project Title` and summary fields under **Basic Information** and **Brief Summary**.
	- "Biological / clinical context" → the **Scientific Context** section.
	- etc.

- `project_resources.md`
	- "Computing environment overview" → **Computing Resources** and **HPC/Cloud Details** sections.
	- "Standard operating procedures" → **SOP Availability/Paths**.

- `intent_overview.md`
	- "Overall research question(s)" → the main description of project-level intents.
	- "High-level aims / intents list" → the **List of Intents** and **Summary Table**.

- `dataset_overview.md`
	- "Dataset list & identifiers" → **List of Datasets** and **Summary Table**.

- `analysis_overview.md`
	- "Analysis objectives" → prose around **Analyses** and **Overall Analysis Strategy**.

For per-intent, per-dataset, and per-analysis status rows in `status.md`:
- If the corresponding file exists and has non-trivial content, you may mark the row as `[-]` or `[x]` based on content.
- If the file does not exist or is empty, mark as `[ ]`.
If the table uses placeholder rows (e.g. `intents/intent_001.md`) that do not exist yet, you may leave them as `[ ]`.

## 3. Update `project/status.md`

After inferring statuses:

1. Load `project/status.md`.
2. For each status-controlled cell (status marker or checklist item) that corresponds to a field you analysed, update the marker to the new value.
	 - Only change the status markers, not the labels or file paths.
	 - Preserve markdown alignment as much as reasonably possible; minor spacing changes are acceptable.
3. When you detect a discrepancy between a template-internal checklist and your content-based assessment (see 2.2):
	 - Do **not** overwrite the user's intent silently.
	 - Instead, in your final summary (to the user), explicitly list these discrepancies and ask for confirmation before altering template-local checklists.
	 - You **may** still update `project/status.md` to reflect your content-based assessment as a separate tracking layer.

Ensure that `status.md` remains valid markdown and that all original sections are preserved.

## 4. Status Summary and Percentages

After updating `project/status.md`, construct a concise status summary **for the user** (not to be written back to files) with:

1. **Per-template completion percentages**:
	 - For each tracked template (`project_overview`, `project_resources`, `intent_overview`, `dataset_overview`, `analysis_overview`):
		 - Count the number of fields/rows in its corresponding checklist section in `status.md`.
		 - Assign scores per field: `[ ] = 0`, `[-] = 0.5`, `[x] = 1`.
		 - Compute the percentage completion as:
			 - `completion_percentage = 100 * (sum(scores) / number_of_fields)`
		 - Round to the nearest integer for reporting.

2. **Template Status Summary table alignment**:
	 - Ensure that the high-level status markers in the **Template Status Summary** table are consistent with the per-field percentages.
	 - Suggested mapping:
		 - `0%` → `[ ]`
		 - `>0%` and `<100%` → `[-]`
		 - `100%` → `[x]`

3. **Phase-Based Checklist**:
	 - Optionally infer whether each phase item should be `[ ]`, `[-]`, or `[x]` based on the per-template percentages.
	 - E.g., if `project_overview.md` is ≥80% and `project_resources.md` is ≥80%, mark Phase 1 items as `[-]` or `[x]` accordingly.

4. **Discrepancy Report**:
	 - If any fields are marked `[x]` in the templates' own checklists but appear obviously incomplete based on content, list them explicitly in your final response, e.g.:
		 - `project_overview.md`: "Summary complete" is checked `[x]` but summary section only contains a placeholder.
	 - Ask the user to confirm whether you should downgrade those internal checklist items in a subsequent run.

Present the final summary to the user in a clear, concise format (e.g., a small markdown table for percentages plus a short bullet list of key observations).

## 5. User Guidance and Next Steps

In your final message to the user (after updating `status.md` and computing percentages):

- Briefly state that the status file has been updated based on the current template contents.
- Present the per-template completion table and any notable gaps (e.g. templates that are 0% or very low completion).
- Highlight any discrepancies between internal checklists and content and request confirmation if you think some `[x]` markers should be downgraded.
- Suggest suitable next commands:
	- `/biospec.autofill` if the user has existing documentation or notes they would like used for bulk population.
	- `/biospec.edit` if they want to refine specific sections or fields.

Do **not** modify scientific content in any of the templates as part of this command; only update `project/status.md`.

