---
description: Autopopulate BioSpec docs using resources and/or repository content
name: biospec.autofill
agent: BioSpec
---

## User Input

```text
$ARGUMENTS
```

## Outline

Your task is to extract project details and fill out only relevant, unambiguous fields in BioSpec templates. 

The text the user typed or attached after `/biospec.autofill` is optional and may contain project artefacts. The user may also note what categories of information they expect each resource to contain, or specify a particular project or cohort to focus on. **Pay strict attention to these scoping instructions.** If the user specifies a focus, ignore information related to other projects or cohorts found in the documents. If no path or input is provided, it is possible that they have attached project materials. If you are certain no material has been provided, scan the current repository for project artefacts according to the strategy below.

## Workflow Overview

**Use the `manage_todo_list` tool to create and track a checklist for the autofill process.** This ensures systematic completion and visibility into progress. The checklist should include:

1. **Pre-flight checks** (validate setup, understand scope)
2. **Information extraction** (identify and create component files)
3. **Overview synthesis** (populate overview files)
4. **Refinement and validation** (cross-check consistency)
5. **Final communication** (summarize changes and next steps)
6. **OPTIONAL: Git Version Control** (commit changes if user agrees)

Mark each task as `in-progress` before starting work, and `completed` immediately upon finishing.

## IMPORTANT: Pre-Flight Checks

**Create a todo list at the start of the autofill process** to track these initial validation steps:

### ☑️ Checklist Item 1: Validate BioSpec Setup

Before making any edits, check that the `project/` directory and core singleton templates exist:
- `project/project_overview.md`
- `project/project_resources.md`
- `project/status.md`
- `project/intent_overview.md`
- `project/dataset_overview.md`
- `project/analysis_overview.md`
- `project/dependencies.md`

If they do not exist, stop and inform the user that they must run the setup command first (e.g. `/biospec.setup`) to initialize BioSpec docs.

### ☑️ Checklist Item 2: Understand Scope and Sources

- **If user provided text or file paths**: Parse provided content directly (skip repository scan)
- **If user attached files (visible in context)**: Parse attachments directly (skip repository scan)
- **If neither text, paths, nor attachments provided**: Ask user:
  "No project materials were provided. Would you like me to scan the repository for documentation? (yes/no)"
  - If user says 'no': Stop and recommend they explicitly supply project artefacts
  - If user says 'yes': Proceed with repository scanning strategy

### ☑️ Checklist Item 3: Validate File Formats

If the user attached files, check their file formats. If you cannot open or read a particular file, communicate this to the user and suggest that they install 'markitdown' or another appropriate package to convert resources into markdown or text format.

## Guiding principles

- Do NOT assume or infer any information. Only record high confidence, unambiguous information. 
- Do NOT invent or create new fields in the BioSpec docs. 
- Remain faithful to provided template and field descriptions.

### Template-Structure Rules (important)

- **Preserve the template structure**: Keep headings, tables, and `<details>` blocks intact; fill in the blanks inside them.
- **Preserve guidance comments**: Keep `<!-- ... -->` comments unless you are explicitly replacing the placeholder they describe.
- **Replace placeholders consistently**: When creating component files, replace `{n}` (and `{m}` / `{h}`) consistently across:
   - YAML frontmatter IDs (e.g., `dataset_id: {n}`)
   - The top-level title (e.g., `# Dataset {n}: ...`)
   - Cross-links in “Related Components” sections

**When a field already contains content**:
1. If existing content is a placeholder (e.g., "TBD", "To be determined"): Replace it
2. If existing content is partial but accurate: Append new details, preserving original
3. If existing content conflicts with new information: Add new info with a note like "[From source X:]" and flag for user review
4. Never delete existing content unless it's clearly placeholder text

### Critical: Distinguishing Reference from Implementation

**IMPORTANT**: Just because a tool, method, analysis, or dataset is *mentioned* or *referenced* in source documents does NOT mean it will be used in the current project. Apply these rules strictly:

- **Reference/Prior Work**: If a document mentions methods or datasets as background, inspiration, or comparison, they belong in the "Prior Work & Inspiration" section of `project_overview.md`, NOT in analyses or datasets.
- **Current Project**: Only populate intents, datasets, analyses, and resources with information that is **explicitly stated** as part of the current project's scope or execution plan.
- **Ambiguous Cases**: When uncertain whether something is reference material or actual project component, **leave it out** or note it only in "Prior Work" with clear attribution.

**Examples**:
- ❌ "Study X used method Y" → Do NOT add method Y to analyses unless explicitly stated for current project
- ✅ "We will apply method Y to our data" → Add method Y to analyses
- ❌ "Prior studies identified cell population Z" → Do NOT create analysis unless current project states it will do this
- ✅ "We will identify cell population Z in our cohort" → Create analysis

**Default assumption**: Referenced work is background context, not project implementation, unless clearly stated otherwise.

### Specific Guidelines for Common Scenarios

**Tools and Methods**:
- ❌ "Method X has been successfully used in prior studies" → Do NOT add to current analyses
- ❌ "The field uses tool Y for this type of analysis" → Do NOT add to resources unless explicitly mentioned for current project
- ✅ "We will use tool Y" or "Analysis will be performed using tool Y" → Add to analyses/resources
- ⚠️ "Tools such as A, B, or C could be used" → Leave blank or note as options, not confirmed tools

**Datasets**:
- ❌ "We previously analyzed N cases" → This is prior work, not current dataset (unless explicitly stated as being reanalyzed)
- ❌ "Public datasets like Cohort-X provide comparison" → Reference only, not current project data
- ✅ "We will analyze N samples from our cohort" → Create dataset file
- ⚠️ "Additional public data may be incorporated" → Note as potential, not confirmed

**Analyses**:
- ❌ "Cell subtype A has been identified in disease X" → Background, not a current analysis task
- ✅ "We will identify cell subtype A in our cohort" → Create analysis file
- ❌ "Technology X enables feature identification" → General capability, not a specific planned analysis
- ✅ "Features will be identified using method Y" → Create analysis file

**Intents/Hypotheses**:
- ❌ "Prior work suggests factor X influences outcome Y" → Background motivation, not a hypothesis unless current project states it will test this
- ✅ "We hypothesize that factor X influences outcome Y in our cohort" → Create intent with hypothesis
- ❌ "Understanding mechanism Z remains an open question in the field" → Field gap, not necessarily current project intent
- ✅ "We aim to determine whether mechanism Z occurs in our system" → Create intent

### Repository Scanning Strategy

[IMPORTANT] 
Skip the repository scan if project details were provided. If no inputs were provided, confirm with the user (yes/no) on whether or not they allow a repository scan (looking for documents and filenames). If the user replies 'no', do NOT proceed. Recommend that they explicitly supply project artefacts. 

Scan the repository systematically in two priority levels.

#### Level 1: Project Definition Files (Highest Priority)

**Strategy**: Locate and **READ** these files to extract explicit project descriptions, scientific goals, and study designs.

**Primary documentation**:
- `README.md`, `README.rst`, `README.txt`, `README` (any format)
- `PROJECT.md`, `project_description.*`
- `docs/index.*`, `docs/project_overview.*`, `docs/README.*`

**Research documentation**:
- `proposal.*`, `grant_proposal.*`, `grant.*`
- `manuscript.*`, `paper.*`, `publication.*`
- `methods.*`, `analysis_plan.*`
- `.github/ISSUE_TEMPLATE/*` (may contain project scope)

**File discovery**:
```bash
# Use a glob-style file search to find these patterns (e.g., the workspace file search tool):
README*
PROJECT*
docs/{index,project_overview,README}*
{proposal,grant,grant_proposal}*
{manuscript,paper,publication,methods,analysis_plan}*
.github/ISSUE_TEMPLATE/*
```

**Extraction priority**: These files should be read FIRST and given HIGHEST confidence for extracted information.

#### Level 2: Technical Context via File Signatures (Medium Priority)

**Strategy**: Use file extensions and specific filenames to infer the technical stack, infrastructure, and workflow types **WITHOUT reading file content**. This provides a semantic overview of the project's implementation layer and tasks.

**Inference Rules**:
- **Languages**: `*.py` (Python), `*.R` (R), `*.jl` (Julia), `*.rs` (Rust)
- **Package Management**: `requirements.txt`, `pyproject.toml`, `renv.lock`, `package.json`
- **Workflow Systems**: `Snakefile` (Snakemake), `nextflow.config` or `*.nf` (Nextflow), `WDL`
- **Containerization**: `Dockerfile`, `Singularity`, `*.def`
- **Infrastructure**: `*.slurm`, `*.pbs` (HPC/Scheduler)
- **Interactive Analysis**: `*.ipynb` (Jupyter Notebooks), `*.Rmd` (R Markdown)

**File discovery**:
```bash
# Use a glob-style file search to find these patterns (e.g., the workspace file search tool):
**/*.{py,R,jl,rs}
{requirements.txt,pyproject.toml,renv.lock,package.json}
{Snakefile,nextflow.config,*.nf,*.wdl}
{Dockerfile,Singularity,*.def}
**/*.{slurm,pbs}
**/*.{ipynb,Rmd}
```

**Extraction priority**: Infer technical context based solely on the *presence* of these files.

#### Scanning Execution

- **Warn if no files found**: If zero Level 1 files found, WATN "No project documentation found. Falling back to filenames and extensions (less reliable)."

## Information Extraction Procedure

**After pre-flight checks, create a detailed todo list with these tasks and update it systematically:**

### ☑️ Phase 1: Extract Core Project Information

**Checklist Item 4: Populate `project/project_overview.md`**

Your goal is to add detail to the high-level project overview. It is possible that some fields are already populated; prefer to edit or append rather than overwrite.

For each project artefact provided or found:
1. Parse structure to identify document type and its headers
2. Extract high-confidence information for:
   - Basic Information (title, type, PIs, teams, dates)
   - Brief Summary
   - Keywords
   - Scientific Context (organism, tissue, scale, processes)
   - Intended Outputs
   - Project Scope (in-scope and out-of-scope activities)
   - Prior Work & Inspiration

**Distinguish carefully between what is background/prior work versus what the current project will do.**

Mark as completed when `project_overview.md` is populated.

---

### ☑️ Phase 2: Identify and Create Component Files

**Naming convention for component files**:
- Use sequential numbering starting from 1: `intent-1.md`, `intent-2.md`
- Check existing files to find the next available number

**Checklist Item 5: Identify and Create Intent Files**

Scan for *all* distinct research questions, aims, or goals **that the current project explicitly states it will address**. 

For *each* distinct intent found:
- Check if it is already represented in an existing `intent-{n}.md` file. If so, skip creating a duplicate and prefer to update the existing file.
- If it is not represented, create `project/intents/intent-{n}.md` using the template from `.biospec/subtemplates/intent.md`
- Ensure the intent’s YAML frontmatter (e.g., `intent_id`, `intent_type`) and the `# Intent {n}: ...` title match the chosen number and type.
- Fill out: Type, Statement, Priority, Hypotheses (if applicable), Expected Outcomes, Success Criteria
- Link to related datasets and analyses (even if not yet created)

**Conservative approach**: When unclear if an objective is for the current project or is background context, omit it. Do not create intents based on general background or referenced studies.

Mark as completed when all intent files are created.

---

**Checklist Item 6: Identify and Create Dataset Files**

Scan for *all* distinct datasets or cohorts **that will be used in the current project**.

For *each* dataset or cohort:
- Check if it is already represented in an existing `dataset-{n}.md` file. If so, skip creating a duplicate and prefer to update the existing file.
- If it is not represented, create `project/datasets/dataset-{n}.md` using the template from `.biospec/subtemplates/dataset.md`
- Ensure the dataset’s YAML frontmatter (e.g., `dataset_id`) and the `# Dataset {n}: ...` title match the chosen number.
- Follow this three-check system:
   1. The integration check: "Will these modalities be loaded into a single Python/R object (e.g., Anndata, Seurat) for analysis?" Yes: Keep them together (e.g., CITE-seq, Multiome). No: Split them (e.g., Visium + scRNA-seq).
   2. The cohort check: "Are these samples analyzed as a single biological unit, or are they distinct study phases (e.g. discovery and validation cohort)?" Yes: Keep them together. No: Split them.
   3. The governance check: "Does the entire dataset share the same access permissions?" Yes: Keep them together. No: Split them.
- Fill out: Data Types, Sample Information, Metadata Requirements, Access, Citation

**Dataset template-specific guidance** (align to `.biospec/subtemplates/dataset.md`):
- Use **one row per modality** in the `Modalities` table.
- If multiple modalities exist, add/duplicate a `### Modality {m}: ...` block in the “Modality Details” `<details>` section for each modality.
- Keep `Access` constrained to the template options (`Public` or `In-house`) unless the template itself changes.
- Prefer putting sample-count and batch-effect details in the “Sample Information” `<details>` section (`Total Samples`, `Batch Variables`, `Identifier Convention`).

- Link to related intents and analyses

**Conservative approach**: If a dataset is only mentioned for comparison or as prior work, do not create a dataset file; instead note it in "Prior Work" section of `project_overview.md`.

Mark as completed when all dataset files are created.

---

**Checklist Item 7: Identify and Create Analysis Files**

Scan for *all* distinct computational analyses or objectives **that the current project will perform**.

For *each* analysis:
- Check if it is already represented in an existing `analysis-{n}.md` file. If so, skip creating a duplicate and prefer to update the existing file.
- If it is not represented, create `project/analyses/analysis-{n}.md` using the template from `.biospec/subtemplates/analysis.md`
- Ensure the analysis YAML frontmatter (e.g., `analysis_id`) and the `# Analysis {n}: ...` title match the chosen number.
- Fill out: Description, Priority, Methods & Tools, Expected Outputs, Success Criteria
- Link to related intents and datasets
- **Conservative approach**: Only populate the "Tools/Packages" field if specific tools are explicitly mentioned as being used in the current project, not just referenced

Be especially conservative here—do not create analysis files for methods that are only mentioned as background or prior approaches.

Mark as completed when all analysis files are created.

---

### ☑️ Phase 3: Synthesize Overview Files

**Checklist Item 8: Update `project/intent_overview.md`**

Summarize project scientific intent from individual `intent` files:
- Update list of intent files with links
- Complete summary table with key details
- Document dependencies between intents

Mark as completed.

---

**Checklist Item 9: Update `project/dataset_overview.md`**

Summarize project datasets from individual `dataset` files:
- Update list of dataset files with links
- Complete summary table with key details
- Document data integration plan and cross-dataset considerations

Mark as completed.

---

**Checklist Item 10: Update `project/analysis_overview.md`**

Summarize project analyses from individual `analysis` files:
- Organize by priority (Must Have, Nice to Have, Future Considerations)
- Complete summary table with key details
- Document overall analysis strategy and cross-analysis dependencies

Mark as completed.

---

**Checklist Item 11: Populate `project/project_resources.md`**

Extract information about computational resources and infrastructure:
- Hardware specifications
- HPC/Cloud details
- Data storage strategy
- Version control setup
- **Only add tools, packages, or infrastructure explicitly mentioned as available or planned for the current project.** Do not infer the entire software stack from referenced methods.

Mark as completed. 

## Detail Enrichment & Verification

### ☑️ Phase 4: Refinement and Validation

**Checklist Item 12: Detail Enrichment**

Re-read source documents specifically looking for:
- Quantitative details (e.g., sample counts, patient numbers, batch sizes)
- Specific technologies, platforms, or kits (e.g., "Visium" instead of just "Spatial", specific sequencing platforms)
- Any high-confidence details that were initially missed

Update the populated templates with these specific details if found.

Mark as completed.

---

**Checklist Item 13: Validate Tool/Resource Attributions**

For each tool, package, or resource listed in analyses or resources:
- Confirm it is explicitly mentioned as being used in the **current** project
- If it's only mentioned as prior work or reference, remove it or relocate to "Prior Work"
- If uncertain, use conditional language (e.g., "if available") or leave the field blank with a note

Mark as completed.

---

**Checklist Item 14: Overview Refinement**

Revisit `project/project_overview.md`:
- Refine the "Brief Summary", "Keywords", and "Scientific Context" based on the granular details extracted into the intents, datasets, and analyses
- Ensure the high-level overview accurately reflects the sum of the parts
- **Verify Prior Work Section**: Confirm that tools, methods, and datasets mentioned only as background or inspiration are clearly separated from current project components

Mark as completed.

---

**Checklist Item 15: Consistency Check**

Cross-validate all populated files:
- Compare the contents of the `_overview.md` files. Are they consistent?
- Do the tools listed in `project_resources.md` match what's described in the analysis files?
- Do all cross-references between files work correctly?
- Remove any tools that were inferred but not explicitly stated for the current project

Mark as completed.

## Final Communication

### ☑️ Phase 5: User Communication

**Checklist Item 16: Provide Summary of Changes**

Provide a brief conversational summary organized by file/category:
- List which files were created or modified
- **Note any assumptions or uncertainties**: If you included tools/methods/datasets where the distinction between reference and implementation was unclear, explicitly call this out for user review
- **Highlight omissions**: If you deliberately omitted information because it appeared to be reference material rather than current project scope, mention this so the user can correct if needed

---

**Additional Communication Points:**

1. **Review Encouragement**:
   - Encourage the user to review the changes in their workspace and version control system
   - **Special attention**: Ask user to verify that tools, packages, and methods listed are actually available/planned for their current project, not just referenced from prior work

2. **Next Steps**:
   - Note that the user can directly respond with more requests on edits and tasks
   - Point out that the following commands are available:
     - `/biospec.edit`: Targeted, guardrailed editing
     - `/biospec.discuss`: Ideation, brainstorming, discussion
     - `/biospec.review`: Critical feedback

3. **Ask About Git Version Control** (proceed to optional step 17):
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
   - If the user declines or wants to do it later, mark step 17 as completed and stop.
   - If the user agrees, proceed to **Checklist Item 17**.

---

## OPTIONAL: Git Version Control

**Checklist Item 17: OPTIONAL: Git Version Control**

This step should only execute if the user explicitly agrees in the Final Communication phase.

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
  git commit -m "Autofill BioSpec project templates
  
- Populated project overview and resources
- Created intent/dataset/analysis component files
- Updated overview files with summary tables"
  ```
- Mark step 17 as completed and stop.

**Option B: Automatic Git Operations**
- Proceed to section 3 below.

### 3. Automatic Git Operations

1. **Check GitHub Tools Availability**:
   - Check if GitHub MCP tools are available by looking for `mcp_github_*` tools.
   - If available, you can offer to create a branch and push changes.
   - If not available, you can only do local Git operations (add/commit).

2. **Branch Creation (if GitHub tools available)**:
   - Ask the user: "Would you like to create a new branch for these changes? If yes, what should it be named?" (suggest: `biospec-autofill` or `populate-templates`)
   - If yes and user provides a name:
     - Use `mcp_github_create_branch` to create the branch on GitHub
     - **CRITICAL**: After creating a branch via GitHub API, you MUST run:
       ```bash
       git fetch origin <branch-name>
       git checkout <branch-name>
       ```
       The branch exists only on the remote until fetched. `git checkout` alone will fail.
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
   - Commit with a descriptive message:
     ```bash
     git commit -m "Autofill BioSpec project templates

- Populated project overview and resources
- Created [N] intent files
- Created [M] dataset files
- Created [K] analysis files
- Updated overview files with summary tables"
     ```
   - Replace [N], [M], [K] with actual counts.

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
   - If changes are on main/current branch, note: "Your templates have been committed to `<branch-name>`."

2. **Final Recommendations**:
   - "As you continue to refine the templates, commit your changes regularly to track your project's evolution."
   - "Consider creating feature branches for major specification updates."

---

## Checklist Summary Template

When starting the autofill process, create a todo list with these items:

```
1. [not-started] Validate BioSpec setup exists
2. [not-started] Understand scope and confirm sources
3. [not-started] Validate file formats (if applicable)
4. [not-started] Populate project_overview.md
5. [not-started] Identify and create intent files
6. [not-started] Identify and create dataset files
7. [not-started] Identify and create analysis files
8. [not-started] Update intent_overview.md
9. [not-started] Update dataset_overview.md
10. [not-started] Update analysis_overview.md
11. [not-started] Populate project_resources.md
12. [not-started] Detail enrichment pass
13. [not-started] Validate tool/resource attributions
14. [not-started] Refine project_overview.md
15. [not-started] Consistency check across all files
16. [not-started] Provide summary to user
17. [not-started] OPTIONAL: Git Version Control
```

Mark each item as `in-progress` before starting work on it, and `completed` immediately after finishing. This ensures visibility and systematic progress.
