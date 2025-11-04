---
description: Check biospec project charter template completeness and flag ambiguities with helpful guidance.
---

## User Input

```text
$ARGUMENTS
```

Optional: User may specify validation scope, mode, or specific templates.

**Examples**:
- Empty (default): Validate all templates in standard mode
- `intent.md`: Validate only the intent template
- `--mode strict`: Check required AND recommended fields, flag minor ambiguities
- `--mode quick`: Check only required fields, fast completeness check
- `--threshold incomplete`: Only flag blank/incomplete (skip ambiguities)
- `intent.md datasets.md`: Validate multiple specific templates

## Outline

The text after `/biospec.validate_fields` is optional and configures validation scope and strictness.

Given populated project charter templates, check completeness and clarity:

### 1. Parse Configuration

Extract user preferences from arguments:

**Validation Mode**:
- `standard` (default): Check required fields, flag obvious incomplete/ambiguous
- `strict`: Check required AND recommended, flag minor ambiguities, higher bar
- `quick`: Check only required fields, flag only blank/severely incomplete

**Completeness Threshold**:
- `all` (default): Show all validation findings (⬜🟨🟧)
- `incomplete`: Only show blank/incomplete (⬜🟨), skip ambiguous
- `blank`: Only show blank fields (⬜)

**Template Focus**:
- `all` (default): Validate all templates (overview, intent, datasets, resources, relationships)
- Specific template(s): Only validate named template(s)

**Help Mode**:
- `basic` (default): Moderate guiding questions
- `detailed`: Extensive guiding questions with examples
- `minimal`: Brief guidance only

### 2. Read Project Templates

Read templates from `project/` directory:

**Always validate** (if not template-focused):
1. `project/project_overview.md` - Project definition
2. `project/intent.md` - Research intent
3. `project/datasets.md` - Data documentation

**Optionally validate**:
4. `project/project_resources.md` - Resources and infrastructure
5. `project/relationships.md` - Cross-template alignment

**Error handling**:
- If `project/` directory doesn't exist: ERROR "No project/ directory found. Run /biospec.create_project or /biospec.parse_existing_project first."
- If all templates missing: ERROR "No templates found in project/. Cannot validate empty directory."
- If specific template requested but missing: ERROR "{template} not found in project/."

### 3. Inline Validation Comment Format

**CRITICAL**: All validation feedback MUST be appended directly to template fields using this format.

#### Format: Visible Validation Blocks

Use markdown blockquotes for high visibility:

```markdown
[Original field content or blank]

**[VALIDATION 2025-10-30]**
> ⬜ **BLANK: {Field Name} not specified**
> - **What's needed**: {Description of what should go in this field}
> - **Why it matters**: {Importance of this field}
> - **Examples**:
>   - {Example 1}
>   - {Example 2}
> - **Guiding questions**:
>   - {Question 1 to help user fill this field}
>   - {Question 2}

> 🟨 **INCOMPLETE: {Aspect} missing from {Field Name}**
> - **What's present**: {Summary of current content}
> - **What's missing**: {Specific missing components}
> - **How to complete**: {Instructions on what to add}
> - **Guiding questions**:
>   - {Question to help complete}

> 🟧 **AMBIGUOUS: {Aspect} lacks specificity**
> - **What's unclear**: {Specific ambiguity}
> - **Why specificity matters**: {Why this needs clarification}
> - **Guiding questions**:
>   - {Question to resolve ambiguity}
> - **Suggestion**: {How to make this more specific}
```

**Formatting rules**:
- **Date stamp**: Include validation date `[VALIDATION YYYY-MM-DD]`
- **Status emoji first**: ⬜ (blank), 🟨 (incomplete), 🟧 (ambiguous)
- **Bold title**: Field name and issue in bold
- **Blockquote wrapper**: All validation content in `>`
- **Consistent structure**: What's needed/present/missing/unclear, why, examples, guiding questions
- **Multiple issues**: Separate blockquotes for each status level

**Placement**:
- Append validation block **immediately after** the field being validated
- For section-level validation, append at end of section
- For dataset-level validation, append at end of dataset block

**No comment for complete fields**: If field is ✅ **COMPLETE**, no validation comment needed.

### 4. Validation Categories

Use 4 status levels to categorize each field:

#### ⬜ BLANK: Field is empty or contains only placeholder text

**Triggers**:
- Field is completely empty
- Contains only placeholder text: `{Insert...}`, `{X}`, `{...}`
- Contains TODO markers: `TODO`, `TBD`, `TBA`, `FIXME`
- Contains template defaults: `YYYY-MM-DD` in date fields
- Contains "None", "N/A", "Not applicable" in required fields

**Validation comment structure**:
```markdown
> ⬜ **BLANK: {Field Name} not specified**
> - **What's needed**: Clear description of required content
> - **Why it matters**: Importance for project planning/execution
> - **Examples**: 2-3 concrete examples appropriate for the field
> - **Guiding questions**: 2-4 questions to help user fill field
```

**Action required**: Fill field with appropriate content

#### 🟨 INCOMPLETE: Field is partially filled but missing key components

**Triggers**:
- Field has some content but is missing essential components
- Examples:
  - Hypothesis without null/alternative
  - Dataset without sample count
  - Research question without measurement method
  - Analysis objective without specific tool/method
  - Controlled vocabulary field with invalid value

**Validation comment structure**:
```markdown
> 🟨 **INCOMPLETE: {Specific aspect} missing from {Field Name}**
> - **What's present**: Summary of current content
> - **What's missing**: Specific components that should be added
> - **How to complete**: Step-by-step or template for completion
> - **Guiding questions**: Questions to help identify missing pieces
```

**Action required**: Add missing components to make field complete

#### 🟧 AMBIGUOUS: Field is filled but unclear, vague, or could be interpreted multiple ways

**Triggers**:
- Vague quantifiers: "many", "several", "some", "few", "a lot"
- Vague descriptors: "standard", "typical", "normal", "common", "basic"
- Vague methods: "standard pipeline", "usual approach", "typical QC"
- Lacks specificity: "RNA-seq" (bulk? single-cell?), "clustering" (which algorithm?)
- Single-word where multi-word expected
- Circular definitions

**Validation comment structure**:
```markdown
> 🟧 **AMBIGUOUS: {Specific aspect} lacks specificity**
> - **What's unclear**: Precise description of ambiguity
> - **Why specificity matters**: Impact of ambiguity on planning/execution
> - **Guiding questions**: Questions to resolve ambiguity
> - **Suggestion**: Example of more specific phrasing
```

**Action recommended**: Clarify to remove ambiguity (lower priority than blank/incomplete)

#### ✅ COMPLETE: Field is adequately filled with clear, specific information

**Criteria**:
- Field has non-placeholder content
- All required components present
- Sufficiently specific and clear
- Uses controlled vocabulary where applicable
- No obvious ambiguities

**No validation comment**: Complete fields don't need validation comments

**Note**: "Complete" for validation ≠ scientifically rigorous. Run `/biospec.review_intent` for scientific rigor check.

### 5. Field-by-Field Validation Rules

Define required vs optional fields and validation criteria for each template:

#### project_overview.md Validation

**Required fields** (must be non-blank):

| Field | Validation Criteria | Common Issues |
|-------|---------------------|---------------|
| **Project Title** | Not placeholder, not too vague, >5 words preferred | "Untitled", "RNA-seq Analysis", "Project 1" |
| **Project Type** | One of: exploratory \| targeted \| package development \| workflow refactoring | Invalid values, multiple types |
| **Brief Summary** | >50 words, <200 words, explains purpose and significance | Too brief (<20 words), placeholder text |
| **Biological System: Organism** | Specific organism (not "various", "multiple") | Blank, "N/A", "human tissue" (which tissue?) |
| **Biological Scale** | From controlled vocabulary, matches datasets | Invalid values, "multi-omic" without listing modalities |
| **Computational Activities in Scope** | ≥1 specific activity listed | Blank, "various analyses", no specifics |

**Recommended fields** (should be filled in strict mode):

| Field | Validation Criteria |
|-------|---------------------|
| **Start Date** | Valid date format, not YYYY-MM-DD placeholder |
| **Expected Duration** | Specific timeframe (not "TBD") |
| **Principal Investigator/Lead** | Name(s) of actual people |
| **Keywords** | 5-10 terms covering biology, methods, data type |
| **Key Biological Processes** | Specific processes (not "various") |
| **Prior Work & Inspiration** | At least 1 reference study or paper |

**Controlled vocabulary checks**:
- **Project Type**: Must be one of approved values
- **Biological Scale**: Must be from approved list (genomic, transcriptomic (scRNAseq, WTS), proteomic, metabolomic, multi-omic, imaging, Phenocycler, Visium, Xenium, annotated pathology slides, SNP microarray, Organoid, Patient Derived Xenograft)

**Ambiguity checks**:
- Biological System too vague: "tissue" → which tissue? "cells" → which cell type?
- Scope items too vague: "data analysis" → what type? "QC" → which QC metrics/tools?
- Out of Scope empty when many In Scope items listed (probably something is out of scope)

#### intent.md Validation (Primary Focus)

**Required fields**:

| Field | Validation Criteria | Common Issues |
|-------|---------------------|---------------|
| **Primary Research Question OR Aim** | ≥1 item, specific and answerable | Blank, too vague ("analyze data") |
| **Short identifier** | For each RQ/Aim, 2-15 chars, unique | Missing, not short, duplicates |
| **Analysis Objectives (Must Have)** | ≥1 objective, specific method/tool | "Analyze data", "Run pipeline" (too vague) |
| **Expected Outputs (Primary)** | ≥1 deliverable | Blank, "results" (not specific) |

**Conditionally required**:
- **If Project Type = "targeted"**: Must have ≥1 Hypothesis with both null AND alternative
- **If Project Type = "exploratory"**: Hypotheses optional (but RQs required)

**Recommended fields**:
- **Outcomes** (for each RQ/Aim): How to measure AND communicate
- **Milestones**: High-level project phases
- **Dependencies**: Sequential requirements between objectives

**Format validation**:
- **Research Questions**: Should end with "?" (interrogative)
- **Research Aims**: Should start with "To..." (infinitive goal statement)
- **Hypotheses**: If present, must have null AND alternative

**Completeness checks**:
- **Hypothesis components**: If hypothesis present:
  - Statement ✓
  - Rationale (recommended)
  - Null hypothesis ✓
  - Alternative hypothesis ✓
- **Outcomes components**: If outcomes specified:
  - How to measure ✓
  - How to communicate ✓
- **Summary Table**: Should include all RQs/Aims listed above

**Ambiguity checks**:
- RQ/Aim too broad: "Understand X" → what specifically about X?
- Analysis objective lacks method: "Clustering" → which algorithm? parameters?
- Measurement method vague: "Quantify" → how? which tool? what metric?
- Communication method vague: "Plot" → what type of plot? what on axes?

#### datasets.md Validation

**Required fields per dataset**:

| Field | Validation Criteria | Common Issues |
|-------|---------------------|---------------|
| **Dataset Name/Identifier** | Unique across datasets, descriptive | "Dataset 1", "Data", duplicate names |
| **Primary Data Type** | Specific data type and format | "Sequencing data" (which type?), format missing |
| **Degree of processing** | One of: primary \| secondary \| tertiary | Invalid values, blank |
| **Access** | One of: Public \| In-house | Invalid values, blank |
| **Total Samples** | Numeric estimate or count | "Many", "Unknown", "TBD", blank |

**Recommended fields per dataset**:
- **Supplementary Data Types**: Additional data beyond primary
- **Reference Data Required**: Genome version, annotation version
- **Biological Replicates**: Count or description
- **Control Samples**: Types and counts of controls
- **Batch Information**: Batch structure if multi-batch
- **QC tasks to complete**: Specific QC steps for this data type

**Minimum validation**:
- At least 1 dataset defined
- Each dataset has unique identifier

**Format validation**:
- **Total Samples**: Should be a number or numeric range (not text like "many")
- **Processing level**: From controlled vocabulary

**Summary table validation**:
- All datasets appear in summary table
- Table has all required columns

**Ambiguity checks**:
- Data type too vague: "RNA-seq" → bulk or single-cell? strand-specific?
- Format not specified: "Expression matrix" → what file format? h5ad? csv? rds?
- Processing level unclear: Described as "processed" but not primary/secondary/tertiary
- Sample count vague: "Approximately 50" is okay, "several" is not
- QC vague: "Standard QC" → which metrics? thresholds? tools?

#### project_resources.md Validation

**Required fields**:

| Field | Validation Criteria | Common Issues |
|-------|---------------------|---------------|
| **Environment** | One of: local \| HPC \| cloud \| hybrid | Invalid values, blank |
| **Repository Type** | Usually "git" | Blank |
| **Container Preference OR Package Management** | At least one specified | Both blank |

**Recommended fields** (especially if HPC/cloud):
- **Hardware Specifications**: CPU, RAM (if HPC/cloud)
- **Storage: Capacity Required**: With units (GB, TB)
- **Environment Documentation Location**: Path to environment files

**Controlled vocabulary checks**:
- **Environment**: Must be from approved values
- **Container Preference**: If specified, one of: Docker | Singularity | Conda | None

**Ambiguity checks**:
- Container "None" but complex dependency list → should specify package management
- Environment "local" but computational scope suggests HPC needs
- Capacity "large" → how large? give estimate in GB/TB

#### relationships.md Validation

**Required sections**:

| Section | Validation Criteria | Common Issues |
|---------|---------------------|---------------|
| **RQ/Aim vs Datasets mapping** | All RQs from intent.md mapped to ≥1 dataset | Missing RQs, unmapped datasets |
| **Scope Check** | Alignment status specified | Status missing, format wrong |

**Mapping validation**:
- All RQs/Aims from intent.md should appear in relationships.md
- All datasets from datasets.md should appear in relationships.md
- Each RQ/Aim mapped to at least 1 dataset

**Format validation**:
- **Alignment status**: Should use ✓ Aligned | ⚠ Minor misalignment | ✗ Major misalignment
- **Pros/cons**: Each dataset-RQ pairing should have pros AND cons listed

**Completeness checks**:
- No orphaned RQs (RQ exists but not mapped to any dataset)
- No orphaned datasets (dataset exists but not mapped to any RQ)

### 6. Placeholder Detection Patterns

Automatically flag these as BLANK:

**Bracket placeholders**:
- `{Insert...}`, `{X}`, `{n}`, `{...}`, `{YYYY}`, etc.
- Any text enclosed in curly braces that looks like a placeholder

**TODO markers**:
- `TODO`, `TBD`, `TBA`, `FIXME`, `XXX`, `FILL IN`
- Case-insensitive matching

**Template defaults**:
- `YYYY-MM-DD` in date fields
- `{0.1}` in version fields (should be updated to actual version)

**Null indicators in required fields**:
- "None", "N/A", "Not applicable", "Unknown" in required fields
- Empty list markers: "- " with nothing after

**Example text as content**:
- Fields starting with "Example:", "e.g.,", "For example"
- These are likely leftover template examples, not actual content

### 7. Ambiguity Detection Patterns

Flag these patterns as AMBIGUOUS:

**Vague quantifiers**:
- "many", "several", "some", "few", "a lot", "numerous", "multiple"
- "approximately" without number (okay: "approximately 50", not okay: "approximately many")

**Vague descriptors**:
- "standard", "typical", "normal", "common", "basic", "usual", "general"
- "various", "different", "diverse" without specifics

**Vague methods**:
- "standard pipeline", "typical approach", "usual method"
- "standard QC", "normal filtering", "common normalization"

**Incomplete method specifications**:
- "clustering" → which algorithm (Leiden, Louvain, k-means)?
- "differential expression" → which method (DESeq2, edgeR, limma)?
- "normalization" → which method (TMM, median-of-ratios, SCTransform)?
- "alignment" → which tool (STAR, HISAT2, BWA)?

**Data type insufficiency**:
- "RNA-seq" → bulk or single-cell? stranded?
- "sequencing" → which type?
- "imaging" → which modality?

**Single-word where multi-word expected**:
- Brief Summary: Single sentence or less
- Biological System: Just "human" (missing tissue/cell type)
- Keywords: Only 1-2 keywords

**Circular definitions**:
- Defining X by saying "X analysis" or "analysis of X"

### 8. Guiding Questions by Field Type

Provide helpful questions to guide users in filling/completing/clarifying fields:

#### For Research Questions/Aims

**If BLANK**:
- What are you trying to discover or understand?
- What question will your analysis answer?
- Is this exploratory (broad question) or hypothesis-driven (specific question)?
- Can you phrase this as a specific question ending with "?"?

**If INCOMPLETE** (missing measurement/communication):
- How will you measure the outcome? (quantitative metric, qualitative assessment)
- How will you communicate the results? (figure type, table, statistical test)
- What would a successful answer look like?

**If AMBIGUOUS**:
- Can you make this more specific? (from "understand X" to "quantify X")
- What specific aspect of X are you investigating?
- Is this answerable with your stated data and methods?

#### For Hypotheses

**If BLANK** (but project type is "targeted"):
- What is your expected outcome?
- What do you predict will happen?
- Why do you expect this result? (rationale)

**If INCOMPLETE** (missing null or alternative):
- What would you observe if your hypothesis is WRONG? (null hypothesis)
- What would you observe if your hypothesis is RIGHT? (alternative hypothesis)
- Is this a directional (positive/negative) or non-directional (any association) hypothesis?

**If AMBIGUOUS**:
- Can you state this as a testable prediction?
- What is the specific relationship you expect to find?
- What evidence would support vs refute this hypothesis?

#### For Datasets

**If BLANK** (dataset information missing):
- Where will this data come from? (source, accession number, file path)
- What is the exact format? (file type, schema)
- How many samples do you have (or estimate)?
- What processing has already been done?

**If INCOMPLETE** (missing components):
- How many biological replicates per condition?
- Do you have control samples? What type?
- What reference data is required? (genome version, annotation)
- What metadata is available with this dataset?

**If AMBIGUOUS**:
- Which specific type of [data type]? (e.g., bulk RNA-seq vs scRNA-seq)
- What file format exactly? (h5ad, csv, rds, fastq.gz, etc.)
- "Processed" - to what level? (primary/secondary/tertiary)
- "Standard QC" - which specific metrics and thresholds?

#### For Analysis Objectives

**If BLANK**:
- What analyses will you perform?
- What are the computational steps?
- What tools/methods will you use?

**If INCOMPLETE** (missing method/tool):
- Which specific tool or package? (name and version)
- What are the key parameters?
- What are the input requirements?
- What are the expected outputs?

**If AMBIGUOUS**:
- "Clustering" - which algorithm? (Leiden, Louvain, k-means, hierarchical)
- "Normalization" - which method? (depends on data type)
- "Filtering" - which criteria? (thresholds, metrics)
- "Pipeline" - can you break this into specific steps?

#### For QC Plans

**If BLANK**:
- What quality metrics will you check?
- What are your threshold values?
- What will you do with failing samples?

**If AMBIGUOUS**:
- "Standard QC" - which specific QC metrics for your data type?
  - scRNA-seq: % mito genes, total counts, genes per cell, doublet score
  - Bulk RNA-seq: mapping rate, duplication rate, gene body coverage
  - Genomics: coverage depth, mapping quality, variant quality
- What are the threshold values? (e.g., >200 genes/cell, <5% mito)
- Which tools? (scanpy, scater, FastQC, MultiQC, etc.)

#### For Computational Scope

**If BLANK**:
- What computational activities are in scope?
- What tools/methods will you use?
- What is explicitly out of scope?

**If AMBIGUOUS**:
- "Data analysis" - what type? (differential expression, clustering, pathway analysis)
- "Machine learning" - which algorithms? (supervised, unsupervised, specific methods)
- Can you list specific tools/packages rather than general categories?

### 9. Controlled Vocabulary Validation

Check that certain fields use approved values:

#### Project Type

**Approved values**: `exploratory | targeted | package development | workflow refactoring`

**Invalid examples**: "research", "analysis", "study", "project"

**Validation**: If value not in approved list, flag as INCOMPLETE with guidance to choose from approved values

#### Biological Scale

**Approved values**:
- genomic
- transcriptomic (scRNAseq, WTS, bulk RNA-seq)
- proteomic
- metabolomic
- multi-omic
- imaging
- Phenocycler
- Visium
- Xenium
- annotated pathology slides
- SNP microarray
- Organoid
- Patient Derived Xenograft

**Invalid examples**: "sequencing", "omics", "molecular", "cellular"

**Validation**: Must use terms from approved list. If multi-omic, should specify which modalities.

#### Processing Level (datasets.md)

**Approved values**: `primary | secondary | tertiary`

**Invalid examples**: "raw", "processed", "analyzed", "level 1"

**Guidance if invalid**:
- primary: Raw, unprocessed data (FASTQ, raw images)
- secondary: Processed, analysis-ready (count matrix, aligned reads, normalized)
- tertiary: Analyzed results (DE genes, clusters, annotated cells)

#### Access (datasets.md)

**Approved values**: `Public | In-house`

**Invalid examples**: "private", "restricted", "open", "available"

#### Environment (project_resources.md)

**Approved values**: `local | HPC | cloud | hybrid`

**Invalid examples**: "server", "cluster", "workstation", "desktop"

#### Container Preference (project_resources.md)

**Approved values**: `Docker | Singularity | Conda | None`

**Invalid examples**: "container", "virtual", "yes", "no"

### 10. Cross-Template Consistency Checks

Validate alignment across templates:

#### RQ/Aim Consistency

**Check**: All RQs/Aims in intent.md appear in relationships.md

**If inconsistent**:
```markdown
> 🟨 **INCOMPLETE: Research question not mapped in relationships.md**
> - **What's missing**: RQ1-TME from intent.md does not appear in relationships.md
> - **How to complete**: Add RQ1-TME to relationships.md with dataset mapping
> - **Location to update**: relationships.md, "Research Questions/Aims vs Datasets" section
```

#### Dataset Consistency

**Check**: All datasets in datasets.md appear in relationships.md

**If inconsistent**: Flag as INCOMPLETE in relationships.md

#### Biological Scale Consistency

**Check**: Biological Scale in project_overview.md matches data types in datasets.md

**Example inconsistency**:
- project_overview.md says "Biological Scale: transcriptomic (scRNAseq)"
- datasets.md has "Dataset 1: Proteomics data"

**If inconsistent**: Flag AMBIGUOUS in project_overview.md or datasets.md (whichever is wrong)

#### Computational Activities vs Analysis Objectives

**Check**: Activities listed in project_overview.md align with objectives in intent.md

**Example inconsistency**:
- project_overview.md: "Computational Activities: Differential expression, pathway analysis"
- intent.md: Analysis Objectives include "Cell type annotation, spatial analysis"

**If inconsistent**: Flag INCOMPLETE in project_overview.md (missing activities) or intent.md (orphaned objectives)

### 11. Calculate Completeness Metrics

For each template and overall:

**Field counting**:
1. Count total fields (required + recommended)
2. Count blank fields (⬜)
3. Count incomplete fields (🟨)
4. Count ambiguous fields (🟧)
5. Count complete fields (✅)

**Completeness percentage**:
- Required fields: (complete + ambiguous) / total required × 100%
- All fields: (complete + ambiguous) / total all × 100%

**Status determination**:
- ≥90%: Excellent
- 70-89%: Good
- 50-69%: Fair
- <50%: Needs Work

**Overall completeness**: Weighted average across templates
- intent.md: 40% weight (most critical)
- datasets.md: 30% weight
- project_overview.md: 20% weight
- relationships.md: 5% weight
- project_resources.md: 5% weight

### 12. Generate Validation Report

Create `project/_validation_report.md`:

```markdown
# Validation Report: {Project Title}

**Validated**: {YYYY-MM-DD}
**Validation Mode**: {standard | strict | quick}
**Completeness Threshold**: {all | incomplete | blank}
**Help Mode**: {basic | detailed | minimal}

## Overall Status

**Overall Completeness**: {X}% ({status: Excellent | Good | Fair | Needs Work})

```
Progress: [████████████░░░░░░░░] {X}%
```

**Validation Summary**:
- ⬜ **Blank**: {count} fields ({count_required} required, {count_recommended} recommended)
- 🟨 **Incomplete**: {count} fields
- 🟧 **Ambiguous**: {count} fields
- ✅ **Complete**: {count} fields

---

## Templates Validated

### project_overview.md: {X}%

```
Progress: [███████████████░░░░░] {X}%
```

**Status**: {Excellent | Good | Fair | Needs Work}

**Fields**:
- Required: {complete}/{total} ({X}%)
- Recommended: {complete}/{total} ({X}%)

**Issues**:
- ⬜ Blank: {count} fields
- 🟨 Incomplete: {count} fields
- 🟧 Ambiguous: {count} fields

**Blank Required Fields** (must address):
{If any, list field names}

**Blank Recommended Fields**:
{If any, list field names}

### intent.md: {X}%

```
Progress: [████████████░░░░░░░░] {X}%
```

**Status**: {Excellent | Good | Fair | Needs Work}

**Fields**:
- Required: {complete}/{total} ({X}%)
- Recommended: {complete}/{total} ({X}%)

**Issues**:
- ⬜ Blank: {count} fields
- 🟨 Incomplete: {count} fields
- 🟧 Ambiguous: {count} fields

**Blank Required Fields** (must address):
{If any, list field names}

### datasets.md: {X}%

```
Progress: [██████████████████░░] {X}%
```

**Status**: {Excellent | Good | Fair | Needs Work}

**Datasets Defined**: {count}

**Fields per dataset** (average):
- Required: {complete}/{total} ({X}%)
- Recommended: {complete}/{total} ({X}%)

**Issues**:
- ⬜ Blank: {count} fields
- 🟨 Incomplete: {count} fields
- 🟧 Ambiguous: {count} fields

### project_resources.md: {X}%

```
Progress: [██████████░░░░░░░░░░] {X}%
```

**Status**: {Excellent | Good | Fair | Needs Work}

**Issues**: {count} blank, {count} incomplete, {count} ambiguous

### relationships.md: {X}%

```
Progress: [████████████████░░░░] {X}%
```

**Status**: {Excellent | Good | Fair | Needs Work}

**Consistency Checks**:
- ✓ All RQs mapped to datasets: {Yes | No}
- ✓ All datasets mapped to RQs: {Yes | No}
- ✓ Scope alignment specified: {Yes | No}

**Issues**: {count} blank, {count} incomplete, {count} ambiguous

---

## Priority Actions

### 🔴 Must Complete (Blank Required Fields)

{If any blank required fields exist:}

These fields are required for template completeness:

1. **intent.md: Primary Research Question**
   - Status: ⬜ BLANK
   - Why required: Every project needs at least one research question
   - See inline guidance in template

2. **datasets.md: Dataset 1 - Total Samples**
   - Status: ⬜ BLANK
   - Why required: Sample size affects statistical power and analysis design
   - See inline guidance in template

[Continue for all blank required fields]

{If no blank required fields:}

✅ **All required fields are filled!**

### 🟡 Should Complete (Incomplete Fields)

{If any incomplete fields exist, list top 5-10}

1. **intent.md: Primary Hypothesis - Missing null/alternative**
2. **datasets.md: Dataset 1 - Missing biological replicate count**
3. [Continue]

### 🟠 Consider Clarifying (Ambiguous Fields)

{If any ambiguous fields exist, list top 5}

1. **project_overview.md: "Standard QC" in scope**
2. **datasets.md: "RNA-seq" lacks specificity**
3. [Continue]

---

## Controlled Vocabulary Issues

{If any controlled vocabulary violations:}

These fields must use approved values:

1. **project_overview.md: Project Type = "research"**
   - Invalid value: "research"
   - Must be one of: exploratory | targeted | package development | workflow refactoring
   - See controlled vocabulary reference in validation output

[Continue for all violations]

---

## Cross-Template Consistency Issues

{If any consistency issues:}

1. **Missing RQ mapping**: RQ2-survival in intent.md not mapped in relationships.md
2. **Orphaned dataset**: Dataset 3 in datasets.md not mapped to any RQ in relationships.md
3. **Scale mismatch**: project_overview.md says "scRNA-seq" but datasets.md has "proteomics"

[Continue for all issues]

---

## Recommendations

### Immediate Actions

1. **Fill {count} blank required fields** (highest priority)
2. **Complete {count} incomplete fields** with missing components
3. **Fix {count} controlled vocabulary violations**
4. **Resolve {count} cross-template consistency issues**

### Secondary Actions

1. **Clarify {count} ambiguous fields** for better specificity
2. **Fill {count} blank recommended fields** (especially in strict mode)
3. **Add missing details** to partially complete fields

### After Completion

1. **Re-run validation**: `/biospec.validate_fields` to verify fixes
2. **Track progress**: Note improvement from {current}% to target >90%
3. **Scientific review**: Once >90% complete, run `/biospec.review_intent` for rigor check

---

## Next Steps

1. ✅ **Review validation comments** in template files (marked `[VALIDATION {date}]`)
2. ⬜ **Address blank required fields** listed above
3. 🟨 **Complete incomplete fields** with missing information
4. 🟧 **Clarify ambiguous fields** using guiding questions
5. 🔄 **Re-validate**: `/biospec.validate_fields` to check progress
6. 📊 **Track improvement**: Current {X}% → Target >90%
7. 🔬 **Scientific review**: When >90% complete, run `/biospec.review_intent`

---

## Completeness by Category

| Category | Count | Status |
|----------|-------|--------|
| Required - Complete | {count} | ✅ |
| Required - Blank | {count} | ⬜ |
| Required - Incomplete | {count} | 🟨 |
| Recommended - Complete | {count} | ✅ |
| Recommended - Blank | {count} | ⬜ |
| Recommended - Incomplete | {count} | 🟨 |
| Ambiguous (any) | {count} | 🟧 |
| **Total Complete** | {count}/{total} | {X}% |

---

## Notes

- Detailed validation comments appended inline to each template field
- Validation comments marked with `[VALIDATION {date}]` and status emoji
- Templates updated with validation metadata and version stamps
- This checks **COMPLETENESS and CLARITY** only
- For **SCIENTIFIC RIGOR**, run `/biospec.review_intent` after templates are >90% complete
- Validation can be re-run multiple times to track progress

---

*Generated by biospec.validate_fields - checks template completeness and flags ambiguities with helpful guidance.*
```

### 13. Update Template Metadata

After validation, update each template:

**Version stamp**:
```markdown
*Document version: {0.1-validated-20251030} | Last updated: 2025-10-25 | Last validated: 2025-10-30*
```

**Add validation history section** at end of template:
```markdown
---
## Validation History

### Validation 2025-10-30
- **Validator**: biospec.validate_fields
- **Mode**: standard
- **Completeness**: 75% (30/40 fields)
- **Issues**: ⬜ 5 Blank | 🟨 3 Incomplete | 🟧 2 Ambiguous
- **Status**: Fair - needs completion
- **Required fields**: 15/18 complete (83%)
- **Recommended fields**: 15/22 complete (68%)
```

### 14. Report Completion

After validation complete, output summary message:

```markdown
## Validation Complete: {Project Title}

**Templates Validated & Updated**:
- ✓ project_overview.md ({X}% complete)
- ✓ intent.md ({X}% complete)
- ✓ datasets.md ({X}% complete)
- ✓ project_resources.md ({X}% complete)
- ✓ relationships.md ({X}% complete)

**Overall Completeness**: {X}% ({status})

```
Overall:    [████████████░░░░░░░░] {X}%
Overview:   [███████████████░░░░░] {X}%
Intent:     [████████████░░░░░░░░] {X}%
Datasets:   [██████████████████░░] {X}%
Resources:  [██████████░░░░░░░░░░] {X}%
Relations:  [████████████████░░░░] {X}%
```

**Validation Report**: `project/_validation_report.md`

**Validation Summary**:
- ⬜ **Blank**: {count} ({count_required} required)
- 🟨 **Incomplete**: {count}
- 🟧 **Ambiguous**: {count}
- ✅ **Complete**: {count}

{If blank required fields:}
⚠️ **{count} REQUIRED FIELDS BLANK** - Must complete:

1. {template}: {field_name}
2. {template}: {field_name}
[List up to 5 most critical]

See detailed list in validation report.

{If no blank required fields but <90% complete:}
✅ **All required fields filled!**

📋 {count} fields incomplete or ambiguous - see validation report for details.

{If ≥90% complete:}
🎉 **Excellent completeness ({X}%)!**

Templates are well-documented. Consider running `/biospec.review_intent` for scientific rigor check.

---

**Next Steps**:

1. **Review inline validation** (look for `[VALIDATION {date}]` blocks in templates)
2. **Address blank required fields** (⬜) if any
3. **Complete incomplete fields** (🟨) with missing components
4. **Clarify ambiguous fields** (🟧) using guiding questions
5. **Re-validate**: `/biospec.validate_fields` to track progress
6. **When >90% complete**: Run `/biospec.review_intent` for scientific rigor check

---

**Progress Tracking**:

- Current: {X}% complete
- Target: >90% for excellent documentation
- Improvement needed: {90-X}% ({count} fields)

**Validation vs Review**:
- ✅ **This validation** checks COMPLETENESS and CLARITY
- 🔬 **After >90% complete**, run `/biospec.review_intent` to check SCIENTIFIC RIGOR

---

**Note**: Validation can be re-run any time to check progress. Each run updates the validation report and shows improvement over time.
```

### 15. Error Handling

Handle these error conditions:

| Error Condition | Action |
|----------------|--------|
| No `project/` directory | ERROR "No project/ directory found. Run /biospec.create_project or /biospec.parse_existing_project first." |
| All templates missing | ERROR "No templates found in project/. Cannot validate empty directory." |
| Specific template requested but missing | ERROR "{template} not found in project/. Available templates: {list}." |
| Invalid mode | ERROR "Unknown mode: {mode}. Valid options: standard, strict, quick" |
| Invalid threshold | ERROR "Unknown threshold: {threshold}. Valid options: all, incomplete, blank" |
| Invalid help mode | ERROR "Unknown help mode: {mode}. Valid options: basic, detailed, minimal" |
| Template read error | ERROR "Cannot read template: {template}. Check file permissions." |
| Template write error | ERROR "Cannot write to template: {template}. Check file permissions." |

---

## General Guidelines

### Validation Philosophy

**Focus on completeness and clarity**, not scientific validity:

**DO**:
- Check if fields are filled (blank vs present)
- Check if fields are complete (missing components)
- Check if fields are clear (ambiguous vs specific)
- Provide helpful guiding questions
- Suggest concrete examples
- Use encouraging, helpful tone

**DON'T**:
- Judge scientific rigor (that's review_intent's job)
- Challenge hypotheses or methods
- Question sample sizes (unless field is blank/ambiguous)
- Apply statistical scrutiny
- Be skeptical or critical

**Validation = Administrative completeness check**
**Review = Scientific rigor check**

### Helpful Tone

**This is a HELPER, not a CRITIC**:

**Good validation comment** (helpful, guiding):
```markdown
> ⬜ **BLANK: Measurement method not specified**
> - **What's needed**: The specific method or tool you'll use to measure outcomes
> - **Why it matters**: Defines how you'll quantify success for this research question
> - **Examples**:
>   - "Cell type proportions via Louvain clustering at resolution 0.5"
>   - "Differential gene expression using DESeq2 with FDR<0.05"
>   - "Survival analysis using Cox proportional hazards model"
> - **Guiding questions**:
>   - What metric or measurement captures your outcome?
>   - Which tool or method will you use to calculate this?
>   - How will you quantify the result?
```

**Bad validation comment** (critical, judgmental):
```markdown
> ⬜ **BLANK: Measurement method missing**
> - Issue: You didn't specify how to measure this
> - This is required
```

### Validation vs Review Distinction

| Aspect | validate_fields | review_intent |
|--------|----------------|---------------|
| **Question asked** | "Is this filled out?" | "Is this scientifically sound?" |
| **Tone** | Helpful, guiding | Skeptical, challenging |
| **Focus** | Completeness, clarity | Rigor, validity |
| **Typical finding** | "Field is blank, here's what to put" | "N=10 is underpowered, increase to N=15" |
| **When to run** | First (before review) | Second (after validation) |
| **Purpose** | Ensure docs complete | Ensure science is rigorous |

### Examples by Status

#### ⬜ BLANK Example

```markdown
## Primary Research Question
{Insert Question/Aim}

**[VALIDATION 2025-10-30]**
> ⬜ **BLANK: Primary research question not specified**
> - **What's needed**: A specific, answerable research question for your project
> - **Why it matters**: The research question guides all subsequent planning and analysis
> - **Examples**:
>   - "What is the cellular composition of the tumor microenvironment in melanoma?"
>   - "How does BRCA1 mutation status correlate with treatment response?"
>   - "What are the spatial patterns of immune cell infiltration in pancreatic tumors?"
> - **Guiding questions**:
>   - What are you trying to discover or understand?
>   - What question will your data analysis answer?
>   - Is this exploratory (broad question) or hypothesis-driven (specific question)?
>   - Can you phrase this as a question ending with "?"?
```

#### 🟨 INCOMPLETE Example

```markdown
## Primary Hypothesis
- **Short ID**: H1
- **Statement**: T cell infiltration affects patient survival
- **Rationale**: Prior studies show immune importance
- **Null Hypothesis**:
- **Alternative Hypothesis**:

**[VALIDATION 2025-10-30]**
> 🟨 **INCOMPLETE: Hypothesis missing null and alternative formulations**
> - **What's present**: Statement and rationale are filled
> - **What's missing**: Null hypothesis and alternative hypothesis
> - **Why these matter**: Null/alternative hypotheses are essential for hypothesis testing framework
> - **How to complete**:
>   - **Null hypothesis**: State what you'd observe if there's NO effect
>     - Example: "T cell infiltration level has no association with patient survival time"
>   - **Alternative hypothesis**: State what you'd observe if there IS an effect
>     - Example: "Higher T cell infiltration is associated with longer patient survival time"
> - **Guiding questions**:
>   - If your hypothesis is WRONG, what would the data show? (null)
>   - If your hypothesis is RIGHT, what would the data show? (alternative)
>   - Is this directional (positive/negative effect) or non-directional (any effect)?
```

#### 🟧 AMBIGUOUS Example

```markdown
## Dataset 1: Tumor Samples

### Data Types
- **Primary Data Type**: RNA-seq (H5AD format)

**[VALIDATION 2025-10-30]**
> 🟧 **AMBIGUOUS: "RNA-seq" lacks specificity**
> - **What's unclear**: "RNA-seq" could mean bulk RNA-seq or single-cell RNA-seq
> - **Why specificity matters**: Different RNA-seq types require different analysis approaches
> - **Guiding questions**:
>   - Is this bulk RNA-seq (tissue-level) or single-cell RNA-seq (cell-level)?
>   - If single-cell: Which platform? (10X Genomics, Drop-seq, Smart-seq2)
>   - Is it stranded or unstranded?
>   - What sequencing depth? (reads per sample or cell)
> - **Suggestion**: Be specific, e.g.:
>   - "Single-cell RNA-seq (10X Genomics 3' v3)"
>   - "Bulk RNA-seq (stranded, paired-end)"
```

### Controlled Vocabulary Reference

Include this reference in validation report for user convenience:

```markdown
## Controlled Vocabulary Reference

Use these approved values in specific fields:

**Project Type** (project_overview.md):
- exploratory
- targeted
- package development
- workflow refactoring

**Biological Scale** (project_overview.md):
- genomic
- transcriptomic (scRNAseq, WTS, bulk RNA-seq)
- proteomic
- metabolomic
- multi-omic
- imaging
- Phenocycler
- Visium
- Xenium
- annotated pathology slides
- SNP microarray
- Organoid
- Patient Derived Xenograft

**Processing Level** (datasets.md):
- primary (raw, unprocessed)
- secondary (processed, analysis-ready)
- tertiary (analyzed results)

**Access** (datasets.md):
- Public
- In-house

**Environment** (project_resources.md):
- local
- HPC
- cloud
- hybrid

**Container Preference** (project_resources.md):
- Docker
- Singularity
- Conda
- None
```

---

## Notes

- This validates COMPLETENESS and CLARITY of documentation
- Run this BEFORE `/biospec.review_intent` (which checks scientific rigor)
- Validation can be re-run multiple times to track progress
- Each validation updates metrics and shows improvement
- Focus is on helping users complete templates, not critiquing their science
- Guiding questions should be practical and actionable
- Examples should be concrete and domain-appropriate
- Tone should be encouraging and supportive
