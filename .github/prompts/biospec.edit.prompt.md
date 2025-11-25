---
description: Targeted, high-confidence edits to existing BioSpec templates based on new text or resources.
name: biospec.edit
agent: BioSpec
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

User input for this command typically includes:
- The **target template** (e.g. `project_overview`, a specific intent/dataset/analysis file), and
- One or more **fields** within that template the user wants to update, and
- Free-text description and/or attached resources (e.g. protocol text, notes, prior docs) to guide the update.

Your job is to integrate this new information into the **existing** BioSpec docs in a controlled, high-confidence way.

## Workflow Overview

**CRITICAL: You MUST use the `manage_todo_list` tool IMMEDIATELY to create and track a checklist for the editing process.**

Do not perform any other actions (like reading files or searching) until you have initialized the todo list. This ensures systematic completion and visibility into progress. Follow the checklist strictly. 

The checklist structure depends on the user's request type.

**For Standard Edits:**
1. **Pre-flight checks** (validate setup, locate template, check fields)
2. **Draft Content** (read, summarize, decide, draft)
3. **Proposal & Review** (present "Before/After", ask confirmation)
4. **Execution** (apply edits *only after approval*)
5. **Post-Edit Communication** (summary & reminders)
6. **OPTIONAL: Git Version Control** (commit changes if user agrees)

**For Component Deletion:**
1. **Pre-flight checks** (validate setup, locate target)
2. **Impact Analysis** (identify target & references)
3. **Warning & Confirmation** (strict warning)
4. **Execution** (delete & clean up references *only after approval*)
5. **Post-Edit Communication** (summary & reminders)
6. **OPTIONAL: Git Version Control** (commit changes if user agrees)

Mark each task as `in-progress` before starting work, and `completed` immediately upon finishing.

## 1. Preflight Checks

**Checklist Item 1: Validate BioSpec Setup & Target**

Before making any edits:

1. **Confirm BioSpec has been set up**:
	 - Check for the presence of the `project/` directory and core singleton templates:
		 - `project/project_overview.md`
		 - `project/project_resources.md`
		 - `project/status.md`
		 - `project/intent_overview.md`
		 - `project/dataset_overview.md`
		 - `project/analysis_overview.md`
	 - If these are missing, **do not proceed with edits**. Inform the user that they must run the setup command first (e.g. `/biospec.setup`) to initialize BioSpec docs.

2. **Locate the target template**:
	 - Map the user’s template reference (e.g. "project overview", "intent INT-01", "dataset: RNA-seq", "analysis: survival model") to a concrete file path under `project/`.
	 - Typical locations:
		 - Project-level singletons: `project/project_overview.md`, `project/project_resources.md`, etc.
		 - Intents: `project/intents/*.md`
		 - Datasets: `project/datasets/*.md`
		 - Analyses: `project/analyses/*.md`
	 - If you cannot confidently identify the target file, ask the user to clarify and **do not guess**.
	 - **Verify suitability**: Briefly check if the user's input is actually better suited for a *different* template type (e.g. analysis details sent to an intent file). If so, flag this for the Proposal phase.

3. **Check that requested fields exist in the target template**:
	 - Parse the target markdown file and identify headings/sections that correspond to the user’s requested fields (e.g. "Research question", "Hypothesis", "Primary dataset", "QC plan", "Milestones").
	 - Exact name matches are **not** required; approximate, high-confidence matches (e.g. "research aims" → "Research questions and aims") are acceptable.
	 - If a requested field cannot be mapped with high confidence to an existing section, either:
		 - Ask a brief clarifying question, or
		 - Propose candidate section names the user could create manually, but **do not create new sections on your own** unless explicitly instructed.

If any of these preflight checks fail, explain the issue and stop before editing files.

## 2. Editing Principles

When preflight checks pass and the target field(s) are identified, apply these principles:

- **High confidence only**:
	- Only update a field if you can clearly and confidently interpret how the new text/resources relate to the existing content.
	- If interpretation is ambiguous, either request clarification or propose alternative candidate rewrites for the user to choose from.
- **No invention**:
	- Do **not** introduce new aims, hypotheses, datasets, or analyses that are not clearly supported by the user input and existing docs.
	- Prefer to leave fields unchanged and call out missing information rather than guessing.
- **Preserve prior detail where possible**:
	- Integrate new information **without discarding useful existing detail** unless the user clearly indicates they want to replace it.
	- When replacing content, ensure that important qualifiers (e.g. cohort sizes, inclusion/exclusion criteria, assay platforms, limitations) are not lost unless explicitly superseded.
- **Explicit assumptions**:
	- If you must make minor interpretive assumptions (e.g. mapping user shorthand to existing terminology), note these assumptions briefly in your reasoning and keep the edit conservative.
- **Optimal Placement**:
	- Critically evaluate whether the new information belongs in the requested template or is better suited for a related component (e.g. specific computational parameters in an Intent might belong in an Analysis; sample processing details might belong in a Dataset).
	- **Do not** dump structured information into generic "Notes" or "Description" fields of the wrong template just to include it.
	- If the information belongs in a different file, propose editing that file instead or in addition to the requested one.

## 3. Field-Level Update Workflow

**Checklist Item 2 (Edit): Draft Content**

For each targeted field:

1. **Read existing content**:
	 - Extract the current text under the relevant heading/section.

2. **Summarize the user’s new information**:
	 - Internally summarize how the new text/resources relate to the existing content (e.g. "adds a new covariate", "clarifies inclusion criteria", "tightens hypothesis wording").

3. **Decide update type**:
	 - Choose one of:
		 - **Refine/rewrite**: Replace the existing field content with a clearer, more precise version that incorporates the new information.
		 - **Extend**: Add new sentences/paragraphs that augment the existing content (e.g. adding limitations, additional QC steps, or more specific endpoints).
		 - **Re-organize**: Minor restructuring within the field (e.g. bullet lists, clearer sub-points) to improve readability **without changing meaning**.

4. **Draft the new content**:
	 - Formulate the exact text you intend to place in the file.
	 - Keep the field focused and aligned with the template’s intent.
	 - Avoid cascading changes into other sections unless the user explicitly asked for that broader scope.

5. **Maintain formatting**:
	 - Preserve markdown structure, headings, checklists, and any identifiers or labels already present in the template.

## 4. Component Deletion Workflow

**Checklist Item 2 (Delete): Impact Analysis & Warning**

If the user requests to **remove** or **delete** a component (e.g. "remove Intent 2", "delete the RNA-seq dataset"):

1. **Identify the Target**:
   - Locate the specific file to be deleted (e.g. `project/intents/intent-2.md`).
   - Verify it exists.

2. **Identify References**:
   - Scan overview files (e.g. `project/intent_overview.md`, `project/dataset_overview.md`) for links or table rows referencing this component.
   - Scan other component files for cross-references (e.g. an analysis referencing the dataset to be deleted).

3. **Formulate the Plan**:
   - List the file(s) to be deleted.
   - List the file(s) to be edited (to remove references).

4. **Strict Confirmation & Warning**:
   - **STOP** and present the plan to the user.
   - Explicitly warn: "This action will permanently delete `[filename]`. Please ensure you have a backup or version control commit before proceeding."
   - Ask: "Are you sure you want to delete this component and its references?"

**Checklist Item 3 (Delete): Execution**

5. **Execution (Only after confirmation)**:
   - Delete the target file.
   - Edit referencing files to remove links/rows.
   - Report completion.

## 5. Review and Approval Process

**Checklist Item 3 (Edit): Proposal & Review**

**CRITICAL STEP**: You must NOT edit files immediately. You must first propose the changes to the user.

1. **Present the Proposal**:
	 - For each target file and field, show a clear "Before" (summary) and "After" (full text) comparison.
	 - Explain the reasoning for the change.
	 - If you identified that some information belongs in a different file, include that in your proposal (e.g. "I recommend placing the parameter details in `analysis-1.md` instead of `intent-1.md`").

2. **Ask for Confirmation**:
	 - Explicitly ask the user to review the proposed changes. They may provide feedback or request modifications.
	 - Without any markdown formatting, ask: "Shall I apply these changes to the files? (Yes/No/Request changes)"

**Checklist Item 4 (Edit): Execution**

3. **Execution Condition**:
	 - **IF** the user has explicitly provided approval in the current turn (e.g. "Yes, apply these changes" or "The changes look good"), **THEN** proceed to use the file editing tools.
	 - **ELSE** (if this is the first turn or no approval is given), **STOP** after presenting the proposal. Do not edit files yet.

## 6. Ambiguity Handling

When information is unclear or partially contradictory:

- Prefer **not** to update the field rather than guessing.
- Briefly explain to the user what is ambiguous (e.g. conflicting cohort sizes, unclear endpoints, unspecified timepoints) and what extra information would be needed.
- If helpful, propose 2–3 candidate phrasings with different assumptions clearly labelled, and ask the user which is closest to their intent before editing.

## 7. BioSpec Rules and Non-Invention

Always align with BioSpec’s core rules:

- Only populate or modify fields using information that is **explicitly provided** by the user or **clearly inferable** from existing BioSpec docs.
- Do **not** invent claims, questions, hypotheses, data sources, or analytical methods.
- When in doubt, leave the field unchanged and highlight the gap for the user.

## 8. Post-Edit Communication

**Checklist Item 5: Post-Edit Communication**

After performing edits (i.e. after user approval):

1. **Summary of Changes**:
   - Provide a concise summary of **which files and fields** were updated (e.g. "Updated Hypothesis and Objectives in `project/intents/INT-01.md`").
   - For each updated field, briefly explain the nature of the change (e.g. "clarified hypothesis to specify endpoints and cohort", "added explicit batch effect consideration to dataset limitations").

2. **Review Reminder**:
   - You **MUST** include a standard reminder for the user to review the changes.
   - Use phrasing similar to: "Please review the changes in your workspace. You can use your version control system to track these edits or revert them if needed."
   - Explicitly encourage the user to use Git (or another VCS) to track edits, roll back changes, and share docs.

3. **Ask About Git Version Control** (proceed to optional step 6):
   - **IMPORTANT**: Make this question highly visible to avoid users missing it:
     - Add a visual separator (e.g., `---` or blank line) before the question
     - Use **bold text** for the main question
     - Format like this:
       ```
       ---
       
       🚨 **Version Control**: Would you like to commit these changes to Git version control now?
       
       I can:
       - **Provide you with the commands** to run manually
       - **Handle the Git operations** for you automatically
       ```
   - If the user declines or wants to do it later, mark step 6 as completed and stop.
   - If the user agrees, proceed to **Checklist Item 6**.

---

## 9a. OPTIONAL: Git Version Control

**Checklist Item 6: OPTIONAL: Git Version Control**

This step should only execute if the user explicitly agrees in the Post-Edit Communication phase.

### 1. Check Git Status

1. **Verify Git Repository**:
   - Use `run_in_terminal` to check if the workspace is a Git repository:
     ```bash
     git rev-parse --git-dir
     ```
   - If this fails (exit code non-zero), inform the user: "This workspace is not a Git repository. Please initialize Git first with `git init` or clone a repository."
   - **STOP** if not a Git repository.

2. **Check for Uncommitted Changes**:
   - Run: `git status --porcelain`
   - If there are uncommitted changes outside the `project/` directory, warn the user: "You have other uncommitted changes in your workspace. Proceeding will create a commit that includes the BioSpec templates only."

### 2. Determine Approach

Ask the user to choose one of the following:

**Option A: Provide Manual Commands**
- Display the commands the user should run:
  ```bash
  git add project/
  git commit -m "Edit BioSpec templates: [brief description]"
  ```
- Replace [brief description] with a summary of the edits made (e.g., "Update intent-1 hypothesis and success criteria").
- Mark step 6 as completed and stop.

**Option B: Automatic Git Operations**
- Proceed to section 3 below.

### 3. Automatic Git Operations

1. **Check GitHub Tools Availability**:
   - Check if GitHub MCP tools are available by looking for `mcp_github_*` tools.
   - If available, you can offer to create a branch and push changes.
   - If not available, you can only do local Git operations (add/commit).

2. **Branch Creation (if GitHub tools available)**:
   - Ask the user: "Would you like to create a new branch for these changes? If yes, what should it be named?" (suggest: `biospec-edit-<component>` or `update-<field>`)
   - If yes and user provides a name:
     - Use `mcp_github_create_branch` to create the branch on GitHub
     - **IMPORTANT**: After creating the branch remotely, you MUST fetch it before checking out:
       ```bash
       git fetch origin <branch-name> && git checkout -b <branch-name> origin/<branch-name>
       ```
     - This avoids the "pathspec did not match any file(s)" error that occurs when trying to checkout a branch that only exists remotely
   - If the branch already exists, fetch and checkout:
       ```bash
       git fetch origin <branch-name> && git checkout -b <branch-name> origin/<branch-name>
       ```
   - If no, continue on the current branch.

3. **Stage and Commit Changes**:
   - Use `run_in_terminal` to stage the project directory:
     ```bash
     git add project/
     ```
   - Commit with a descriptive message based on the edits made:
     ```bash
     git commit -m "Edit BioSpec templates: [description]

[Detailed list of changes]"
     ```
   - Example:
     ```bash
     git commit -m "Edit BioSpec templates: Update intent-1

- Refined hypothesis to specify endpoints
- Added success criteria for statistical significance
- Updated cross-references to dataset-1"
     ```

4. **Verify Commit**:
   - Run: `git log -1 --stat`
   - Show the user the commit details to confirm success.

5. **Push to Remote (if GitHub tools available and branch was created)**:
   - If a new branch was created, ask: "Would you like to push this branch to the remote repository?"
   - If yes, use `run_in_terminal`:
     ```bash
     git push -u origin <branch-name>
     ```
   - Confirm the push was successful.

### 4. Completion

1. **Summary Message**:
   - Confirm that Git version control has been set up.
   - If a branch was created, remind the user: "Your changes are on branch `<branch-name>`. You can create a pull request when ready."
   - If changes are on main/current branch, note: "Your edits have been committed to `<branch-name>`."

2. **Final Recommendations**:
   - "Continue committing changes as you refine the templates to maintain a clear history."
   - "Consider creating feature branches for different aspects of your project specification."

---

## 9. When to Recommend Other Commands

- If the user’s request is broad (e.g. "update everything based on this grant PDF"), suggest **`/biospec.autofill`** instead of trying to perform many small edits here.
- If the user wants to **discuss** possible formulations before committing them, suggest **`/biospec.discuss`** and act as a collaborator first, then return to `/biospec.edit` once the wording is agreed.

## Checklist Summary Templates

When starting the edit process, **IMMEDIATELY** call `manage_todo_list` with the appropriate checklist based on the user's request.

**Template A: Standard Edit**
```
1. [not-started] Pre-flight checks (validate setup & target)
2. [not-started] Draft content (read, summarize, decide, draft)
3. [not-started] Proposal & Review (present before/after)
4. [not-started] Execution (apply edits after approval)
5. [not-started] Post-Edit Communication
6. [not-started] OPTIONAL: Git Version Control
```

**Template B: Component Deletion**
```
1. [not-started] Pre-flight checks (validate setup & target)
2. [not-started] Impact Analysis & Warning
3. [not-started] Execution (delete & cleanup after approval)
4. [not-started] Post-Edit Communication
5. [not-started] OPTIONAL: Git Version Control
```

Your goal is to produce **precise, high-confidence, minimal edits** that faithfully integrate the user’s new information into the existing BioSpec templates, ensuring the user reviews and approves all changes before they are applied.
