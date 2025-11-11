---
description: Create a new biospec project charter from a user's natural language project description.
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

The text the user typed after `/biospec.create_project` in the triggering message **is** the project description. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given that project description, do this:

### 1. Initialize Project Structure

Create a new `project/` directory in the repository root with the following structure:

```
project/
├── intents/           # Individual intent files (instantiated from subtemplates)
├── datasets/          # Individual dataset files (instantiated from subtemplates)
├── analyses/          # Individual analysis files (instantiated from subtemplates)
├── intent_overview.md    # Index/orchestrator for intents
├── dataset_overview.md   # Index/orchestrator for datasets
├── project_overview.md   # Singleton
└── project_resources.md  # Singleton
```

Copy singleton template files from `.biospec/` to `project/`:
- project_overview.md
- intent_overview.md
- dataset_overview.md
- project_resources.md

Set initial metadata in each file:
- Version: 0.1
- Last updated: [Current date in YYYY-MM-DD format]

**Note**: Individual intent, dataset, and analysis files will be created by instantiating subtemplates from `.biospec/subtemplates/` in subsequent steps.

### 2. Parse User Description

**If empty**: ERROR "No project description provided"

Extract key information from the natural language description:

#### a. Project Metadata
- Project title/name (explicit or inferred from description)
- People mentioned (PIs, collaborators, lead analysts)
- Dates/timelines mentioned
- Keywords (biological, technical, methodological terms)

#### b. Scientific Context
- **Biological entities**: organisms, tissues, cell types, developmental stages
- **Biological scale**: Look for indicators of data modality
  - genomic, transcriptomic (scRNAseq, bulk RNA-seq), proteomic, metabolomic
  - multi-omic, imaging-based (Phenocycler, Visium, Xenium)
  - annotated pathology slides, SNP microarray
  - Organoid, Patient Derived Xenograft (PDX)
- **Biological processes**: pathways, mechanisms, phenotypes of interest

#### c. Research Intent Classification

**CRITICAL**: Distinguish between these three research elements:

| Element | Indicators | Format |
|---------|-----------|--------|
| **Research Question** | "How does...", "What is...", "Is there..." | Interrogative statement |
| **Research Aim** | "To determine...", "To characterize...", "To identify..." | Goal statement (not a question) |
| **Hypothesis** | "We hypothesize that...", "X causes Y", statements with testable predictions | Testable prediction with null/alternative forms |
| **Analysis Objective** | "Perform differential expression", "Run InferCNV", specific computational tasks | Concrete analysis task |

**Examples**:
- "We want to understand how tumor cells interact with immune cells" → **Research Question**
- "To characterize the tumor microenvironment in melanoma patients" → **Research Aim**
- "We hypothesize that T cell infiltration correlates with treatment response" → **Hypothesis**
- "Perform cell type annotation and differential expression analysis" → **Analysis Objectives**

#### d. Project Type Classification

Match description patterns to project types:

| Project Type | Indicators in Description |
|--------------|---------------------------|
| **exploratory** | "explore", "discover", "investigate", "characterize", "profile", no specific hypothesis, broad questions |
| **targeted** | Specific hypothesis, "test whether", "validate", focused question, specific biological mechanism |
| **package development** | "develop a tool", "create a package", "build software", "implement method" |
| **workflow refactoring** | "optimize pipeline", "improve workflow", "refactor code", "reproduce analysis" |

**Decision rules**:
- If multiple types apply, choose the primary focus
- Default to "exploratory" if ambiguous
- "targeted" requires explicit hypothesis or specific biological question
- Mark as [NEEDS CLARIFICATION: project type] only if fundamentally unclear

#### e. Dataset Identification

Extract dataset mentions and characteristics:

**Dataset indicators**:
- Data type mentions: "scRNA-seq data", "spatial transcriptomics", "imaging data"
- Source mentions: "public dataset", "GSE12345", "internal cohort", "published study"
- Sample information: "50 patients", "3 biological replicates", "tumor and normal"
- Processing level: "raw counts", "normalized data", "processed matrix"

**Pattern matching**:
- **Primary data**: "raw reads", "FASTQ", "unprocessed", "fresh samples" → processing level: primary
- **Secondary data**: "count matrix", "normalized", "aligned" → processing level: secondary
- **Tertiary data**: "analyzed", "annotated", "processed results" → processing level: tertiary

#### f. Computational Scope

Identify computational activities mentioned:

**In-scope indicators**: specific tools (Seurat, InferCNV, etc.), methods (clustering, differential expression), QC tasks
**Out-of-scope indicators**: "no deep learning", "won't develop new tools", "exclude proprietary software"

If nothing specified: Make informed guesses based on project type and data, but mark assumptions in the Assumptions field.

### 3. Template Population Strategy

The new granular structure uses **subtemplates** that get instantiated for each component. Populate in this order:

1. **Singleton templates** (project_overview.md, project_resources.md) - populated directly
2. **Overview/orchestrator templates** (intent_overview.md, dataset_overview.md) - populated with links to granular files
3. **Granular subtemplate instances** - created by copying from `.biospec/subtemplates/` and populating:
   - `project/intents/intent-{n}.md` (one per research question/aim/goal)
   - `project/datasets/dataset-{n}.md` (one per dataset)
   - `project/analyses/analysis-{n}.md` (one per analysis objective)

For each template, only fill fields with **high confidence** based on explicit user input.

### 4. Populate Singleton Templates

#### Template 1: project_overview.md

**Mandatory fields** (fill if available, leave blank otherwise):
- Project Title: From explicit mention or inferred from main topic
- Project Type: Use classification from step 2d
- Start Date: If mentioned, otherwise leave blank
- Expected Duration: If mentioned, otherwise leave blank
- Principal Investigator/Lead: If mentioned, otherwise leave blank
- Groups involved: If mentioned, otherwise leave blank

**Scientific Context**:
- Biological System: Fill organism/tissue/cell type if explicitly mentioned
- Biological Scale: Use controlled vocabulary from step 2b (comma-separated if multiple)
- Key Biological Processes: Extract from description if mentioned

**Project Scope**:
- Computational Activities in Scope: List specific tasks/tools mentioned
- Out of Scope: List exclusions mentioned, or infer conservative boundaries

**Brief Summary**:
- Write 2-3 sentences synthesizing the project purpose
- Focus on biological question and significance
- Include scale/system/approach

**Keywords**:
- Extract 5-10 comma-separated terms
- Include biological, technical, and methodological terms

**Prior Work**:
- Only fill if user mentions reference studies, papers, or methods to reproduce
- Leave blank if not mentioned (don't invent references)

### 5. Create and Populate Intent Subtemplate Instances

For each research question, aim, or goal identified in step 2c:

**Step 1**: Create directory `project/intents/` if not exists

**Step 2**: For each intent (numbered 1, 2, 3...):
1. Copy `.biospec/subtemplates/intent.md` to `project/intents/intent-{n}.md`
2. Update frontmatter:
   - `intent_id: {n}`
   - `intent_type: question | aim | goal` (based on classification from step 2c)
   - `last_updated: {current date}`
3. Populate fields:

**Short Identifier**: e.g., "RQ1-TME", "Aim1-CellTypes", "Goal1-Survival"

**Statement**:
- Type: Question | Aim | Goal
- Statement: The actual research question/aim/goal text

**Associated Hypothesis** (if applicable):
- **Has Testable Hypothesis**: Yes | No
- If Yes, fill hypothesis details:
  - Short ID: e.g., "H1-TcellResponse"
  - Statement: The hypothesis
  - Rationale: Why you expect this result
  - Null Hypothesis: "No association between X and Y"
  - Alternative Hypothesis: "Positive correlation between X and Y"
- If No or exploratory project: Leave blank or note "Exploratory - no specific hypothesis"

**Expected Outcomes**:
- Outcomes: What results are expected
- How to Measure: Measurement methods
- How to Communicate: e.g., "Plot of X vs Y", "Table showing Z"

**Success Criteria**:
- Criteria: What defines success
- Priority: High | Medium | Low

**Related Components**:
- Related Datasets: List dataset IDs (e.g., "dataset-1.md", "dataset-2.md")
- Related Analyses: List analysis IDs (e.g., "analysis-1.md")

**Step 3**: Repeat for all identified intents

**Example**:
If user mentions "We want to understand how tumor cells interact with immune cells" (question) and "We hypothesize that T cell infiltration correlates with response" (hypothesis):
- Create `project/intents/intent-1.md` with type="question", statement="How do tumor cells interact with immune cells?", has_hypothesis=Yes

### 6. Create and Populate Dataset Subtemplate Instances

For each dataset identified in step 2e:

**Step 1**: Create directory `project/datasets/` if not exists

**Step 2**: For each dataset (numbered 1, 2, 3...):
1. Copy `.biospec/subtemplates/dataset.md` to `project/datasets/dataset-{n}.md`
2. Update frontmatter:
   - `dataset_id: {n}`
   - `last_updated: {current date}`
3. Populate fields:

**Dataset Name/Identifier**: e.g., "Public melanoma scRNA-seq (GSE12345)", "Internal Visium cohort"

**Data Types**:
- Primary Data Type (And format): e.g., "scRNA-seq expression matrix (Anndata)"
- Supplementary Data Types: e.g., "Cell metadata (CSV)", "UMAP embeddings"
- Degree of processing: Primary | Secondary | Tertiary (from step 2e matching)
- Reference Data Required: e.g., "GRCh38" (if mentioned)
- Access: Public | In-house
- Year of creation: If mentioned

**Sample Information**:
- Total Samples: Numeric count
- Biological Replicates: Count if mentioned
- Technical Replicates: Count if mentioned
- Control Samples: Types and counts
- Batch Information: Batch structure if mentioned

**Metadata Requirements**:
- List required metadata fields
- Note what exists vs. needs creation

**Additional Information**:
- Free text dataset-specific details

**Publication Plans**:
- Note publication intentions if mentioned

**Data Status**:
- QC tasks completed: Leave blank unless stated
- QC tasks to complete: Infer standard QC for data type

**Related Components**:
- Addresses Intents: List intent IDs (e.g., "intent-1.md", "intent-2.md")
- Used in Analyses: List analysis IDs (e.g., "analysis-1.md")

**Step 3**: Repeat for all identified datasets

### 7. Create and Populate Analysis Subtemplate Instances

For each analysis objective identified in step 2c:

**Step 1**: Create directory `project/analyses/` if not exists

**Step 2**: For each analysis (numbered 1, 2, 3...):
1. Copy `.biospec/subtemplates/analysis.md` to `project/analyses/analysis-{n}.md`
2. Update frontmatter:
   - `analysis_id: {n}`
   - `priority: must-have | nice-to-have | future`
   - `last_updated: {current date}`
3. Populate fields:

**Short Descriptor**: e.g., "Differential Expression", "Cell Type Annotation", "Spatial Analysis"

**Description**: What this analysis entails

**Priority**:
- Priority Level: Must Have | Nice to Have | Future Consideration
- Justification: Why this priority

**Methods & Tools**:
- Analysis Type: e.g., "Differential expression", "Clustering"
- Tools/Packages: e.g., "Seurat", "DESeq2"
- Parameters/Settings: If mentioned

**Dependencies**:
- Sequential Dependencies: What must be done first
- Data Dependencies: Required inputs
- Technical Dependencies: Required tools/environments

**Expected Outputs**:
- Primary Outputs: Main results
- Intermediate Files: Temporary files
- Visualizations: Plots/figures

**Success Criteria**: How to know analysis succeeded

**Related Components**:
- Addresses Intents: List intent IDs
- Uses Datasets: List dataset IDs

**Step 3**: Repeat for all identified analyses

### 8. Populate Overview/Orchestrator Templates

#### Template: intent_overview.md

**Intents Section**:
- List of Intents: Add link for each created intent file: `[Intent {n}: {Short ID}](intents/intent-{n}.md)`
- Summary Table: Add row for each intent with ID, Type, Statement (brief), Has Hypothesis, Priority, Success Criteria

**Analyses Section**:
- Must Have: Link to high-priority analysis files
- Nice to Have: Link to moderate-priority analysis files
- Future Considerations: Link to future analysis files

**Project-Level Information**:
- Milestones: High-level milestones (extracted or generic: Data acquisition → QC → Analysis → Interpretation → Communication)
- Dependencies: Cross-cutting dependencies
- Expected Outputs: Primary and secondary deliverables

#### Template: dataset_overview.md

**Datasets Section**:
- List of Datasets: Add link for each created dataset file: `[Dataset {n}: {Name}](datasets/dataset-{n}.md)`
- Summary Table: Add row for each dataset with ID, Name, Source, Access, Data Type, Format, Size, Processing Level, Update Frequency

**Overall Data Strategy**:
- Data Integration Plan: How datasets will be integrated
- Cross-Dataset Considerations: Batch effects, normalization
- Data Sharing & Publication: Overall sharing strategy

### 9. Populate Resources Template

**Computing Resources**:
- Fill Hardware Specifications only if explicitly mentioned (CPU, RAM, GPU, OS)
- Environment: local | HPC | cloud | hybrid
  - Choose "HPC" if HPC/cluster mentioned
  - Choose "cloud" if AWS/GCP/Azure mentioned
  - Choose "local" if desktop/laptop mentioned
  - Otherwise leave blank

**HPC/Cloud Details**:
- Fill only if infrastructure explicitly mentioned
- Job submission method: If mentioned (SLURM, PBS, etc.)

**Storage Architecture**:
- Location: Infer from computing environment if possible
- Capacity Required: If data size mentioned, add 3-5x for working space
- Backup Strategy: Leave blank unless mentioned

**Version Control & Reproducibility**:
- Repository Type: Assume "git" unless specified otherwise
- Repository Name/Location: Fill if mentioned, otherwise leave blank
- Container Preference: Fill if Docker/Singularity/Conda mentioned
- Package Management: Infer from data type (e.g., R/Bioconductor for bulk RNA-seq, Python/scanpy for scRNA-seq)
- Environment Documentation Location: Leave blank initially

**SOP Availability/Paths**:
- Leave all blank unless specific SOPs are mentioned
- These are typically filled during project execution

### 10. Quality Validation

After populating all templates and subtemplate instances, validate completeness and consistency:

#### Validation Checklist

Run through this checklist and document pass/fail status:

**Content Quality** (across all templates):
- [ ] All high-confidence fields populated (no obvious blanks for explicit info)
- [ ] Controlled vocabulary used correctly (project types, biological scales, etc.)
- [ ] No implementation details leaked (specific code, file paths, etc.)
- [ ] Version numbers and timestamps updated
- [ ] Consistent terminology across templates
- [ ] All granular files properly linked in overview files

**project_overview.md**:
- [ ] Project type selected from controlled vocabulary
- [ ] Biological scale uses approved terms (genomic, transcriptomic, etc.)
- [ ] Brief summary is 2-3 sentences, focused on biological question
- [ ] Keywords include biological, technical, and methodological terms
- [ ] Scope section distinguishes in-scope vs out-of-scope clearly

**intent_overview.md**:
- [ ] All created intent files listed and linked
- [ ] Summary table includes all intents with accurate information
- [ ] Analyses categorized by priority (must-have, nice-to-have, future)
- [ ] All analysis files listed and linked
- [ ] Milestones and dependencies populated

**Individual intent files** (project/intents/intent-*.md):
- [ ] Intent type correctly classified (question, aim, goal)
- [ ] Hypothesis included only if testable prediction provided
- [ ] Hypotheses include null and alternative forms (if present)
- [ ] Short identifier consistent across files
- [ ] Related datasets and analyses properly linked

**dataset_overview.md**:
- [ ] All created dataset files listed and linked
- [ ] Summary table includes all datasets with accurate information
- [ ] Overall data strategy sections populated if multiple datasets

**Individual dataset files** (project/datasets/dataset-*.md):
- [ ] Each dataset has unique identifier
- [ ] Processing level specified (primary/secondary/tertiary)
- [ ] Sample information extracted (counts, replicates, controls)
- [ ] Related intents and analyses properly linked

**Individual analysis files** (project/analyses/analysis-*.md):
- [ ] Priority level specified (must-have/nice-to-have/future)
- [ ] Methods and tools mentioned if known
- [ ] Dependencies documented
- [ ] Related intents and datasets properly linked

**project_resources.md**:
- [ ] Computing environment specified (local/HPC/cloud/hybrid)
- [ ] Storage location matches computing environment
- [ ] Container/environment preference noted (even if "None")

#### Critical Gaps Check

**IMPORTANT**: These items are crucial for research rigor. If missing from user input, mark with [NEEDS CLARIFICATION]:

1. **Sample size adequacy**:
   - Can the stated sample sizes support statistical testing?
   - Is power analysis mentioned or needed?
   - Mark if: n < 3 replicates, small cohort for genomics (n < 10)

2. **Batch effects consideration**:
   - Are samples from multiple batches/timepoints?
   - Are technical replicates or controls included?
   - Mark if: Batch information exists but no QC plan mentioned

3. **Multiple testing correction**:
   - If many comparisons planned, is correction mentioned?
   - Mark if: Differential analysis planned but no mention of FDR/p-value adjustment

4. **Control samples**:
   - Are appropriate controls included (negative, reference, biological)?
   - Mark if: Experimental samples present but control strategy unclear

5. **Success criteria measurability**:
   - Can success criteria be objectively measured?
   - Mark if: Vague outcomes like "understand" or "explore" without specific metrics

**Clarification Prioritization** (spec-kit adapted):
- **Tier 1 (MUST clarify)**: Scientific rigor issues (power, controls, batch effects)
- **Tier 2 (SHOULD clarify)**: Data availability/access issues
- **Tier 3 (COULD clarify)**: Computational scope boundaries
- **Tier 4 (NICE to clarify)**: Technical resource details

**LIMIT**: Maximum **5 total [NEEDS CLARIFICATION]** markers across all templates
- Prioritize Tier 1 > Tier 2 > Tier 3 > Tier 4
- Make informed guesses for lower-priority ambiguities
- Document assumptions made

### 5. Generate Clarification Questions

If [NEEDS CLARIFICATION] markers remain (max 5):

#### Format for Each Question

Present questions using this structured format:

```markdown
## Question {N}: {Topic}

**Context**: {Quote relevant section from populated template showing the ambiguity}

**What we need to know**: {Specific question from [NEEDS CLARIFICATION] marker}

**Why this matters**: {Explain impact on project design, statistical validity, or feasibility}

**Suggested Approaches**:

| Option | Description | Implications | Risk Level |
|--------|-------------|--------------|------------|
| A | {Conservative approach} | {What this means for the project} | Low |
| B | {Moderate approach} | {What this means for the project} | Medium |
| C | {Aggressive/exploratory approach} | {What this means for the project} | High |
| Custom | Provide your own approach | You can specify alternative details | Varies |

**Recommendation**: {Which option is generally preferred for this type of research and why}

**Your choice**: _[Wait for user response]_
```

**CRITICAL - Table Formatting**:
- Use consistent spacing with pipes aligned
- Each cell should have spaces around content: `| Content |` not `|Content|`
- Header separator must have at least 3 dashes: `|--------|`
- Test that the table renders correctly in markdown preview

#### Question Sequencing

1. Number questions Q1, Q2, Q3, etc. (max 5 total)
2. Order by priority tier (Tier 1 first, then Tier 2, etc.)
3. Present all questions together in one message before waiting for responses
4. Wait for user to respond with choices for all questions (e.g., "Q1: A, Q2: Custom - [details], Q3: B")
5. Update templates by replacing each [NEEDS CLARIFICATION] marker with the user's selected or provided answer
6. Re-run validation after all clarifications resolved

### 12. Report Completion

After successful validation (with or without clarifications), report:

```markdown
## Project Charter Created: {Project Title}

**Location**: `project/` directory

**Overview Templates populated**:
- ✓ project_overview.md (version 0.1)
- ✓ intent_overview.md (version 0.1)
- ✓ dataset_overview.md (version 0.1)
- ✓ project_resources.md (version 0.1)

**Granular Components Created**:
- ✓ {n} Intent files in project/intents/
- ✓ {n} Dataset files in project/datasets/
- ✓ {n} Analysis files in project/analyses/

**Component Summary**:
- Intents: {list intent IDs and short identifiers}
- Datasets: {list dataset IDs and names}
- Analyses: {list analysis IDs and descriptors}

**Validation Status**: {Pass/Pass with assumptions/Needs review}

**Completion Summary**:
- Total granular files created: {count}
- High-confidence fields populated: {count}
- Fields left blank for review: {count}
- Assumptions documented: {count}
- Clarifications resolved: {count}

**Fields Requiring Manual Review** (if any):
- {file_name}: {field_name} - {reason}

**Critical Assumptions Made** (if any):
1. {Assumption description and rationale}

**Next Steps**:
1. Review all populated files for accuracy
   - Overview files: intent_overview.md, dataset_overview.md
   - Granular files: project/intents/*, project/datasets/*, project/analyses/*
2. Fill blank fields based on project knowledge
3. Verify cross-references between files are correct
4. Run `/biospec.validate_fields` to check completeness
5. Run `/biospec.review_intent` for critical assessment before proceeding

**Notes**:
- All templates start at version 0.1
- Update "Last updated" timestamp when making manual edits
- Granular structure allows independent versioning and review of components
- Overview files aggregate information from granular files - keep synchronized
```

### 13. Error Handling

Handle these error conditions:

| Error Condition | Action |
|----------------|--------|
| Empty user input | ERROR "No project description provided. Please provide a natural language description of your bioinformatics project." |
| No research question identifiable | ERROR "Cannot identify research question, aim, or goal. Please describe what you want to investigate or discover." |
| Completely ambiguous project type | Ask single clarification question about whether project is exploratory or hypothesis-driven |
| No datasets mentioned | WARN "No datasets identified. Templates created but dataset_overview.md left mostly blank. Please populate manually or create dataset files in project/datasets/." |
| Validation fails after 3 iterations | WARN "Some validation items remain incomplete. Review populated templates and granular files manually." Include specific failing items. |

---

## General Guidelines

### Conservative Population Philosophy

**DO**:
- Fill fields only when explicitly mentioned or clearly inferable
- Use blanks liberally for research-specific ambiguity
- Document assumptions in appropriate template sections
- Preserve template structure and checklists exactly
- Make informed guesses based on domain knowledge for standard practices

**DON'T**:
- Invent data that wasn't mentioned (sample sizes, specific tools, etc.)
- Assume specific computational approaches unless stated
- Fill reference papers unless explicitly mentioned
- Create hypotheses if the project is exploratory
- Guess at success criteria or statistical thresholds

### Controlled Vocabulary Reference

**Project Types**: exploratory | targeted | package development | workflow refactoring

**Biological Scales**: genomic | transcriptomic (scRNAseq, WTS, bulk RNA-seq) | proteomic | metabolomic | multi-omic | imaging | Phenocycler | Visium | Xenium | annotated pathology slides | SNP microarray | Organoid | Patient Derived Xenograft

**Processing Levels**: primary | secondary | tertiary

**Access Types**: Public | In-house

**Environment Types**: local | HPC | cloud | hybrid

**Container Types**: Docker | Singularity | Conda | None

### Pattern Recognition Examples

#### Example 1: Exploratory Project

**User input**:
"I want to explore the tumor microenvironment in melanoma patients. We have scRNA-seq data from 50 tumor samples. We'll use Seurat for analysis."

**Extraction**:
- Project type: exploratory (keyword "explore", no hypothesis)
- Biological scale: transcriptomic (scRNAseq)
- Research question: "What is the composition and organization of the tumor microenvironment in melanoma patients?" (inferred from "explore TME")
- Dataset: scRNA-seq, 50 samples, likely secondary processing level
- Computational scope: Seurat (in scope)
- Hypothesis: Leave blank (exploratory)

#### Example 2: Targeted Project

**User input**:
"We hypothesize that T cell infiltration correlates with response to immunotherapy in melanoma. We have Visium spatial transcriptomics from 20 patients (10 responders, 10 non-responders) and matched scRNA-seq. We want to test this using differential expression and cell proportion analysis."

**Extraction**:
- Project type: targeted (explicit hypothesis)
- Biological scale: multi-omic (spatial transcriptomics, scRNA-seq)
- Hypothesis: "T cell infiltration correlates with immunotherapy response"
  - Null: "No association between T cell infiltration and treatment response"
  - Alternative: "Positive correlation between T cell infiltration and treatment response"
- Research aim: "To determine if T cell infiltration predicts immunotherapy response"
- Datasets:
  - Dataset 1: Visium spatial, 20 patients, 10 responders/10 non-responders
  - Dataset 2: scRNA-seq, matched samples
- Analysis objectives: Differential expression analysis, cell proportion analysis
- Controls: Non-responders serve as controls

#### Example 3: Multiple Datasets

**User input**:
"We're analyzing three datasets: a public scRNA-seq dataset (GSE12345, 100 patients), our internal Phenocycler imaging (30 samples), and bulk RNA-seq from TCGA (500 samples). We want to understand immune cell states across these platforms."

**Extraction**:
- Project type: exploratory (keyword "understand", comparative)
- Biological scale: multi-omic (transcriptomic scRNAseq, imaging, transcriptomic WTS)
- Research question: "How do immune cell states compare across scRNA-seq, imaging, and bulk RNA-seq platforms?"
- Datasets:
  - Dataset 1: scRNA-seq (Public, GSE12345), 100 patients, secondary processing
  - Dataset 2: Phenocycler imaging (In-house), 30 samples, likely tertiary
  - Dataset 3: Bulk RNA-seq from TCGA (Public), 500 samples, secondary/tertiary
- Multi-platform integration challenge → note in dataset_overview.md or analysis files

### Special Cases

#### Case 1: No Hypothesis in Targeted-Sounding Project

If description sounds targeted but no hypothesis provided:
- Mark [NEEDS CLARIFICATION: hypothesis]
- Question format: "You mentioned testing/validating X. Do you have a specific hypothesis about the expected outcome?"
- If user says no → Change to exploratory project type

#### Case 2: Mentioned Tool Not Standard for Data Type

If user mentions tool unusual for data type (e.g., "analyze scRNA-seq with limma"):
- Don't second-guess - record as stated
- Note in analysis files or intent_overview.md if potentially problematic
- No [NEEDS CLARIFICATION] unless clearly impossible

#### Case 3: Very Brief Description

If description is < 2 sentences with minimal detail:
- Fill only project type, basic summary, and any explicitly mentioned items
- Leave most fields blank
- Report high number of "Fields requiring manual review"
- Suggest user run `/biospec.validate_fields` to identify gaps

#### Case 4: Multi-Phase Project

If description mentions phases/stages (e.g., "First QC, then clustering, then integration"):
- Capture phases as milestones in intent files
- Note dependencies between phases
- All analyses still go in computational scope (in project_overview.md)

---

## Validation Iteration Process

If validation fails on first pass:

### Iteration 1
1. Review failed checklist items
2. Re-examine user input for missed information
3. Update templates to address failures
4. Re-run validation checklist

### Iteration 2
1. If still failing, loosen requirements where appropriate
2. For genuinely missing information, prepare [NEEDS CLARIFICATION] markers
3. Re-run validation checklist

### Iteration 3 (final)
1. Accept incomplete fields if information genuinely unavailable
2. Document what's missing in "Fields Requiring Manual Review"
3. Proceed to completion report

**Maximum iterations**: 3
**After 3 iterations**: Proceed with warnings rather than blocking completion

---

## Notes

- The `project/` directory is the canonical location for the active project charter
- The `.biospec/` directory contains:
  - Pristine overview/orchestrator templates (do not modify)
  - `.biospec/subtemplates/` directory with master subtemplates (do not modify)
- Granular structure benefits:
  - Individual intents, datasets, and analyses can be versioned separately
  - Easier to review specific components in pull requests
  - Better organization and maintainability
  - Clear separation of concerns
- Overview files (intent_overview.md, dataset_overview.md) aggregate information from granular files
- Cross-references between files use relative paths
- Users can run this command multiple times to regenerate from updated descriptions
- This command focuses on initial population - refinement happens through manual editing or other commands (`/biospec.validate_fields`, `/biospec.review_intent`)
- When in doubt, err on the side of leaving fields blank rather than guessing

