---
description: Analyze an existing repository structure and contents to auto-populate biospec project charter templates.
---

## User Input

```text
$ARGUMENTS
```

Optional: User may specify repository path. If empty, use current working directory.

## Outline

The text the user typed after `/biospec.parse_existing_project` is optional and may contain a repository path. If no path is provided, scan the current repository.

Given a repository to analyze, do this:

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

**IMPORTANT**: Also create a `project/_sources.md` file to track provenance of all extracted information (see section 3 for format).

### 2. Repository Scanning Strategy

Scan the repository systematically in three priority levels. For each level, attempt to locate and read the specified files.

#### Level 1: Project Definition Files (Highest Priority)

These files contain explicit project descriptions and should be prioritized:

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
# Use Glob tool to find these patterns:
README*
PROJECT*
docs/{index,project_overview,README}*
{proposal,grant,grant_proposal}*
{manuscript,paper,publication,methods,analysis_plan}*
.github/ISSUE_TEMPLATE/*
```

**Extraction priority**: These files should be read FIRST and given HIGHEST confidence for extracted information.

#### Level 2: Technical Setup Files (Medium Priority)

These files describe computational infrastructure and dependencies:

**Environment specifications**:
- `environment.yml`, `environment.yaml` (Conda)
- `requirements.txt`, `pyproject.toml`, `setup.py` (Python)
- `renv.lock`, `DESCRIPTION` (R)
- `package.json` (JavaScript/Node)

**Containerization**:
- `Dockerfile`, `Dockerfile.*`
- `Singularity.def`, `*.def` (Singularity recipes)
- `docker-compose.yml`, `docker-compose.yaml`

**Workflow configurations**:
- `Snakefile`, `workflow/Snakefile`
- `nextflow.config`, `*.nf` (Nextflow workflows)
- `Makefile`
- `config.yml`, `config.yaml`, `config.json`
- `params.yml`, `params.yaml`, `params.json`
- `settings.*`

**HPC/Cluster scripts**:
- `*.sh` (job submission scripts in root or scripts/ directory)
- `*.pbs`, `*.slurm` (batch job files)

**File discovery**:
```bash
# Use Glob tool to find these patterns:
environment.{yml,yaml}
requirements.txt
pyproject.toml
setup.py
renv.lock
DESCRIPTION
Dockerfile*
*.def
docker-compose.{yml,yaml}
Snakefile
workflow/Snakefile
nextflow.config
*.nf
Makefile
{config,params,settings}.{yml,yaml,json}
scripts/*.{sh,pbs,slurm}
*.{pbs,slurm}
```

**Extraction priority**: MEDIUM confidence - explicit technical setup, but may not reflect current state.

#### Level 3: Data & Methods Files (Lower Priority for Inference)

These files provide evidence of datasets, methods, and analyses:

**Data documentation**:
- `data/README.*`, `data/*/README.*`
- `data_dictionary.*`, `metadata_dictionary.*`
- `metadata.*`, `sample_sheet.*`, `samples.*`, `manifest.*`
- `data/*` (directory structure and file types)

**Analysis code**:
- `notebooks/*.ipynb`, `*.ipynb` (Jupyter notebooks)
- `analysis/*.{R,Rmd,py,ipynb}`
- `src/main.*`, `src/*.{R,py}`
- `scripts/*.{R,py,sh}`

**Results/Outputs**:
- `results/figures/*` (output types)
- `results/*` (directory structure indicates analysis phases)
- `output/*`, `outputs/*`

**File discovery**:
```bash
# Use Glob tool to find these patterns:
data/README*
data/*/README*
{data_dictionary,metadata_dictionary,metadata,sample_sheet,samples,manifest}*
notebooks/*.ipynb
*.ipynb
analysis/*.{R,Rmd,py,ipynb}
src/*.{R,py}
scripts/*.{R,py,sh}
results/**/*
output/**/*
outputs/**/*
```

**Extraction priority**: LOWER confidence - infer from code/structure, may be outdated or incomplete.

#### Scanning Execution

**MUST perform these steps**:

1. **Use Glob tool** to discover files matching each pattern
2. **Read discovered files** using Read tool (prioritize Level 1, then Level 2, then Level 3)
3. **Track all files read** in `project/_sources.md`
4. **Handle missing files gracefully** - note absence but continue scanning
5. **Limit reads**: If >20 notebooks found, read first 5 (most recently modified)
6. **Stop if no files found**: If zero Level 1 files found, ERROR "No project documentation found. Repository may be empty or not a research project."

### 3. Information Extraction by File Type

For each file type, extract specific information and assign confidence levels.

#### Format for Tracking Sources

In `project/_sources.md`, maintain a table:

```markdown
# Source Tracking

| Template | Field | Value | Source File | Confidence | Notes |
|----------|-------|-------|-------------|------------|-------|
| project_overview.md | Project Title | "..." | README.md:5 | High | Explicit H1 heading |
| intent.md | Primary Research Question | "..." | manuscript.md:45-48 | High | Methods section |
| datasets.md | Dataset 1 name | "..." | data/README.md:3 | Medium | Inferred from description |
| project_resources.md | Container preference | Docker | Dockerfile | High | Explicit Dockerfile exists |
```

**Confidence levels**:
- **High**: Explicit statement in authoritative file (README aims section, manuscript methods, explicit config)
- **Medium**: Inferred from code/config with reasonable certainty (workflow inputs, package imports)
- **Low**: Weak inference or indirect evidence (directory names, comments)

#### README.md / README.rst / README.txt

**Extraction patterns**:

| Information | Pattern/Location | Maps To | Confidence |
|-------------|------------------|---------|------------|
| **Project title** | First H1 heading (`# Title`) or title in frontmatter | project_overview.md: Project Title | High |
| **Summary** | First paragraph(s) after title, or "Summary"/"Overview" section | project_overview.md: Brief Summary | High |
| **Research questions/aims** | Sections with headers containing "aim", "question", "objective", "goal" | intent.md: Research Questions/Aims | High |
| **Hypotheses** | Sections containing "hypothesis", "hypothesize", "we predict", "we expect" | intent.md: Hypotheses | High |
| **Methods** | "Methods", "Approach", "Pipeline", "Workflow" sections | project_overview.md: Computational Activities in Scope | Medium |
| **Data/Datasets** | Sections with "data", "dataset", "samples", mentions of accession numbers (GSE, SRA, dbGaP) | datasets.md: Dataset information | Medium |
| **Installation/Setup** | "Installation", "Setup", "Requirements" sections | project_resources.md: Environment Management | Medium |
| **Citations/References** | "References", "Citation", links to papers | project_overview.md: Prior Work | High |
| **Contributors/Authors** | "Authors", "Contributors", "Contact" sections | project_overview.md: Principal Investigator/Lead | Medium |
| **Keywords/Tags** | Explicit keyword lists, tags, or repeated technical terms | project_overview.md: Keywords | Medium |

**Extraction procedure**:
1. Parse markdown structure to identify headers and sections
2. Match section headers to information types using keywords
3. Extract content from matched sections
4. Note line numbers for source tracking
5. If multiple README files exist, prioritize: README.md > docs/README.md > data/README.md

#### Manuscripts / Papers / Proposals

**Extraction patterns**:

| Information | Pattern/Location | Maps To | Confidence |
|-------------|------------------|---------|------------|
| **Hypotheses** | "Hypothesis", "We hypothesized", "We predicted" statements | intent.md: Hypotheses (Primary) | High |
| **Research aims** | "Aims", "Objectives", numbered lists in introduction/methods | intent.md: Research Questions/Aims | High |
| **Methods** | "Methods", "Materials and Methods", "Computational Methods" sections | project_overview.md: Computational Activities; intent.md: Analysis Objectives | High |
| **Sample information** | Numbers of samples, replicates in methods | datasets.md: Sample Information | High |
| **Expected outcomes** | "Expected outcomes", discussion of anticipated results | intent.md: Expected Outputs | Medium |
| **Statistical approach** | Power analysis, multiple testing correction mentions | intent.md: Analysis Objectives; relationships.md notes | High |

**IMPORTANT**: Manuscript information should be given HIGHEST confidence when conflicts arise with README.

#### environment.yml / requirements.txt / renv.lock

**Extraction patterns**:

| File Type | Information Extracted | Maps To | Confidence |
|-----------|----------------------|---------|------------|
| **environment.yml** | Package manager: Conda; packages listed | project_resources.md: Container Preference, Package Management | High |
| **requirements.txt** | Package manager: pip/Python; packages listed | project_resources.md: Package Management | High |
| **renv.lock** | Package manager: R/renv; packages from CRAN/Bioconductor | project_resources.md: Package Management | High |
| **pyproject.toml** | Python package metadata, dependencies | project_resources.md: Package Management | High |

**Inference from packages**:
- If scanpy/anndata present → likely scRNA-seq project → Biological scale: transcriptomic (scRNAseq)
- If Seurat/SingleCellExperiment → likely scRNA-seq (R) → Biological scale: transcriptomic (scRNAseq)
- If DESeq2/edgeR/limma → likely bulk RNA-seq → Biological scale: transcriptomic (bulk RNA-seq)
- If squidpy/spatialdata → likely spatial transcriptomics → Biological scale: Visium or spatial
- If numpy/pandas but not bio packages → likely general data analysis

**Confidence**: Medium for biological scale inference (indirect evidence)

#### Dockerfile / Singularity.def

**Extraction patterns**:

| Information | Pattern | Maps To | Confidence |
|-------------|---------|---------|------------|
| **Container preference** | Existence of Dockerfile → Docker; *.def → Singularity | project_resources.md: Container Preference | High |
| **Base OS** | `FROM` statement (Dockerfile) or `Bootstrap` (Singularity) | project_resources.md: Operating System | High |
| **Package management** | RUN apt-get, RUN conda, RUN pip commands | project_resources.md: Package Management | Medium |
| **Resource hints** | Multi-stage builds, large base images → resource-intensive | relationships.md: Resource requirements note | Low |

#### Snakefile / nextflow.config / Workflow files

**Extraction patterns**:

| Information | Pattern | Maps To | Confidence |
|-------------|---------|---------|------------|
| **Workflow structure** | Rule names, process names | intent.md: Analysis Objectives (Must Have) | High |
| **Computational steps** | Sequence of rules/processes | project_overview.md: Computational Activities in Scope | High |
| **Input data paths** | Input file directives, `params.input` | datasets.md: Dataset locations, formats | Medium |
| **Resource requirements** | `resources:` (Snakemake), `process.cpus` (Nextflow) | project_resources.md: Hardware Specifications | High |
| **HPC usage** | Cluster config, executor settings | project_resources.md: Environment (HPC) | High |
| **Tools used** | Shell commands, conda envs, container directives | project_overview.md: Computational Activities | High |
| **Project phases** | Grouped rules/processes (QC → align → quantify) | intent.md: Milestones | Medium |

**Special handling**:
- Extract rule/process names as analysis objectives
- Identify sequential dependencies as milestones
- Note parallel processes as independent objectives

#### Jupyter Notebooks (*.ipynb)

**Extraction patterns**:

| Information | Location | Maps To | Confidence |
|-------------|----------|---------|------------|
| **Analysis objectives** | Markdown headers, first cell descriptions | intent.md: Analysis Objectives | Medium |
| **Datasets loaded** | pd.read_csv(), anndata.read_h5ad(), file paths | datasets.md: Dataset names, formats | Medium |
| **Methods used** | Function calls, library imports | project_overview.md: Computational Activities | Medium |
| **Expected outputs** | Figure generation code, file writes | intent.md: Expected Outputs | Low |
| **Hypotheses tested** | Markdown cells with "hypothesis", "test", "expect" | intent.md: Hypotheses | Medium |

**Reading strategy**:
1. Read only first 3 cells and markdown cells throughout (skip long code cells)
2. Focus on markdown headers and explanatory text
3. Check imports to infer data types
4. Note file paths for dataset identification

**IMPORTANT**: Notebooks may be exploratory/outdated - assign MEDIUM or LOW confidence.

#### data/ Directory Structure

**Inference patterns**:

| Pattern Observed | Inference | Maps To | Confidence |
|------------------|-----------|---------|------------|
| **Subdirectories** | data/raw/, data/processed/ | datasets.md: Processing level (primary vs secondary) | Medium |
| **File extensions** | .fastq.gz → genomic (primary); .h5ad → scRNA-seq (secondary); .csv → tabular metadata | datasets.md: Data types, formats | Medium |
| **Sample counts** | Number of files in data/raw/ | datasets.md: Total Samples (estimate) | Low |
| **Accession patterns** | GSM*, SRR* in filenames | datasets.md: Public data, accession numbers | High |
| **README presence** | data/README.md exists | Read for explicit dataset documentation | High |

**File count inference**:
- Count files in data/raw/ or data/ to estimate sample count
- Note: May include metadata files, so actual sample count could be lower

#### Config / Params Files

**Extraction patterns**:

| Information | Pattern | Maps To | Confidence |
|-------------|---------|---------|------------|
| **Tool parameters** | Tool-specific settings (e.g., clustering_resolution: 0.5) | intent.md: Analysis Objectives details | Medium |
| **Data paths** | input_data: path/to/file | datasets.md: Dataset locations | High |
| **Resource settings** | max_memory, num_threads | project_resources.md: Hardware Specifications | Medium |
| **Reference data** | genome: "GRCh38", annotation_file | datasets.md: Reference Data Required | High |

### 4. Template Population Order with Provenance

Populate templates in dependency order, recording source for each field.

#### Template 1: project_overview.md

**Fields to populate** (with typical sources):

| Field | Primary Sources | Fallback Sources | Confidence |
|-------|----------------|------------------|------------|
| **Project Title** | README H1, manuscript title | Directory name, git repo name | High / Low |
| **Project Type** | README keywords, proposal | Infer from workflow complexity | Medium |
| **Start Date** | Git first commit date, proposal date | Leave blank | Medium / - |
| **Expected Duration** | Proposal, README | Leave blank | Medium / - |
| **Principal Investigator/Lead** | README authors, manuscript authors | Git commit authors | Medium |
| **Groups involved** | README, manuscript affiliations | Leave blank | Medium / - |
| **Brief Summary** | README first paragraphs | Synthesize from multiple sources | High |
| **Keywords** | README explicit keywords, manuscript keywords | Frequent terms in README | High / Medium |
| **Biological System** | README, manuscript methods | Infer from package deps | High / Medium |
| **Biological Scale** | README, manuscript | Infer from packages (scanpy→scRNA-seq) | High / Medium |
| **Key Biological Processes** | README, manuscript | Leave blank | High / - |
| **Computational Activities in Scope** | README methods, workflow rules | Notebook headers | High / Medium |
| **Out of Scope** | README explicit exclusions | Leave blank | High / - |
| **Reference Studies** | README citations, manuscript refs | Leave blank | High / - |
| **Methods to Reproduce/Adapt** | README, manuscript methods | Workflow comments | High / Medium |
| **Key Papers/Resources** | README citations section | Leave blank | High / - |

**Population procedure**:
1. Read Level 1 files first (README, manuscript)
2. Extract information using patterns from section 3
3. For each field populated, record in `_sources.md`:
   - Source file and line number
   - Confidence level
   - If conflicts exist, note all sources
4. If field not found in primary sources, check fallback sources
5. Leave blank if no reliable source found

**Example source tracking**:
```markdown
project_overview.md: Biological Scale = "transcriptomic (scRNAseq)"
Source: environment.yml (inferred from scanpy package)
Confidence: Medium
Notes: No explicit mention in README; inferred from computational environment
```

#### Template 2: intent.md

**Fields to populate** (with typical sources):

| Field | Primary Sources | Fallback Sources | Confidence |
|-------|----------------|------------------|------------|
| **Primary Research Question** | README, manuscript introduction/aims | Notebook markdown headers | High / Medium |
| **Secondary Research Questions** | README, manuscript | Workflow rule names | High / Medium |
| **Primary Hypothesis** | Manuscript, README hypothesis section | Leave blank if exploratory | High / - |
| **Supporting Hypotheses** | Manuscript, README | Notebook markdown cells | High / Medium |
| **Analysis Objectives (Must Have)** | Workflow rules, README methods | Notebook headers | High / Medium |
| **Analysis Objectives (Nice to Have)** | README future work, issue trackers | Commented-out workflow rules | Medium / Low |
| **Analysis Objectives (Future)** | README future work, proposal future aims | GitHub issues | Medium / Low |
| **Milestones** | Workflow phases, README timeline | Synthesize from workflow structure | Medium |
| **Dependencies** | Workflow DAG, README methods | Infer from workflow order | High / Medium |
| **Expected Outputs (Primary)** | README, manuscript results | Workflow output files | High / Medium |
| **Expected Outputs (Secondary)** | README supplementary | results/ directory structure | Medium / Low |

**Hypothesis detection**:
- Search for: "hypothesize", "hypothesis", "we predict", "we expect", "H0:", "H1:"
- If found: Extract statement, formulate null/alternative
- If NOT found: Leave hypothesis section blank and note "Exploratory project - no explicit hypothesis found"

**Analysis objectives from workflows**:
- Extract Snakemake rule names or Nextflow process names as objectives
- Group by workflow phases: QC → Processing → Analysis → Visualization
- Categorize by position: Early rules → Must Have; Later rules → Nice to Have

**Example**:
```
Snakefile rules found:
- rule fastqc (QC phase) → Must Have: "Quality control of raw reads"
- rule trim_adapters (QC phase) → Must Have: "Adapter trimming"
- rule align (Processing phase) → Must Have: "Read alignment to reference"
- rule call_variants (Analysis phase) → Must Have: "Variant calling"
```

#### Template 3: datasets.md

**Fields to populate** (with typical sources):

For each dataset identified:

| Field | Primary Sources | Fallback Sources | Confidence |
|-------|----------------|------------------|------------|
| **Dataset Name/Identifier** | data/README, README, accession IDs | Directory name, file prefix | High / Medium |
| **Primary Data Type** | data/README, README, file extensions | Package dependencies | High / Medium |
| **Supplementary Data Types** | data/README, workflow inputs | data/ subdirectories | Medium |
| **Degree of Processing** | data/README, directory names (raw/processed) | File extensions | High / Medium |
| **Reference Data Required** | config files, workflow params | Infer from field (human→GRCh38) | High / Medium |
| **Access** | Accession IDs→Public; else In-house | Assume In-house | High / Medium |
| **Year of Creation** | README, manuscript publication date | Git repo creation date | Medium |
| **Total Samples** | data/README, sample sheets | Count files in data/ | High / Low |
| **Biological Replicates** | sample sheet, README | Infer from filename patterns | High / Medium |
| **Technical Replicates** | sample sheet, README | Infer from filename patterns | High / Medium |
| **Control Samples** | sample sheet, README | Infer from filenames (control, neg) | High / Medium |
| **Batch Information** | sample sheet, README | Infer from filename dates/prefixes | High / Medium |
| **Metadata Requirements** | data_dictionary, README | Infer from sample sheet columns | High / Medium |
| **QC tasks completed** | README, results/QC/ | Leave blank | Medium / - |
| **QC tasks to complete** | README TODO, issues | Infer standard QC for data type | Medium / Low |

**Dataset identification strategy**:
1. Check for data/README or dataset documentation first
2. List subdirectories in data/ as potential datasets
3. Check workflow input directives for data paths
4. Check notebook file load commands
5. Merge if same dataset referenced in multiple places

**Example dataset population**:
```markdown
## Dataset 1: Melanoma Patient Samples (scRNA-seq)

Source: data/scRNAseq/README.md, Snakefile inputs
Confidence: High (explicit documentation)

### Data Types
- **Primary Data Type**: scRNA-seq expression matrix (H5AD format)
  - Source: data/scRNAseq/README.md:5
- **Supplementary Data Types**: Cell metadata (CSV), UMAP embeddings (CSV)
  - Source: data/scRNAseq/ directory listing
- **Degree of processing**: secondary
  - Source: data/scRNAseq/README.md (states "processed count matrix")
- **Reference Data Required**: GRCh38
  - Source: config.yml:genome
- **Access**: In-house
  - Source: No accession ID found
- **Year of creation**: 2023
  - Source: data/scRNAseq/README.md:3

### Sample Information
- **Total Samples**: 50 patients
  - Source: data/scRNAseq/sample_sheet.csv (50 rows)
```

**Summary table population**:
Create table from all identified datasets with their characteristics.

#### Template 4: project_resources.md

**Fields to populate** (with typical sources):

| Field | Primary Sources | Fallback Sources | Confidence |
|-------|----------------|------------------|------------|
| **CPU** | Workflow resource specs, HPC scripts | Leave blank | Medium / - |
| **RAM** | Workflow resource specs, HPC scripts | Leave blank | Medium / - |
| **GPU** | Dockerfile (nvidia base), workflow specs | Leave blank | High / - |
| **Operating System** | Dockerfile FROM, Singularity Bootstrap | Leave blank | High / - |
| **Environment** | Workflow cluster config, .sh script headers | local (default) | High / Medium |
| **Infrastructure** | HPC script headers (SLURM/PBS) | Leave blank | High / - |
| **Job submission method** | HPC script directives (#SBATCH, #PBS) | Infer from infrastructure | High / Medium |
| **Storage Location** | README, config file paths | Infer from environment | Medium |
| **Capacity Required** | README, config | Estimate from data/ size * 5 | Medium / Low |
| **Backup Strategy** | README, docs | Leave blank | Medium / - |
| **Repository Type** | .git/ exists → git | git (default) | High |
| **Repository Name** | Git remote URL | Directory name | High / Medium |
| **Repository Location** | Git remote URL | Leave blank | High / - |
| **Container Preference** | Dockerfile→Docker; *.def→Singularity | environment.yml→Conda | High |
| **Package Management** | requirements.txt, environment.yml, renv.lock | Infer from file extensions (.R→R, .py→Python) | High / Medium |
| **Environment Documentation Location** | Path to environment files | Note file paths | High |

**Environment inference**:
- If SLURM/PBS directives found → HPC
- If AWS/GCP mentioned in README → cloud
- If Dockerfile but no HPC → local or cloud
- Default → local

**Resource extraction from HPC scripts**:
```bash
# Example .slurm file:
#SBATCH --cpus-per-task=16
#SBATCH --mem=64GB
#SBATCH --gres=gpu:1

Extract:
- CPU: 16
- RAM: 64GB
- GPU: Yes (1 GPU)
- Job submission method: SLURM
```

#### Template 5: relationships.md

This template synthesizes information from all previous templates.

**Research Questions/Aims vs Datasets**:

For each RQ/Aim identified in intent.md:
1. Determine which dataset(s) from datasets.md can address it
2. Base mapping on:
   - Explicit statements in README/manuscript
   - Workflow inputs used for specific analysis objectives
   - Notebook data loading patterns
3. Identify pros/cons:
   - **Pros**: Sample size, resolution, controls (from datasets.md sample info)
   - **Cons**: Processing level limitations, missing metadata, small sample size

**Example**:
```markdown
### RQ1-TME: What is the composition of the tumor microenvironment?

**Relevant Datasets**:
- Dataset 1 (Melanoma scRNA-seq, 50 patients): Provides cell-type resolution
  - **Pros**: Large sample size, secondary processing (ready for analysis)
  - **Cons**: No spatial information, potential batch effects (metadata lacks batch info)
  - **Source**: README.md states this dataset for TME characterization

**Confidence**: High (explicit mapping in README)
```

**Scope Check**:

Validate alignment by checking:

1. **Goals (intent.md) vs Scope (project_overview.md)**:
   - Do analysis objectives require tools/methods listed in computational activities?
   - Are there objectives that would need out-of-scope activities?
   - Example conflict: "Deep learning clustering" in objectives but "No deep learning" in scope

2. **Computational Activities vs Available Data**:
   - Do datasets support the stated analysis objectives?
   - Example gap: "Longitudinal analysis" objective but only cross-sectional samples in datasets

3. **Resource Requirements vs Stated Resources**:
   - Are workflow resource specs sufficient for data size?
   - Example issue: "Local environment" but workflow requests 128GB RAM

**Conflict detection**:
- Flag misalignments with severity: ✓ Aligned | ⚠ Minor misalignment | ✗ Major misalignment
- Provide specific examples from source files
- Suggest resolutions (update README, modify workflow, acquire more data)

**Source tracking**:
Record which files were used to assess alignment and where conflicts were detected.

### 5. Quality Validation

After populating all templates, validate completeness, consistency, and source coverage.

#### Validation Checklist

**Source Coverage** (unique to parse_existing_project):
- [ ] At least one Level 1 file (project definition) was found and read
- [ ] README or equivalent documentation exists
- [ ] At least one Level 2 file (technical setup) was found
- [ ] At least one dataset identified from Level 3 or explicit documentation
- [ ] All populated fields have source tracking in `_sources.md`
- [ ] Confidence levels assigned to all fields

**Content Quality** (across all templates):
- [ ] All high-confidence fields populated (no blanks where explicit info exists)
- [ ] Controlled vocabulary used correctly (project types, biological scales, etc.)
- [ ] Version numbers and timestamps updated
- [ ] Consistent terminology across templates
- [ ] `_sources.md` table is complete and well-formatted

**project_overview.md**:
- [ ] Project title extracted (or synthesized if necessary)
- [ ] Project type inferred or explicitly stated
- [ ] Biological scale identified (from README or package inference)
- [ ] Brief summary written (from README or synthesized)
- [ ] Keywords extracted (explicit or inferred from frequent terms)
- [ ] Computational activities listed (from workflow or README)

**intent.md**:
- [ ] At least one research question or aim identified
- [ ] Research questions properly formatted as questions
- [ ] Hypotheses extracted if present (or noted as exploratory)
- [ ] Analysis objectives extracted from workflow/notebooks
- [ ] Analysis objectives categorized by priority
- [ ] Milestones inferred from workflow structure or README

**datasets.md**:
- [ ] At least one dataset identified
- [ ] Each dataset has a name/identifier
- [ ] Data types and formats specified
- [ ] Processing level determined (primary/secondary/tertiary)
- [ ] Sample information extracted or estimated
- [ ] Summary table includes all datasets

**project_resources.md**:
- [ ] Computing environment inferred (local/HPC/cloud)
- [ ] Package management identified from environment files
- [ ] Container preference determined if applicable
- [ ] Repository type and location noted

**relationships.md**:
- [ ] All RQs/Aims from intent.md addressed
- [ ] Each RQ/Aim mapped to at least one dataset
- [ ] Pros/cons listed for each dataset-RQ pairing
- [ ] Scope check performed with alignment status
- [ ] Conflicts flagged with severity and suggested resolutions

#### Conflict Detection

**CRITICAL**: Check for inconsistencies between sources.

**Common conflict patterns**:

| Conflict Type | Example | Resolution Strategy |
|---------------|---------|---------------------|
| **README vs Code** | README says "50 samples" but data/ has 45 files | Flag [NEEDS REVIEW]; suggest: "Update README or verify sample count" |
| **Manuscript vs README** | Manuscript hypothesis differs from README aims | Prioritize manuscript (more formal); note discrepancy |
| **Workflow vs Documentation** | Workflow includes deep learning but README says "no DL" | Flag ✗ Major misalignment; suggest scope update |
| **Environment vs Workflow** | Workflow needs GPU but no nvidia in Dockerfile | Flag ⚠ Minor misalignment; suggest environment update |
| **Old vs Current** | README mentions files that don't exist anymore | Flag as staleness; suggest README update |

**Conflict handling**:
1. Record ALL conflicting values in `_sources.md`
2. Apply prioritization: Code/Manuscript > README > Inference
3. Mark field with [CONFLICT: source1 vs source2]
4. Add to clarification questions if resolution needed

#### Staleness Detection

Check for outdated information:

- **File references**: README mentions files that don't exist
- **Tool versions**: Environment files vs workflow comments
- **Sample counts**: Documentation vs actual data/ contents
- **Results**: README describes results not in results/ directory

**Action**: Flag stale information and note in "Fields Requiring Manual Review"

#### Missing Standard Files

Track which standard files were NOT found:

- [ ] README.md or equivalent
- [ ] environment.yml or requirements.txt or equivalent
- [ ] Dockerfile or Singularity recipe (if containerization used)
- [ ] Workflow file (Snakefile, *.nf, Makefile)
- [ ] data/README.md or data documentation
- [ ] Sample sheet or metadata file

**Action**: List missing files in completion report with recommendation to create them.

### 6. Generate Clarification Questions

If conflicts, ambiguities, or [NEEDS REVIEW] markers remain (max 5):

#### Clarification Prioritization

**Tier 1 (MUST clarify)**: Conflicts affecting scientific validity
- Conflicting sample sizes between sources
- Inconsistent hypotheses (manuscript vs README)
- Missing critical metadata (controls, replicates)

**Tier 2 (SHOULD clarify)**: Documentation inconsistencies
- README mentions non-existent files
- Workflow scope differs from stated scope
- Data processing level ambiguous

**Tier 3 (COULD clarify)**: Minor discrepancies
- Project type unclear (exploratory vs targeted)
- Keywords not explicitly stated
- Missing background/context

**Tier 4 (NICE to clarify)**: Technical details
- Resource specs not found
- Container preference unclear
- SOPs not documented

**LIMIT**: Maximum **5 total clarification questions** across all templates
- Prioritize Tier 1 > Tier 2 > Tier 3 > Tier 4
- For lower-tier ambiguities, make informed guesses and document assumptions

#### Question Format

Present conflicts/questions using this structured format:

```markdown
## Question {N}: {Topic}

**Context**: {Describe the conflict or ambiguity found}

**Conflicting Sources**:
- Source 1: {file:line} states "{value1}"
- Source 2: {file:line} states "{value2}"

**Why this matters**: {Explain impact on project charter accuracy}

**Suggested Resolutions**:

| Option | Description | Action Required | Recommended Source to Update |
|--------|-------------|-----------------|------------------------------|
| A | Use {source1} value | Update {template field} to "{value1}" | Update {source2 file} for consistency |
| B | Use {source2} value | Update {template field} to "{value2}" | Update {source1 file} for consistency |
| C | Investigate and verify | Manual check of actual data/code | Update both sources if needed |
| Custom | Provide correct value | You specify the accurate information | Update all sources |

**Recommendation**: {Which option is most likely correct and why}

**Your choice**: _[Wait for user response]_
```

**CRITICAL - Table Formatting**:
- Use consistent spacing with pipes aligned
- Each cell should have spaces around content: `| Content |` not `|Content|`
- Header separator must have at least 3 dashes: `|--------|`

#### Question Sequencing

1. Number questions Q1, Q2, Q3, etc. (max 5 total)
2. Order by priority tier (Tier 1 first)
3. Present all questions together in one message
4. Wait for user response with choices for all questions
5. Update templates and `_sources.md` with resolutions
6. Note which files should be updated for consistency

### 7. Report Completion

After successful validation (with or without clarifications), report:

```markdown
## Project Charter Created from Repository Analysis: {Project Title}

**Location**: `project/` directory

**Repository scanned**: {path}

**Templates populated**:
- ✓ project_overview.md (version 0.1) - {high/medium/low confidence}
- ✓ intent.md (version 0.1) - {high/medium/low confidence}
- ✓ datasets.md (version 0.1) - {high/medium/low confidence}
- ✓ project_resources.md (version 0.1) - {high/medium/low confidence}
- ✓ relationships.md (version 0.1) - {high/medium/low confidence}
- ✓ _sources.md - Provenance tracking for all fields

**Validation Status**: {Pass/Pass with conflicts/Needs review}

**Files Scanned**:

Level 1 (Project Definition): {count} files
- {list files read, e.g., "README.md, manuscript.md"}

Level 2 (Technical Setup): {count} files
- {list files read, e.g., "environment.yml, Snakefile"}

Level 3 (Data & Methods): {count} files
- {list files read, e.g., "5 notebooks, data/README.md"}

Total: {total count} files read

**Source Quality Summary**:
- High-confidence fields: {count} ({percentage}%)
- Medium-confidence fields: {count} ({percentage}%)
- Low-confidence fields: {count} ({percentage}%)
- Fields left blank: {count}

**Conflicts Detected**: {count}
{If any, list briefly with source files}

**Staleness Warnings**: {count}
{If any, note which documentation references non-existent files/outdated info}

**Missing Standard Files**:
{List any standard files that were expected but not found, e.g.:}
- ⚠ No data/README.md found - dataset documentation recommended
- ⚠ No sample sheet found - sample metadata should be documented
- ✓ Workflow file found (Snakefile)

**Fields Requiring Manual Review** (if any):
- {template_name}: {field_name} - {reason with source info}
  Example: "datasets.md: Sample count - Inferred as 45 from file count, but README states 50 [CONFLICT]"

**Alignment Issues** (from relationships.md):
{List any scope misalignments detected}

**Recommendations**:
1. Review `project/_sources.md` to verify extraction accuracy
2. Resolve conflicts flagged above by checking original data/code
3. Update stale documentation (README, comments) to match current state
4. Create missing standard files (data/README.md, sample sheets, etc.)
5. Run `/biospec.validate_fields` to check template completeness
6. Run `/biospec.review_intent` for critical assessment before proceeding

**Next Steps**:
1. Manual review of all populated templates for accuracy
2. Fill blank fields based on project knowledge not captured in files
3. Resolve any conflicts by verifying against actual data/code
4. Update repository documentation to fix inconsistencies
5. Consider creating missing standard files for better documentation

**Notes**:
- All templates start at version 0.1
- Update "Last updated" timestamp when making manual edits
- See `project/_sources.md` for complete provenance of all extracted information
- Confidence levels reflect quality of source, not certainty of inference
- This is a snapshot based on current repository state - may need updates as project evolves
```

### 8. Error Handling

Handle these error conditions:

| Error Condition | Action |
|----------------|--------|
| No repository path specified and not in git repo | ERROR "Please provide repository path or run from within a repository" |
| Repository path doesn't exist | ERROR "Repository path not found: {path}" |
| No Level 1 files found | ERROR "No project documentation found (README, manuscript, etc.). Cannot populate templates without project description." |
| All file reads fail | ERROR "Unable to read any files in repository. Check permissions." |
| Zero datasets identified | WARN "No datasets identified from data/ directory or documentation. datasets.md left mostly blank. Please populate manually." |
| Workflow found but no environment file | WARN "Workflow file found but no environment specification. Cannot infer package management." |
| Multiple conflicting READMEs | Choose highest level (README.md > docs/README.md > data/README.md) and note conflicts |
| Validation fails after 3 iterations | WARN "Some validation items remain incomplete. Review populated templates manually. See conflicts and missing fields above." |

---

## General Guidelines

### Conservative Population with Provenance

**DO**:
- Record source file and line number for EVERY populated field
- Assign confidence levels honestly based on source quality
- Flag ALL conflicts between sources
- Use blanks when no reliable source exists
- Preserve template structure and checklists exactly
- Prioritize explicit statements over inferences
- Note in `_sources.md` when values are inferred vs explicit

**DON'T**:
- Invent information that isn't in any source file
- Assume README is current without checking against code
- Fill fields with low-confidence guesses without marking as such
- Ignore conflicts between sources
- Populate from sources more than 2 years old without staleness warning

### Source Prioritization Rules

When conflicts arise between sources:

1. **Published manuscript** > README > code comments (for hypotheses, aims, methods)
2. **Code/workflow** > README > comments (for computational activities, tools used)
3. **Config files** > README > inference (for technical specifications)
4. **Data files** > README > estimates (for sample counts, data types)
5. **Recent files** > old files (check git timestamps if available)

**Exception**: If README explicitly states "Updated [recent date]", treat as high priority.

### Confidence Level Assignment Guide

| Confidence | Criteria | Examples |
|------------|----------|----------|
| **High** | Explicit statement in authoritative file | README H1 title, manuscript hypothesis, Dockerfile FROM statement, workflow input paths |
| **Medium** | Inferred with reasonable certainty from code/config | Biological scale from scanpy import, sample count from file listing, workflow phases as milestones |
| **Low** | Weak inference from indirect evidence | Project type from directory structure, keywords from frequent terms, expected outputs from results/ names |

**Rule**: If in doubt between two levels, choose the lower confidence.

### Handling Special Repository Types

#### Well-Documented Projects
- README + manuscript + workflow + data docs all present
- High confidence for most fields
- Focus on conflict detection between sources
- Validate that docs match current code state

#### Code-Heavy Projects
- Minimal README, extensive code/notebooks
- Rely heavily on Level 2/3 inference
- Medium/Low confidence for most fields
- Emphasize need for documentation improvements in recommendations

#### Legacy/Inherited Projects
- Old documentation, current code may differ
- Check git commit dates to assess staleness
- Prioritize code over old docs
- Flag extensive staleness warnings
- Recommend documentation refresh

#### Multi-Phase Projects
- Multiple analysis directories (phase1/, phase2/)
- Create separate datasets for each phase if data differs
- Note phases as milestones
- Check if README describes all phases

#### Published Projects
- Manuscript is authoritative source
- Prioritize manuscript over README for hypotheses/methods
- Note publication in project_overview.md
- Extract citation information

### Extraction Pattern Examples

#### Example 1: Well-Documented scRNA-seq Project

**Repository structure**:
```
├── README.md (comprehensive)
├── environment.yml
├── Snakefile
├── data/
│   ├── README.md
│   └── scRNAseq/
│       ├── sample_sheet.csv (50 rows)
│       └── *.h5ad files (50 files)
├── notebooks/
│   └── 01_QC.ipynb
│   └── 02_clustering.ipynb
└── results/
    └── figures/
```

**Extraction**:
- Project title: README.md H1 → "Melanoma TME Analysis" (High confidence)
- Project type: README keywords "explore", "characterize" → exploratory (High)
- Biological scale: README "single-cell RNA-seq" → transcriptomic (scRNAseq) (High)
- Primary research question: README aims section → extracted verbatim (High)
- Dataset 1: data/README.md → "Melanoma scRNA-seq, 50 patients" (High)
- Sample count: sample_sheet.csv 50 rows, matches 50 .h5ad files → 50 (High)
- Analysis objectives: Snakefile rules → QC, clustering, DE analysis (High)
- Container preference: environment.yml exists → Conda (High)

**Confidence**: Mostly High - excellent documentation

#### Example 2: Code-Heavy Project with Minimal Docs

**Repository structure**:
```
├── README.md (2 sentences: "scRNA-seq analysis. See notebooks.")
├── requirements.txt
├── notebooks/
│   ├── 00_load_data.ipynb
│   ├── 01_preprocess.ipynb
│   ├── 02_cluster.ipynb
│   ├── 03_DE.ipynb
│   └── 04_figures.ipynb
└── data/
    └── *.h5ad (30 files, no README)
```

**Extraction**:
- Project title: Directory name "scrna_melanoma" → "scRNA-seq Melanoma" (Low)
- Project type: No hypothesis, exploratory notebooks → exploratory (Medium)
- Biological scale: .h5ad files, scanpy in requirements.txt → transcriptomic (scRNAseq) (Medium)
- Primary research question: Synthesize from notebook headers → "What are the cell types in melanoma?" (Low)
- Dataset 1: Infer from 00_load_data.ipynb code → "Melanoma scRNA-seq" (Medium)
- Sample count: Count .h5ad files → 30 (Low - could be multiple files per sample)
- Analysis objectives: Notebook sequence → Preprocessing, Clustering, DE, Visualization (Medium)
- Container preference: requirements.txt → pip/Python (High)

**Confidence**: Mostly Medium/Low - minimal documentation, heavy inference

**Recommendation**: Create comprehensive README, data/README, document sample structure

#### Example 3: Legacy Project with Outdated README

**Repository structure**:
```
├── README.md (last updated 2021, mentions 20 samples)
├── manuscript.pdf (published 2023, mentions 45 samples)
├── environment.yml
├── Snakefile (updated 2023, processes 45 samples)
└── data/
    └── *.fastq.gz (90 files = 45 paired-end samples)
```

**Extraction**:
- Sample count: **CONFLICT**
  - README.md:15 → "20 samples" (2021)
  - manuscript.pdf:5 → "45 samples" (2023)
  - data/ count → 45 samples (2023)
  - Snakefile:10 → "samples = glob_wildcards('data/{sample}_R1.fastq.gz')" → 45 (2023)
- **Resolution**: Prioritize manuscript + code + data over old README
  - Population: 45 samples (High confidence)
  - Source: manuscript.pdf:5, data/ file count, Snakefile
  - Flag: [STALENESS] README.md mentions 20 samples but actual count is 45
  - Recommendation: Update README.md to reflect final sample count

**Conflict handling**:
Add to clarification questions:
```markdown
## Question 1: Sample Count Conflict

**Conflicting Sources**:
- README.md:15 (last updated 2021): "20 samples"
- manuscript.pdf:5 (published 2023): "45 samples"
- data/ directory: 90 FASTQ files (45 paired-end samples)
- Snakefile:10: Processes 45 samples

**Why this matters**: Accurate sample size is critical for power and reproducibility

**Suggested Resolutions**:

| Option | Description | Action | Recommended Update |
|--------|-------------|--------|-------------------|
| A | Use current count (45) | Populate datasets.md with 45 samples | Update README.md to 45 |
| B | Verify manually | Count actual biological samples | Update all docs to match |

**Recommendation**: Option A - manuscript and current data/code agree on 45

**Your choice**: _[Wait for user response]_
```

### Notebook Parsing Strategy

When reading notebooks:

**Focus on**:
1. **First cell**: Often contains overview/purpose
2. **Markdown cells with headers**: Section descriptions, aims
3. **Import statements**: Infer tools and data types
4. **Data loading cells**: `pd.read_csv('path/to/data.csv')` → dataset identification
5. **Final cells**: May show expected outputs

**Skip**:
- Long code cells (>50 lines)
- Intermediate computation cells
- Debug/test cells

**Read limit**: If >10 notebooks, read 5 most recently modified

**Example extraction**:
```python
# From notebook: analysis/01_preprocessing.ipynb

# Cell 1 (markdown):
"# Preprocessing of scRNA-seq data
This notebook performs QC and normalization of melanoma patient samples."

Extract:
- Analysis objective: "QC and normalization of scRNA-seq data" (Medium confidence)
- Maps to: intent.md Analysis Objectives (Must Have)
- Source: analysis/01_preprocessing.ipynb:Cell 1

# Cell 2 (code):
import scanpy as sc
adata = sc.read_h5ad('data/raw/melanoma_patients.h5ad')
print(f"Loaded {adata.n_obs} cells from {adata.obs['patient_id'].nunique()} patients")

Extract:
- Dataset name: "melanoma_patients" (Medium confidence)
- Data type: scRNA-seq (H5AD format) (High confidence)
- Maps to: datasets.md Dataset 1
- Source: analysis/01_preprocessing.ipynb:Cell 2
```

### Workflow Parsing Examples

#### Snakemake

```python
# From Snakefile

SAMPLES = glob_wildcards("data/raw/{sample}.fastq.gz").sample

rule all:
    input:
        "results/final_report.html"

rule fastqc:
    input:
        "data/raw/{sample}.fastq.gz"
    output:
        "results/qc/{sample}_fastqc.html"
    resources:
        mem_mb=4000
    conda:
        "envs/qc.yml"
    shell:
        "fastqc {input} -o results/qc/"

rule align:
    input:
        fastq="data/raw/{sample}.fastq.gz",
        ref="refs/GRCh38.fa"
    output:
        "results/aligned/{sample}.bam"
    resources:
        mem_mb=16000,
        cpus=8
    container:
        "docker://biocontainers/bwa:0.7.17"
    shell:
        "bwa mem -t {resources.cpus} {input.ref} {input.fastq} | samtools view -b > {output}"
```

**Extract**:
- Analysis objectives (Must Have):
  - "Quality control (FastQC)" (from rule fastqc)
  - "Read alignment to reference" (from rule align)
- Datasets:
  - Input: data/raw/*.fastq.gz → genomic data (primary processing level)
  - Reference: refs/GRCh38.fa → Reference Data Required: GRCh38
- Resources:
  - CPU: 8 cores (from align rule)
  - RAM: 16GB (from align rule)
- Container preference: Docker (from container directive)
- Package management: Conda (from conda directive)
- Environment: HPC or local (resource specs suggest HPC but no cluster config found)
- Milestones: QC → Alignment (sequential dependency)

**Source tracking**:
```markdown
intent.md: Analysis Objectives (Must Have) = "Quality control (FastQC)"
Source: Snakefile:12-18 (rule fastqc)
Confidence: High

project_resources.md: CPU = 8
Source: Snakefile:28 (resources.cpus in rule align)
Confidence: High
```

#### Nextflow

```groovy
// From main.nf

params.reads = "data/*_R{1,2}.fastq.gz"
params.genome = "GRCh38"
params.outdir = "results"

process QC {
    cpus 4
    memory '8 GB'

    input:
    tuple val(sample_id), path(reads)

    output:
    path "*_fastqc.{zip,html}"

    script:
    """
    fastqc -t ${task.cpus} ${reads}
    """
}

process ALIGN {
    cpus 16
    memory '32 GB'

    publishDir "${params.outdir}/aligned"

    input:
    tuple val(sample_id), path(reads)
    path genome

    output:
    path "${sample_id}.bam"

    script:
    """
    bwa mem -t ${task.cpus} ${genome} ${reads} | samtools view -bS - > ${sample_id}.bam
    """
}
```

**Extract**:
- Analysis objectives: "Quality control (FastQC)", "Read alignment"
- Datasets: params.reads → paired-end genomic data
- Reference: params.genome → GRCh38
- Resources: CPU=16, RAM=32GB (from ALIGN process, most demanding)
- Milestones: QC → ALIGN (process sequence)

### Missing Files - Graceful Degradation

If standard files missing:

| Missing File | Impact | Fallback | Report Action |
|--------------|--------|----------|---------------|
| **README.md** | Cannot extract project description | Use directory name, workflow comments | WARN "No README found. Project title/summary inferred from limited sources." |
| **Manuscript** | Cannot extract hypotheses, formal methods | Use README, notebooks | INFO "No manuscript found. Hypotheses/methods extracted from README only." |
| **environment.yml/requirements.txt** | Cannot determine package management | Infer from file extensions (.py → Python) | WARN "No environment file. Package management inferred from file types." |
| **Workflow file** | Cannot extract analysis pipeline | Use notebook sequence | WARN "No workflow file. Analysis objectives inferred from notebooks." |
| **data/README** | Cannot document datasets explicitly | Infer from directory structure | WARN "No data/README. Dataset info inferred from directory listing." |
| **Sample sheet** | Cannot extract sample metadata | Estimate from file count | WARN "No sample sheet. Sample count estimated from data/ files." |

**Reporting**:
List all missing files with recommendation to create them for better documentation.

---

## Notes

- The `project/` directory contains the populated templates
- The `project/_sources.md` file tracks provenance for all extracted information
- The `.biospec/` directory contains pristine templates (do not modify)
- This command performs a SNAPSHOT analysis of current repository state
- Documentation may be outdated relative to code - always check timestamps and flag staleness
- Prioritize code/data over documentation when conflicts arise
- When in doubt, assign lower confidence and flag for manual review
- Users should review all populated templates and `_sources.md` for accuracy before using
- Consider this an initial population - refinement via manual editing or `/biospec.validate_fields` and `/biospec.review_intent` is expected
