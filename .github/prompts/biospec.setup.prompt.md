---
description: Copy the BioSpec template documents into a user's workspace for completion and version control.
name: biospec.setup
agent: BioSpec
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Workflow Overview

**CRITICAL: You MUST use the `manage_todo_list` tool IMMEDIATELY to create and track a checklist for the setup process.**

Do not perform any other actions until you have initialized the todo list.

**Checklist Template:**
```
1. [not-started] Pre-flight checks (validate input & existing files)
2. [not-started] Initialize Structure (create directories)
3. [not-started] Copy Templates (bulk copy files)
4. [not-started] Initialize Metadata (set version/dates)
5. [not-started] Post-Setup Communication
6. [not-started] OPTIONAL: Git Version Control Setup
```

## 1. Pre-flight Checks

**Checklist Item 1: Pre-flight checks**

1. **Validate User Input**:
   - If the user provided project details (e.g. "Setup a project for RNA-seq analysis of..."), inform them that this command *only* creates empty templates.
   - Suggest they run `/biospec.autofill` or `/biospec.edit` *after* this setup is complete to populate them.

2. **Check for Existing Project**:
   - Check if a `project/` directory already exists.
   - If it exists and contains BioSpec files (e.g. `project_overview.md`), **STOP**.
   - Warn the user: "BioSpec templates already exist in `project/`. Overwriting them will lose data."
   - Ask for explicit confirmation to overwrite if that is their intent, or abort.

## 2. Execution

**Checklist Item 2: Initialize Structure**

1. **Create Directories**:
   - Create the following directory structure using `create_directory` or `run_in_terminal`:
     ```
     project/
     project/intents/
     project/datasets/
     project/analyses/
     ```

**Checklist Item 3: Copy Templates**

1. **Bulk Copy**:
   - Use `run_in_terminal` to copy singleton templates from `.biospec/` to `project/` efficiently.
   - Command pattern: `cp .biospec/project_overview.md project/` (repeat for all singletons).
   - **Files to copy**:
     - `project_overview.md`
     - `intent_overview.md`
     - `analysis_overview.md`
     - `dataset_overview.md`
     - `project_resources.md`
     - `status.md`
   - **Do NOT copy**: Subtemplates (`intent.md`, `dataset.md`, `analysis.md`) or the `.biospec` folder itself.

**Checklist Item 4: Initialize Metadata**

1. **Update Headers**:
   - For each copied file in `project/`, use `replace_string_in_file` to set:
     - `Version: 0.1`
     - `Last updated: [Current Date]`

## 3. Post-Setup Communication

**Checklist Item 5: Post-Setup Communication**

1. **Completion Message**:
   - Confirm that the `project/` directory is ready.

2. **Recommend Next Steps**:
   - **Manual Entry**: "You can now edit the markdown files in `project/` directly."
   - **Assisted Entry**:
     - "Use `/biospec.autofill` to bulk-populate templates from existing documents or notes."
     - "Use `/biospec.edit` for targeted updates to specific fields."
   - **Version Control**: "Initialize git tracking for the `project/` directory to manage history."

3. **Ask About Git Version Control** (proceed to optional step 6):
   - **IMPORTANT**: Make this question highly visible to avoid users missing it:
     - Add a visual separator (e.g., `---` or blank line) before the question
     - Use **bold text** for the main question
     - Format like this:
       ```
       ---
       
       🚨 **Version Control**: Would you like to add these project templates to Git version control now?
       
       I can:
       - **Provide you with the commands** to run manually
       - **Handle the Git operations** for you automatically
       ```
   - If the user declines or wants to do it later, mark step 6 as completed and stop.
   - If the user agrees, proceed to **Checklist Item 6**.

## 4. OPTIONAL: Git Version Control Setup

**Checklist Item 6: OPTIONAL: Git Version Control Setup**

This step should only execute if the user explicitly agrees in step 5.

### 4.1 Check Git Status

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

### 4.2 Determine Approach

Ask the user to choose one of the following:

**Option A: Provide Manual Commands**
- Display the commands the user should run:
  ```bash
  git add project/
  git commit -m "Initialize BioSpec project templates"
  ```
- Mark step 6 as completed and stop.

**Option B: Automatic Git Operations**
- Proceed to section 4.3 below.

### 4.3 Automatic Git Operations

1. **Check GitHub Tools Availability**:
   - Check if GitHub MCP tools are available by looking for `mcp_github_*` tools.
   - If available, you can offer to create a branch and push changes.
   - If not available, you can only do local Git operations (add/commit).

2. **Branch Creation (if GitHub tools available)**:
   - Ask the user: "Would you like to create a new branch for this setup? If yes, what should it be named?" (suggest: `biospec-setup` or `setup-project-templates`)
   - If yes and user provides a name:
     - Use `mcp_github_create_branch` to create the branch on GitHub
     - **IMPORTANT**: After creating the branch remotely, you MUST fetch it before checking out:
       ```bash
       git fetch origin <branch-name> && git checkout -b <branch-name> origin/<branch-name>
       ```
     - This avoids the "pathspec did not match any file(s)" error that occurs when trying to checkout a branch that only exists remotely
   - If no, continue on the current branch.

3. **Stage and Commit Changes**:
   - Use `run_in_terminal` to stage the project directory:
     ```bash
     git add project/
     ```
   - Commit with a descriptive message:
     ```bash
     git commit -m "Initialize BioSpec project templates

- Created project directory structure
- Copied template files from .biospec/
- Set initial version to 0.1
- Ready for project specification"
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

### 4.4 Completion

1. **Summary Message**:
   - Confirm that Git version control has been set up.
   - If a branch was created, remind the user: "Your changes are on branch `<branch-name>`. You can create a pull request when ready."
   - If changes are on main/current branch, note: "Your templates have been committed to `<branch-name>`."

2. **Final Recommendations**:
   - "As you populate the templates, commit your changes regularly to track your project's evolution."
   - "Consider creating feature branches for major specification updates."

