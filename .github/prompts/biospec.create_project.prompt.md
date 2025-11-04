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

Create a new `project/` directory in the repository root and copy all template files from `.biospec/` to `project/`:
- project_overview.md
- intent.md
- datasets.md
- project_resources.md
- relationships.md

Set initial metadata in each file:
- Version: 0.1
- Last updated: [Current date in YYYY-MM-DD format]

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

### 3. Template Population Order

Populate templates in dependency order. For each template, only fill fields with **high confidence** based on explicit user input.

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

#### Template 2: intent.md

**Research Questions/Aims**:
- **Primary**: Extract the main question or aim using classification from step 2c
- Assign a short identifier (e.g., "RQ1-TME" for tumor microenvironment question)
- **Secondary**: List additional questions/aims if mentioned
- For each, specify how to measure and communicate outcomes if mentioned

**Hypotheses**:
- Only fill if user explicitly states a hypothesis or testable prediction
- **Primary Hypothesis**: The main prediction being tested
  - Generate short ID (e.g., "H1-TcellResponse")
  - State the hypothesis clearly
  - Formulate null hypothesis (e.g., "No association between X and Y")
  - Formulate alternative hypothesis (e.g., "Positive correlation between X and Y")
  - Add rationale if provided in description
- **Supporting Hypotheses**: Secondary predictions if mentioned

**IMPORTANT**: If the project is exploratory with no specific hypothesis, leave the hypothesis section blank or note "Exploratory study - no specific hypothesis"

**Analysis Objectives**:
- **Must Have**: Primary analysis tasks mentioned (high priority)
- **Nice to Have**: Secondary analyses if mentioned (moderate priority)
- **Future Considerations**: Mentioned extensions or follow-ups (low priority)

**Milestones**:
- Extract high-level milestones if mentioned
- Otherwise, create 3-5 generic milestones: Data acquisition → QC → Analysis → Interpretation → Communication

**Dependencies**:
- Note sequential requirements if mentioned (e.g., "need cell annotations before CNV analysis")

**Expected Outputs**:
- **Primary Deliverables**: Main outputs mentioned (figures, reports, manuscripts)
- **Secondary Deliverables**: Additional outputs if mentioned

**Summary Table**:
- Populate with RQ/Aim, Outcome, Measurement Method, Success Criteria, Priority for each question/aim
- Leave Success Criteria blank initially (often requires clarification)

#### Template 3: datasets.md

For each dataset identified in step 2e:

**Dataset {N}: {Name/Identifier}**

**Data Types**:
- Primary Data Type: e.g., "scRNA-seq expression matrix (Anndata)"
- Supplementary Data Types: e.g., "Cell metadata (CSV)", "UMAP embeddings"
- Degree of processing: primary | secondary | tertiary (use matching from step 2e)
- Reference Data Required: e.g., "GRCh38", "10X reference genome" (if mentioned)
- Access: Public | In-house (mark Public if accession number given, otherwise assume In-house)
- Year of creation: If mentioned

**Sample Information**:
- Extract counts mentioned: "50 patients", "3 replicates", "tumor and normal pairs"
- Total Samples: Numeric count if available
- Biological Replicates: If mentioned
- Technical Replicates: If mentioned
- Control Samples: If mentioned (negative controls, reference samples)
- Batch Information: Note if batches, cohorts, or temporal collection mentioned

**Metadata Requirements**:
- List metadata needed: clinical variables, technical covariates, sample annotations
- Note what exists vs. what needs to be created/obtained

**Additional Information**:
- Any other dataset-specific details from description

**Publication Plans**:
- Note if manuscript, technical report, or wider study component mentioned

**Data Status**:
- QC tasks completed: Leave blank unless explicitly stated
- QC tasks to complete: Infer standard QC for data type (e.g., "Quality filtering, doublet removal" for scRNA-seq)

**Summary Table** (at top):
- Populate table row for each dataset with Source, Access, Format, Size, Update Frequency
- Use "Unknown" for Size if not mentioned
- Use "Static" for Update Frequency unless ongoing collection mentioned

#### Template 4: project_resources.md

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

#### Template 5: relationships.md

This template validates consistency across other templates.

**Research Questions/Aims vs Datasets**:

For each RQ/Aim in intent.md:
1. List which dataset(s) from datasets.md can address it
2. Describe what each dataset contributes
3. Identify pros: strengths of dataset for answering question (sample size, resolution, controls)
4. Identify cons: limitations (sample size, missing metadata, processing level, batch effects)

**Format example**:
```
### RQ1-TME: How do tumor cells interact with immune cells in melanoma?

**Relevant Datasets**:
- Dataset 1 (scRNA-seq, 50 patients): Provides single-cell resolution of TME composition
  - **Pros**: Large sample size, paired tumor/normal, cell-level resolution
  - **Cons**: Lack of spatial information, potential droplet bias
- Dataset 2 (Visium spatial, 10 patients subset): Provides spatial context
  - **Pros**: Spatial relationships preserved, matched to scRNA-seq
  - **Cons**: Lower resolution, smaller sample size
```

**Scope Check**:

Validate alignment between:
1. **Goals (intent.md) vs Scope (project_overview.md)**:
   - Do the research questions fit within "in-scope" computational activities?
   - Are there analysis objectives that exceed stated scope?
   - Flag misalignments: "Analysis objective X requires deep learning, which is marked out of scope"

2. **Computational Activities vs Available Data**:
   - Can stated objectives be achieved with available datasets?
   - Are there data gaps that prevent answering research questions?
   - Flag issues: "RQ requires longitudinal data but only cross-sectional samples available"

3. **Resource Requirements vs Stated Resources**:
   - Are computational resources sufficient for data types and analyses?
   - Flag if incompatible: "Processing 50 scRNA-seq samples requires HPC, but only local compute specified"

**Output format**:
```
**Alignment Status**: ✓ Aligned | ⚠ Minor misalignment | ✗ Major misalignment

**Issues identified**:
1. [Description of misalignment]
2. [Suggested resolution]
```

### 4. Quality Validation

After populating all templates, validate completeness and consistency:

#### Validation Checklist

Run through this checklist and document pass/fail status:

**Content Quality** (across all templates):
- [ ] All high-confidence fields populated (no obvious blanks for explicit info)
- [ ] Controlled vocabulary used correctly (project types, biological scales, etc.)
- [ ] No implementation details leaked (specific code, file paths, etc.)
- [ ] Version numbers and timestamps updated
- [ ] Consistent terminology across templates

**project_overview.md**:
- [ ] Project type selected from controlled vocabulary
- [ ] Biological scale uses approved terms (genomic, transcriptomic, etc.)
- [ ] Brief summary is 2-3 sentences, focused on biological question
- [ ] Keywords include biological, technical, and methodological terms
- [ ] Scope section distinguishes in-scope vs out-of-scope clearly

**intent.md**:
- [ ] Research questions properly formatted as questions (interrogative)
- [ ] Research aims properly formatted as goal statements (infinitive)
- [ ] Hypotheses include null and alternative forms (if present)
- [ ] Hypotheses only included if explicitly testable prediction provided
- [ ] Analysis objectives categorized by priority (must/nice/future)
- [ ] Each RQ/Aim has a short identifier
- [ ] Summary table populated with all RQs/Aims

**datasets.md**:
- [ ] Each dataset has unique identifier (Dataset 1, Dataset 2, etc.)
- [ ] Processing level specified (primary/secondary/tertiary)
- [ ] Sample information extracted (counts, replicates, controls)
- [ ] Summary table includes all datasets
- [ ] Data status section includes relevant QC tasks for data type

**project_resources.md**:
- [ ] Computing environment specified (local/HPC/cloud/hybrid)
- [ ] Storage location matches computing environment
- [ ] Container/environment preference noted (even if "None")

**relationships.md**:
- [ ] All RQs/Aims from intent.md addressed
- [ ] Each RQ/Aim mapped to at least one dataset
- [ ] Pros/cons listed for each dataset-RQ pairing
- [ ] Scope check performed with alignment status
- [ ] Specific misalignments flagged with suggested resolutions

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

### 6. Report Completion

After successful validation (with or without clarifications), report:

```markdown
## Project Charter Created: {Project Title}

**Location**: `project/` directory

**Templates populated**:
- ✓ project_overview.md (version 0.1)
- ✓ intent.md (version 0.1)
- ✓ datasets.md (version 0.1)
- ✓ project_resources.md (version 0.1)
- ✓ relationships.md (version 0.1)

**Validation Status**: {Pass/Pass with assumptions/Needs review}

**Completion Summary**:
- Total fields populated: {count}
- High-confidence fields: {count}
- Fields left blank for review: {count}
- Assumptions documented: {count}
- Clarifications resolved: {count}

**Fields Requiring Manual Review** (if any):
- {template_name}: {field_name} - {reason}

**Critical Assumptions Made** (if any):
1. {Assumption description and rationale}

**Next Steps**:
1. Review all populated templates for accuracy
2. Fill blank fields based on project knowledge
3. Run `/biospec.validate_fields` to check completeness
4. Run `/biospec.review_intent` for critical assessment before proceeding

**Notes**:
- All templates start at version 0.1
- Update "Last updated" timestamp when making manual edits
- Template checklists are at the bottom of each file - mark as completed when done
```

### 7. Error Handling

Handle these error conditions:

| Error Condition | Action |
|----------------|--------|
| Empty user input | ERROR "No project description provided. Please provide a natural language description of your bioinformatics project." |
| No research question identifiable | ERROR "Cannot identify research question or aim. Please describe what you want to investigate or discover." |
| Completely ambiguous project type | Ask single clarification question about whether project is exploratory or hypothesis-driven |
| No datasets mentioned | WARN "No datasets identified. Templates created but datasets.md left mostly blank. Please populate manually." |
| Validation fails after 3 iterations | WARN "Some validation items remain incomplete. Review populated templates manually." Include specific failing items. |

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
- Multi-platform integration challenge → note in relationships.md

### Special Cases

#### Case 1: No Hypothesis in Targeted-Sounding Project

If description sounds targeted but no hypothesis provided:
- Mark [NEEDS CLARIFICATION: hypothesis]
- Question format: "You mentioned testing/validating X. Do you have a specific hypothesis about the expected outcome?"
- If user says no → Change to exploratory project type

#### Case 2: Mentioned Tool Not Standard for Data Type

If user mentions tool unusual for data type (e.g., "analyze scRNA-seq with limma"):
- Don't second-guess - record as stated
- Note in relationships.md scope check if potentially problematic
- No [NEEDS CLARIFICATION] unless clearly impossible

#### Case 3: Very Brief Description

If description is < 2 sentences with minimal detail:
- Fill only project type, basic summary, and any explicitly mentioned items
- Leave most fields blank
- Report high number of "Fields requiring manual review"
- Suggest user run `/biospec.validate_fields` to identify gaps

#### Case 4: Multi-Phase Project

If description mentions phases/stages (e.g., "First QC, then clustering, then integration"):
- Capture phases as milestones in intent.md
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
- The `.biospec/` directory contains the pristine templates (do not modify)
- Users can run this command multiple times to regenerate from updated descriptions
- This command focuses on initial population - refinement happens through manual editing or other commands (`/biospec.validate_fields`, `/biospec.review_intent`)
- When in doubt, err on the side of leaving fields blank rather than guessing
