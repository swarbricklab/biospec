---
description: Apply critical, skeptical review to populated biospec project charter templates with inline feedback.
---

## User Input

```text
$ARGUMENTS
```

Optional: User may specify focus areas, severity threshold, or review mode.

**Examples**:
- Empty (default): Review all areas with balanced skepticism
- `--focus "statistical rigor"`: Focus only on sample size, power, statistics
- `--focus "feasibility"`: Focus only on resources, timeline, technical dependencies
- `--threshold critical`: Only flag critical issues
- `--mode harsh`: Maximum skepticism, Murphy's Law perspective
- `intent.md`: Review only the intent template
- `--focus "sample size" --mode harsh`: Combination

## Outline

The text after `/biospec.review_intent` is optional and configures the review scope and style.

Given populated project charter templates, apply critical review and append feedback inline:

### 1. Parse Configuration

Extract user preferences from arguments:

**Focus Areas** (dimension to emphasize):
- `all` (default): Review across all 7 dimensions
- `scientific rigor`: Sample size, power, controls, confounders, statistics
- `statistical validity`: Hypothesis framework, assumptions, multiple testing
- `feasibility`: Resources, timeline, tools, dependencies
- `data quality`: Dataset suitability, limitations, QC
- `scope alignment`: Hidden requirements, scope creep, MVP
- `reproducibility`: Environment, documentation, sharing
- `murphy's law`: Failure scenarios, contingencies

**Severity Threshold**:
- `all` (default): Show all findings (🔴🟡🔵💡)
- `critical`: Only show critical issues (🔴)
- `warning`: Show critical + warnings (🔴🟡)
- `suggestion`: Show all including suggestions (🔴🟡🔵)

**Review Mode** (personality):
- `balanced` (default): Fair but thorough, some skepticism
- `gentle`: Constructive, focus on alternatives over problems
- `harsh`: Maximum skepticism, assume Murphy's Law, challenge everything

**Template Focus**:
- `all` (default): Review project_overview.md, intent.md, datasets.md, (optionally resources.md, relationships.md)
- Specific template: Only review named template (e.g., `intent.md`)

### 2. Read Project Templates

Read templates from `project/` directory in priority order:

**Required** (always read):
1. `project/intent.md` - Primary review target (hypotheses, RQs, objectives)
2. `project/datasets.md` - Data quality and suitability
3. `project/project_overview.md` - Scope and context

**Optional** (read if exist and not template-focused):
4. `project/project_resources.md` - Resource feasibility
5. `project/relationships.md` - Cross-template alignment

**Error handling**:
- If `project/` directory doesn't exist: ERROR "No project/ directory found. Run /biospec.create_project or /biospec.parse_existing_project first."
- If intent.md missing: ERROR "project/intent.md not found. Cannot review intent without intent template."
- If templates appear empty: WARN "Templates seem mostly unfilled. Review will be limited."

### 3. Inline Review Comment Format

**CRITICAL**: All feedback MUST be appended directly to template fields using this format.

#### Format Choice: Visible Review Blocks

Use markdown blockquotes for high visibility while preserving template readability:

```markdown
[Original field content]

**[REVIEW 2025-10-30]**
> 🔴 **CRITICAL: Brief Issue Title**
> - **Issue**: Specific problem identified
> - **Why this matters**: Impact on project success/validity/reproducibility
> - **Evidence**: Supporting facts, citations, benchmarks, typical values
> - **Recommendation**: Concrete action to address (be specific)
> - **Alternative** (if applicable): Different approach worth considering

> 🟡 **WARNING: Another Issue Title**
> - **Issue**: [description]
> - **Why this matters**: [impact]
> - **Recommendation**: [action]
```

**Formatting rules**:
- **Date stamp**: Always include review date in format `[REVIEW YYYY-MM-DD]`
- **Severity emoji first**: 🔴🟡🔵💡 immediately before issue title
- **Bold title**: Issue title in bold for scannability
- **Blockquote wrapper**: All review content in `>` blockquote for visual distinction
- **Bullet structure**: Consistent bullets for Issue/Why/Evidence/Recommendation/Alternative
- **Multiple issues**: Separate blockquotes for each severity level or distinct issue

**Placement**:
- Append review block **immediately after** the field being reviewed
- For section-level reviews (multiple related fields), append at end of section before next header
- For dataset-level reviews, append at end of dataset block

### 4. Review Dimensions

Apply critical lens across 7 core dimensions. For each dimension, generate specific, evidence-based findings.

#### Dimension 1: Scientific Rigor

Review research design fundamentals:

**Sample Size & Power**:
- Is N sufficient for stated analyses?
- Power analysis performed or referenced?
- What if X% fail QC - still powered?
- Effect size expectations realistic for biological system?
- Common benchmarks:
  - Bulk RNA-seq DE: N≥10-15 per group for 80% power (2-fold changes)
  - scRNA-seq: N≥5-8 biological samples for robust DE
  - Genomics WGS: N≥30-50 for rare variant association
  - Spatial transcriptomics: N≥10 sections for spatial patterns

**Controls & Experimental Design**:
- Appropriate controls included (negative, positive, technical)?
- Randomization mentioned?
- Blinding where applicable?
- Case-control matching if relevant?
- Time-matched controls for temporal effects?

**Replicates**:
- Biological vs technical replicates distinguished?
- Sufficient biological replicates for variability estimation?
- Technical replicates appropriate (or overkill)?
- Pseudoreplication avoided (multiple measures from same subject)?

**Confounders & Batch Effects**:
- Known confounders identified (age, sex, BMI, etc.)?
- Batch effects documented (sequencing runs, collection dates, sites)?
- Mitigation strategy stated (randomization, blocking, statistical adjustment)?
- Batch correction method specified if multiple batches?

**Multiple Testing Correction**:
- How many tests performed? (e.g., 20,000 genes)
- Multiple testing correction method specified?
- FDR threshold chosen and justified?
- Expected false positive rate acceptable?

**Statistical Assumptions**:
- Normality assumed but not tested?
- Independence assumption valid? (repeated measures? spatial autocorrelation?)
- Variance homogeneity checked (or method robust to violations)?
- Distribution appropriate for data type (e.g., negative binomial for counts)?

**Validation Strategy**:
- How to convince skeptics of biological relevance?
- Orthogonal validation planned (qPCR, IHC, functional assays)?
- External validation dataset?
- Positive/negative control genes?

**Critical questions to ask**:
- "N={X} seems underpowered for effect sizes typically seen in {biological system}. Power analysis?"
- "With {X} samples and {Y} covariates, how many degrees of freedom remain?"
- "If 30% of samples fail QC, N drops to {X-30%}. Still sufficient?"
- "No biological replicates mentioned - only technical replicates?"
- "Samples collected across {timespan}. Batch effects documented?"
- "Testing {N} features. Multiple testing correction method?"
- "Assuming normality without testing? {Data type} often heavy-tailed."
- "Sample independence assumption - but repeated measures from same subjects?"

#### Dimension 2: Statistical Validity

Review hypothesis testing and statistical framework:

**Hypothesis Testing Framework**:
- Null and alternative hypotheses properly formulated?
- Testable with stated methods and data?
- One-sided vs two-sided appropriate?
- Hypothesis matches research question?

**Success Criteria Measurability**:
- Success criteria objective and measurable?
- Thresholds arbitrary or justified (e.g., why FDR<0.05 not 0.01)?
- Risk of p-hacking (fishing for significance)?
- What if achieve statistical significance but small effect size?
- What if biologically meaningful but not statistically significant?

**Effect Size Expectations**:
- Expected effect size stated?
- Realistic for this biological system (check literature)?
- Minimum detectable effect size calculated?
- Clinical/biological relevance threshold defined?

**Sample Pairing/Matching**:
- Paired design if before/after or matched samples?
- Pairing/matching accounted for in analysis method?
- Matching variables appropriate and sufficient?

**Missing Data Handling**:
- Missing data expected? How common?
- Missing data mechanism (MAR, MCAR, MNAR)?
- Imputation method specified and appropriate?
- Complete-case analysis vs imputation justified?

**Critical questions**:
- "Null hypothesis is vague - need precise mathematical statement"
- "Success defined as 'finding interesting genes' - too subjective, needs quantification"
- "FDR<0.05 threshold seems arbitrary. What's the biological relevance threshold?"
- "Expecting to detect 2-fold changes, but literature shows effects are typically <1.5-fold in this system"
- "Paired samples (before/after treatment) but analysis method doesn't account for pairing"
- "No mention of missing data handling. What if 20% of values are NA?"

#### Dimension 3: Feasibility & Resources

Review practical achievability:

**Compute Requirements Reality Check**:
- Resource estimates benchmarked or guessed?
- {Tool X} on {data size} typically requires {realistic estimate}. Checked?
- Peak memory usage considered (often 5-10x data size)?
- Multi-threading efficiency realistic (not linear scaling)?
- GPU required but not mentioned?

**Storage for Intermediates**:
- Input data size: {X GB}
- Intermediate files often 10-20x input for genomics pipelines. Planned?
- Temporary scratch space sufficient?
- Cleanup strategy for temp files?
- Backup storage for raw data?

**Timeline Realism**:
- Timeline assumes zero failed runs - when has that happened?
- Time for troubleshooting/debugging included?
- Time for QC iteration and reruns?
- Learning curve for new tools factored in?
- Buffer for unexpected issues (illness, cluster downtime, etc.)?

**Tool Availability & Maintenance**:
- {Tool Z} last updated {year} - no longer maintained? Contingency?
- {Tool X} known to be buggy/unstable for {specific use case}. Aware?
- Proprietary software - license available?
- Tool requires specific OS/hardware not mentioned?

**Package Dependency Conflicts**:
- {Package A} and {Package B} have conflicting dependencies in recent versions. Tested?
- Python 2 vs Python 3 tools mixed - intentional?
- R package dependencies from different repos (CRAN vs Bioconductor)?
- Version pinning specified to avoid breakage?

**HPC Access Assumptions**:
- Assuming HPC access - what if cluster unavailable?
- Queue wait times factored into timeline?
- Node-hours budget sufficient?
- Walltime limits compatible with job length?

**Critical questions**:
- "{Tool X} on {data type/size} typically needs {RAM estimate}. Benchmarked or guessed?"
- "Intermediate BAM files for 50 samples ~500GB. Storage plan?"
- "Timeline shows 2 weeks for analysis. Assuming zero failures and reruns?"
- "{Tool Y} hasn't been updated since 2019 and doesn't compile on modern systems. Contingency?"
- "{Package A} requires Python 3.8+ but {Package B} only supports 3.6. Conflict resolution?"
- "Workflow requires 100 node-hours but HPC allocation is 20/month. Math doesn't work."

#### Dimension 4: Data Quality & Suitability

Review dataset fitness for purpose:

**Dataset Appropriate for RQs**:
- Dataset actually answers the research question?
- Resolution/granularity sufficient (e.g., scRNA-seq for cell-type question)?
- Data type matches analysis (e.g., spatial data for spatial question)?
- Cross-sectional data for longitudinal question?

**Known Limitations of Public Data**:
- How many studies already mined this dataset? What's novel angle?
- Original study noted {limitation} - how addressed?
- Known batch effects in this dataset (check papers)?
- Quality issues reported (high mitochondrial %, low coverage, etc.)?
- Retractions or corrections for this dataset? Checked?

**Processing Level Matches Needs**:
- Raw data but no processing pipeline specified?
- Processed data - processing method appropriate for your analysis?
- Normalization method compatible with your statistical test?
- Re-processing needed but computationally prohibitive?

**Missing Critical Metadata**:
- Clinical variables needed for analysis but not in dataset?
- Batch information absent - cannot control for batch?
- Sample matching info missing (paired samples not identified)?
- Treatment/timepoint info needed but not recorded?

**Dataset Mining Saturation**:
- This dataset used in {N} published studies. What's left to discover?
- Original hypotheses already tested - replication or novel angle?
- Low-hanging fruit already picked?

**QC Strategy Realistic**:
- "Standard QC" mentioned but not specified - what exactly?
- QC thresholds appropriate for this data type?
- What if 30-50% of samples fail QC? Contingency?
- QC metrics match known issues with this platform/protocol?

**Critical questions**:
- "Dataset 1 is bulk RNA-seq, but RQ asks about cell-type-specific effects. Mismatch."
- "GSE12345 has been used in 15+ published studies. What novel insight remains?"
- "Original study (Smith et al.) noted strong batch effects between sites. Mitigation strategy?"
- "Public scRNA-seq often has high ambient RNA. Correction method planned?"
- "Metadata lacks treatment response information, but that's the primary outcome. Gap."
- "FASTQ files but no alignment pipeline specified - that's 80% of the work"
- "'Standard QC' - does that mean >{X}% mapping, <{Y}% mito? Specify thresholds."

#### Dimension 5: Scope Alignment

Review scope definition and hidden requirements:

**Hidden Requirements Detection**:
- "{In-scope activity}" implies you'll also need "{hidden requirement 1}", "{hidden requirement 2}"...
- Example: "Differential expression" implies: QC → normalization → batch correction → model fitting → multiple testing → validation
- Example: "Cell type annotation" implies: clustering → marker ID → reference mapping → manual curation → validation
- Is the full pipeline scoped or just the final step?

**Scope Creep Warnings**:
- Combining {N} separate analyses - really 1 project or {N} projects?
- "Exploratory" project with {long list of specific objectives} - actually targeted?
- Objectives keep expanding in later sections - which is core?
- "Nice to have" list longer than "must have" - priority unclear

**Out-of-Scope Exclusions that Matter**:
- Excluding "{out-of-scope item}" makes "{in-scope item}" uninterpretable
- Example: "No functional validation" but proposing novel gene function - how to convince reviewers?
- Example: "No batch correction" but samples from multiple batches - results unreliable
- Are the exclusions viable or will they force scope expansion?

**Minimum Viable Analysis**:
- What's the simplest analysis that still provides value?
- If time/resources limited, what's the core vs nice-to-have?
- Which objectives are interdependent vs independent?

**Pivot Strategy if Main Hypothesis Fails**:
- If primary hypothesis is wrong, what then?
- Exploratory backup plan?
- Alternative hypotheses testable with same data?
- Value even if null result?

**Critical questions**:
- "Scope says 'differential expression' but that's just the end point. Also need: QC, normalization, batch correction, etc. All scoped?"
- "10 'must have' objectives - really? Which 2-3 are truly essential?"
- "Out of scope: 'deep learning'. But one objective is 'cell type annotation' which benefits from DL. Contradiction?"
- "This is really 3 separate projects: (1) TME characterization, (2) survival analysis, (3) spatial patterns. Which is primary?"
- "If your hypothesis that Gene X drives phenotype is wrong, what's the backup plan?"
- "Exploratory project but very specific success criteria. Actually hypothesis-driven?"

#### Dimension 6: Reproducibility

Review documentation and sharing strategy:

**Environment Fully Specified**:
- Dockerfile or Singularity recipe provided?
- Conda environment.yml or requirements.txt with versions?
- Version pinning for critical packages?
- Base OS and system libraries documented?

**Beyond "Works on My Machine"**:
- Container/VM image for portability?
- Tested on clean environment (not just development machine)?
- Installation instructions complete?
- Known OS-specific issues documented?

**Data Sharing Plan**:
- Raw data: public deposit (GEO, SRA)? Restricted access? Embargoed?
- Processed data: supplementary files? Repository? Size practical for sharing?
- Metadata: data dictionary provided? Sample annotations complete?
- Access restrictions clearly stated (human subjects, commercial, etc.)?

**Code Availability**:
- GitHub/GitLab repository mentioned?
- Code organization (README, directory structure)?
- Documented functions/scripts?
- Runnable as-is or requires manual intervention?
- License specified?

**Documentation Sufficiency**:
- Analysis steps documented (methods section)?
- Parameter choices justified?
- Quality control criteria stated?
- Preprocessing steps fully described?
- Enough detail for independent reproduction?

**Critical questions**:
- "No Dockerfile and package list includes 47 dependencies. How will others reproduce?"
- "Conda environment but no version pinning - will break as packages update"
- "Mentions 'standard pipeline' - where's the code? Which version? What parameters?"
- "Raw data private, processed data not shared - how can anyone verify results?"
- "GitHub repo planned but no organizational structure defined - will it be navigable?"
- "'See methods' - but methods section is vague pseudocode, not actual steps"

#### Dimension 7: Murphy's Law Scenarios

Challenge assumptions with failure scenarios:

**What if 30% of samples fail QC?**:
- Sample size drops from N={X} to N={X*0.7}
- Still powered for primary analyses?
- Which analyses become infeasible?
- Budget for replacement samples?

**What if key algorithm doesn't converge?**:
- Clustering fails to converge on this dataset?
- Iterative algorithm hits max iterations without solution?
- Alternative algorithm available?
- Simpler fallback method?

**What if your hypothesis is just... wrong?**:
- Null result - still publishable?
- Exploratory backup analyses planned?
- Alternative explanations testable with same data?
- Value in negative result?

**What if competing work is published next month?**:
- Differentiation from concurrent work?
- Unique angle that remains valuable?
- How quickly can you pivot if scooped?

**What if you lose cluster access mid-analysis?**:
- Can analysis run locally (scaled down)?
- Cloud backup option?
- Data portable to different system?
- Checkpointing for long jobs?

**What if primary collaborator leaves?**:
- Knowledge transfer documented?
- Critical expertise in one person?
- Code documented enough for handoff?

**What if data has unexpected structure?**:
- Assumption of no population structure - but actually present?
- Assumed distribution doesn't fit observed data?
- Unexpected confounders discovered?
- Flexibility to adapt analysis?

**Critical questions**:
- "QC threshold <5% mito. In practice, 30-50% of samples may fail. Still have N≥10?"
- "UMAP clustering used in 15 papers on this data type - but known to not converge on sparse data. Tested?"
- "If hypothesis is wrong (no association), what's the backup? Exploratory DE? Network analysis?"
- "Two preprints on related topics appeared last month. If published first, what's your unique contribution?"
- "HPC-dependent workflow. If cluster down for 2 weeks (not uncommon), can you continue?"
- "All analysis knowledge with postdoc ending in 3 months. Documentation for handoff?"

### 5. Field-by-Field Review Strategy

For each template, review specific fields systematically:

#### project_overview.md Review Points

**Project Type**:
- Classification appropriate? ("exploratory" but specific hypothesis → should be "targeted")
- Type matches objectives and hypotheses?

**Biological System**:
- Sufficient specificity for planning? ("human tissue" → which tissue? healthy or diseased?)
- Organism/tissue/stage match datasets?

**Biological Scale**:
- Matches datasets and methods?
- Multiple scales claimed - integration strategy?

**Computational Activities in Scope**:
- Realistic list or aspirational?
- Hidden requirements identified?
- Tools/methods appropriate for data type?

**Out of Scope**:
- Exclusions viable or will force expansion?
- Out-of-scope items that are actually necessary?

**Prior Work & Inspiration**:
- Sufficient differentiation from reference studies?
- Novel contribution clear?
- Methods to reproduce - why those specifically?

#### intent.md Review Points (Primary Focus)

**Primary Research Questions/Aims**:
- For EACH RQ/Aim, review:
  - Well-formulated? (specific, answerable, scoped)
  - Answerable with stated datasets and methods?
  - Sample size sufficient for this question?
  - Measurement method appropriate?
  - Communication method clear?
- Append review block after each RQ/Aim

**Hypotheses**:
- For EACH hypothesis, review:
  - Testable with available data?
  - Null and alternative properly formulated?
  - Rationale evidence-based or speculative?
  - Power to detect expected effect?
  - Associated RQ/Aim clear?
- Append review block after each hypothesis
- If exploratory project with hypotheses: contradiction?
- If targeted project without hypotheses: missing?

**Analysis Objectives**:
- For "Must Have" objectives:
  - Truly essential or could be "nice to have"?
  - Methods specified or vague?
  - Dependencies on prior objectives?
  - Timeline realistic?
- For "Nice to Have":
  - Actually achievable if must-haves are done?
  - Scope creep risk?
- For "Future Considerations":
  - Should some be "must have" for completeness?
- Append review block at end of each priority section

**Milestones**:
- Properly sequenced (dependencies respected)?
- Achievable in implied timeline?
- Sufficient detail to track progress?

**Dependencies**:
- All dependencies identified?
- Circular dependencies avoided?
- Blocking dependencies with mitigation?

**Expected Outputs**:
- Sufficient for success criteria?
- Realistic to produce with stated analyses?
- Primary vs secondary distinction clear?

**Summary Table**:
- All RQs/Aims included?
- Success criteria measurable and objective?
- Priorities match must-have/nice-to-have?

#### datasets.md Review Points

**For EACH dataset** (review separately):
- **Suitability**: Appropriate for RQs it's mapped to?
- **Data Type**: Matches analysis methods?
- **Processing Level**: Appropriate for analyses or re-processing needed?
- **Reference Data**: Specified and correct for organism/tissue?
- **Access**: Public data - accession valid? In-house - sharing plan?
- **Sample Information**:
  - Total samples sufficient?
  - Biological replicates adequate?
  - Technical replicates necessary or overkill?
  - Control samples appropriate?
  - Batch information - effects addressed?
- **Metadata Requirements**: Complete for planned analyses?
- **QC Status**: QC plan realistic? Failure rate assumed?
- Append review block at end of each dataset section

**Summary Table**:
- All datasets included?
- Characteristics accurate?

#### project_resources.md Review Points (Optional)

**Hardware Specifications**:
- CPU/RAM/GPU specs benchmarked or guessed?
- Sufficient for stated data size and methods?

**Environment**:
- Appropriate for computational needs (local/HPC/cloud)?
- HPC job submission method correct?

**Storage Architecture**:
- Capacity accounts for intermediates?
- Backup strategy sufficient?

**Version Control & Reproducibility**:
- Container preference appropriate?
- Package management complete?
- Environment documentation location specified?

**SOPs**:
- Sufficient for reproducibility?
- Up-to-date or stale references?

#### relationships.md Review Points (Optional)

**Research Questions/Aims vs Datasets**:
- Mappings accurate?
- Pros/cons realistic?
- Missing datasets for some RQs?
- Datasets unused by any RQ?

**Scope Check**:
- Alignment issues correctly identified?
- Severity appropriate (✓ vs ⚠ vs ✗)?
- Suggested resolutions actionable?

### 6. Domain-Specific Checks

Apply additional scrutiny based on biological scale (data type):

#### For scRNA-seq Projects

**QC & Preprocessing**:
- Doublet removal method specified? (DoubletFinder, Scrublet?)
- Empty droplet filtering (EmptyDrops)?
- Ambient RNA correction (SoupX, DecontX)?
- Mitochondrial gene filtering threshold?
- Gene/cell filtering criteria?

**Normalization & Integration**:
- Normalization method appropriate (LogNormalize, SCTransform, Pearson residuals)?
- If multiple samples: integration method (Harmony, Seurat CCA, scVI)?
- Integration may overcorrect biological signal - addressed?

**Cell Type Annotation**:
- Reference-based or marker-based or manual?
- Reference dataset appropriate (same tissue, species, condition)?
- Annotation confidence/threshold defined?
- Rare cell type detection sensitivity?

**Dimensionality Reduction**:
- PCA variance explained - how many PCs used?
- UMAP/tSNE hyperparameters specified?
- Batch effects visible in UMAP - addressed?

**Clustering**:
- Algorithm (Leiden, Louvain)?
- Resolution parameter - how chosen?
- Over-clustering or under-clustering risk?
- Cluster stability validated?

**Differential Expression**:
- DE method appropriate (MAST, DESeq2, Wilcoxon)?
- Pseudobulk vs single-cell-level - justified?
- Multiple testing correction (across genes AND cell types)?

**Sample Size**:
- Biological samples: N≥5-8 for robust DE
- Cells per sample: adequate for rare cell types?
- Depth per cell: sufficient for detection (median genes/cell)?

**Critical questions for scRNA-seq**:
- "No doublet removal mentioned - can inflate cell type counts by 5-10%"
- "Ambient RNA from lysed cells can bias results - SoupX/DecontX planned?"
- "Louvain clustering at resolution 0.5 - have you tested multiple resolutions?"
- "Using MAST for DE - appropriate but very conservative with low cell counts"
- "Integrating 10 samples with Seurat CCA - may overcorrect biology. Harmony alternative?"
- "Expecting to detect rare cell type (<1%) with only 1000 cells/sample - underpowered"

#### For Bulk RNA-seq Projects

**Library Prep & QC**:
- Strand-specific or unstranded - matches analysis?
- rRNA depletion vs polyA selection - appropriate?
- Insert size distribution checked?
- Library size normalization method (TMM, RLE)?

**Alignment & Quantification**:
- Reference genome version specified?
- Splice-aware aligner for RNA-seq (STAR, HISAT2)?
- Gene vs transcript-level quantification?
- Quantification method (featureCounts, Salmon)?

**Batch Effects**:
- Surrogate Variable Analysis (SVA) for hidden confounders?
- RUVSeq for technical variation removal?
- Batch as covariate in model?

**Normalization**:
- DESeq2 median-of-ratios, edgeR TMM, limma-voom?
- Compositional bias addressed?

**Differential Expression**:
- Model design appropriate (simple two-group, paired, multi-factor)?
- Dispersion estimation method?
- Shrinkage of log fold changes?
- Independent filtering for low-count genes?

**Multiple Testing**:
- FDR correction (Benjamini-Hochberg)?
- IHW for increased power?
- Testing 20,000 genes - expect ~1000 FPs at FDR=0.05

**Sample Size**:
- N≥10-15 per group for 80% power (2-fold changes)
- N≥3 for methods requiring dispersion estimation (DESeq2, edgeR)

**Critical questions for bulk RNA-seq**:
- "Unstranded library but antisense transcripts expected - will misassign reads"
- "No mention of batch in model, but samples sequenced across 4 lanes - batch effect likely"
- "Using edgeR but N=3 per group - dispersion estimate unstable, needs tagwise shrinkage"
- "DESeq2 with default shrinkage - consider apeglm for more accurate LFC estimates"
- "Testing 20,000 genes at FDR=0.05 - expect ~1000 false positives. Plan to validate top hits?"
- "Paired samples (before/after) but model is ~condition - should be ~patient + condition"

#### For Spatial Transcriptomics (Visium, Xenium, etc.)

**Platform-Specific**:
- Visium: 55μm spots = 5-10 cells mixed - deconvolution planned?
- Xenium/MERFISH: Subcellular resolution - segmentation method?
- Slide-seq: Bead size and coverage - appropriate?

**Spatial Preprocessing**:
- Tissue detection (SpatialExperiment, Seurat)?
- Normalization accounting for spatial effects?
- Image alignment if multiple sections?

**Spatial Analysis**:
- Spatial autocorrelation method (Moran's I, Geary's C)?
- Spatial domains/niches detection (BayesSpace, SpaGCN)?
- Cell-cell interaction analysis (CellChat, NicheNet for spatial)?
- Ligand-receptor pairs - spatial proximity threshold?

**Integration with scRNA-seq**:
- Reference for deconvolution (cell2location, SPOTlight)?
- Matching tissue type and condition?

**Sample Size**:
- N≥10 sections for robust spatial patterns
- Technical replicates (adjacent sections) vs biological?

**Critical questions for spatial**:
- "Visium 55μm spots mix multiple cell types - cell2location deconvolution planned?"
- "Spatial autocorrelation will inflate significance - spatial FDR correction method?"
- "Using scRNA-seq reference from different tissue region - appropriate match?"
- "Only 3 sections - spatial patterns may be section-specific artifacts"
- "Image registration manual - prone to bias. Automated method available?"

#### For Multi-Omics Projects

**Integration Challenges**:
- Different sample sizes across modalities - how handled?
- Different features (genes vs proteins vs metabolites) - comparable scales?
- Integration method specified (MOFA, mixOmics, MultiCCA)?

**Modality-Specific Normalization**:
- Each modality normalized separately before integration?
- Normalization methods appropriate for each data type?

**Which Modality Drives**:
- One modality primary, others supporting?
- Equal weight to all - appropriate?
- Missing data in some modalities - imputation method?

**Biological Interpretation**:
- Cross-modality validation (e.g., protein confirms mRNA)?
- Discordances between modalities - how interpreted?

**Sample Matching**:
- Same biological samples across modalities?
- Temporal matching if different collection times?
- Sample quality varies by modality - QC strategy?

**Critical questions for multi-omics**:
- "scRNA-seq (N=50) and proteomics (N=20) - integration with different N?"
- "MOFA integration - but modalities measured on different samples? Not directly integrable"
- "RNA and protein often discordant due to post-transcriptional regulation - interpretation plan?"
- "Missing proteomics data for 30% of samples - impute or restrict to complete cases?"

#### For Genomics (WGS, WES, SNP arrays)

**Variant Calling**:
- Caller appropriate for data type (GATK, Freebayes, DeepVariant)?
- Germline vs somatic variant calling?
- Coverage depth adequate (WGS: 30x, WES: 100x)?
- Filtering criteria (VQSR, hard filters)?

**Population Structure**:
- Ancestry-matched controls?
- PCA for population stratification?
- Admixture modeling if diverse cohort?

**Association Testing**:
- Multiple testing burden (millions of SNPs)?
- Genome-wide significance threshold (5×10⁻⁸)?
- LD-based clumping for independent signals?

**Functional Annotation**:
- Variant consequence (missense, nonsense, splice)?
- Pathogenicity prediction (CADD, PolyPhen)?
- Population frequency (gnomAD)?

**Sample Size**:
- GWAS: N≥10,000 for common variants
- Rare variant burden: N≥1000 cases
- WES: N≥100 for dominant Mendelian

**Critical questions for genomics**:
- "WGS at 15x coverage - borderline for reliable variant calling, especially indels"
- "Testing 5M SNPs - need genome-wide significance p<5×10⁻⁸, not p<0.05"
- "No population structure correction - but diverse ancestry reported. PCA essential"
- "Expecting to find rare disease variants with gnomAD MAF filter >1% - contradictory"
- "N=50 for GWAS - vastly underpowered. Need N>5000 or focus on high-penetrance variants"

### 7. Generate Findings and Append to Templates

For each field/section reviewed:

1. **Identify issues** across relevant dimensions
2. **Assess severity**:
   - 🔴 CRITICAL: Fundamental flaw, must fix before proceeding
   - 🟡 WARNING: Significant concern, should address for success
   - 🔵 SUGGESTION: Improvement opportunity, consider for rigor
   - 💡 ALTERNATIVE: Different approach worth considering
3. **Format as review block** following template from Section 3
4. **Append to template** immediately after relevant field/section
5. **Track metrics**: Count of each severity level for summary

**Filtering by threshold**:
- If `--threshold critical`: Only append 🔴 findings
- If `--threshold warning`: Append 🔴 and 🟡 findings
- If `--threshold suggestion`: Append 🔴, 🟡, and 🔵 findings
- Default (`all`): Append all findings including 💡

**Filtering by focus area**:
- If focus specified: Only append findings from that dimension
- Default (`all`): Append findings from all dimensions

### 8. Update Template Metadata

After appending all review comments to a template:

**Update version string**:
```markdown
*Document version: {0.1-reviewed-20251030} | Last updated: 2025-10-25 | Last reviewed: 2025-10-30*
```

**Add review history section** at end of template (before final line):
```markdown
---
## Review History

### Review 2025-10-30
- **Reviewer**: biospec.review_intent
- **Focus**: {all areas | specific focus}
- **Mode**: {balanced | gentle | harsh}
- **Findings**: 🔴 {count} Critical | 🟡 {count} Warnings | 🔵 {count} Suggestions | 💡 {count} Alternatives
- **Status**: {Ready to proceed | Needs revision | Major concerns}
- **Priority Actions**:
  1. [Most critical issue to address]
  2. [Second most critical]
  3. [Third most critical]
```

### 9. Generate Review Summary

Create `project/_review_summary.md` with overview:

```markdown
# Critical Review Summary: {Project Title}

**Reviewed**: {YYYY-MM-DD}
**Review Mode**: {balanced | gentle | harsh}
**Focus Areas**: {all | specific}
**Severity Threshold**: {all | warning | critical}

## Templates Reviewed

- ✓ project_overview.md (v{X})
- ✓ intent.md (v{X})
- ✓ datasets.md (v{X})
- ✓ project_resources.md (v{X}) [if reviewed]
- ✓ relationships.md (v{X}) [if reviewed]

## Executive Summary

**Overall Assessment**: {Ready to proceed | Needs minor revision | Needs major revision | Not ready}

**Findings Summary**:
- 🔴 **Critical Issues**: {count} - Must address before proceeding
- 🟡 **Warnings**: {count} - Should address for project success
- 🔵 **Suggestions**: {count} - Consider for improved rigor
- 💡 **Alternatives**: {count} - Different approaches proposed

## Critical Issues Requiring Immediate Attention

{If any 🔴 issues exist, list them here with links to template locations}

1. **[Template: Field]**: {Brief issue description}
   - **Location**: {template_name.md - section name}
   - **Impact**: {Why this is critical}
   - **Action**: {What to do}

2. [Continue for all critical issues]

{If no critical issues:}
✓ No critical issues identified

## Warnings to Address

{If any 🟡 issues exist, list top 5 here}

1. **[Template: Field]**: {Brief issue description}
2. [Continue for top warnings]

{If threshold filtered out warnings:}
_Warnings filtered by threshold setting. See individual templates for all findings._

## Key Themes Across Review

{Identify patterns or recurring issues across multiple sections}

- **Sample size concerns**: Multiple RQs may be underpowered with current N
- **Reproducibility gaps**: Environment specification incomplete
- **Scope creep risk**: Many "nice to have" objectives that expand scope significantly
- [Other themes]

## Suggested Alternatives

{If any 💡 alternatives proposed, highlight notable ones}

1. **{Area}**: Consider {alternative approach} instead of {current approach}
   - **Advantages**: {why alternative might be better}
   - **Trade-offs**: {what you lose with alternative}

## Recommended Next Steps

1. **Immediate** (before proceeding):
   - Address all 🔴 critical issues listed above
   - [Specific actions for critical issues]

2. **Short-term** (before analysis begins):
   - Review and address 🟡 warnings
   - Consider high-value 🔵 suggestions (especially regarding {specific area})

3. **Optional** (for improved rigor):
   - Evaluate 💡 alternative approaches
   - Implement remaining 🔵 suggestions

4. **Re-review**:
   - After addressing critical issues, consider re-running review
   - Command: `/biospec.review_intent` to check if issues resolved

## Notes

- Detailed review comments appended to each template field
- Review comments marked with `[REVIEW {date}]` and severity emoji
- Templates updated with review metadata and version stamps
- This summary provides overview - see templates for full detail

---

*This review was generated by biospec.review_intent to identify potential issues before significant time investment. Review feedback is skeptical by design - not all concerns may apply to your specific context. Use judgment to determine which feedback is most relevant.*
```

### 10. Report Completion

After review complete, output summary message:

```markdown
## Review Complete: {Project Title}

**Templates Reviewed & Updated**:
- ✓ project_overview.md (v{X} → v{X-reviewed-YYYYMMDD})
- ✓ intent.md (v{X} → v{X-reviewed-YYYYMMDD})
- ✓ datasets.md (v{X} → v{X-reviewed-YYYYMMDD})
{+ optional templates if reviewed}

**Review Summary**: `project/_review_summary.md`

**Findings**:
- 🔴 Critical: {count} {if >0: "- MUST ADDRESS BEFORE PROCEEDING"}
- 🟡 Warnings: {count} {if >0: "- Should address for project success"}
- 🔵 Suggestions: {count}
- 💡 Alternatives: {count}

**Overall Assessment**: {Ready | Needs Revision | Major Concerns}

{If critical issues:}
⚠️ **CRITICAL ISSUES FOUND** - Address these before proceeding:
1. {Brief description of top critical issue}
2. {Second critical issue if exists}
[List up to 3 most critical]

See detailed review comments in template files (marked with [REVIEW {date}]).

{If no critical issues:}
✓ No critical issues blocking progress. Review warnings and suggestions to strengthen project.

**Next Steps**:
1. Review inline comments in templates (look for `[REVIEW {date}]` blocks)
2. Address critical issues (🔴) if any
3. Consider warnings (🟡) and suggestions (🔵)
4. Update templates based on feedback
5. Re-run review after major changes: `/biospec.review_intent`

**Note**: This review applies a skeptical lens to identify potential weaknesses. Not all concerns may be relevant to your specific context. Use scientific judgment to determine which feedback to incorporate.
```

### 11. Error Handling

Handle these error conditions:

| Error Condition | Action |
|----------------|--------|
| No `project/` directory | ERROR "No project/ directory found. Run /biospec.create_project or /biospec.parse_existing_project first." |
| No intent.md | ERROR "project/intent.md not found. Cannot review intent without intent template." |
| Templates mostly empty | WARN "Templates appear mostly unfilled. Review will be limited. Consider populating templates more fully before review." |
| Invalid focus area | ERROR "Unknown focus area: {area}. Valid options: all, scientific rigor, statistical validity, feasibility, data quality, scope alignment, reproducibility, murphy's law" |
| Invalid threshold | ERROR "Unknown threshold: {threshold}. Valid options: all, critical, warning, suggestion" |
| Invalid mode | ERROR "Unknown mode: {mode}. Valid options: balanced, gentle, harsh" |
| Template file read error | ERROR "Cannot read template: {template}. Check file permissions." |
| Template write error | ERROR "Cannot write to template: {template}. Check file permissions." |

---

## General Guidelines

### Skeptical Questioning Approach

**DO**:
- Challenge assumptions explicitly stated or implied
- Ask "what if" questions for failure scenarios
- Cite benchmarks, typical values, literature when questioning
- Provide specific, actionable recommendations
- Suggest alternatives when criticizing approach
- Be constructive even when harsh - focus on improvement
- Use evidence to support critiques (not just opinions)
- Consider domain-specific norms and practices
- Acknowledge when uncertainty is acceptable (exploratory work)

**DON'T**:
- Be skeptical just to be difficult - critiques must be substantive
- Demand perfection where exploratory is appropriate
- Apply one-size-fits-all standards without domain context
- Criticize without suggesting how to improve
- Flag issues already addressed in other template sections
- Repeat the same issue multiple times
- Use jargon without explanation
- Make assumptions about resources/knowledge without checking

### Balanced Skepticism

**For Exploratory Projects**:
- Don't demand specific hypotheses
- Accept broader research questions
- Focus on feasibility and data quality
- Suggest how to make discoveries actionable
- Validate that "exploration" isn't excuse for sloppiness

**For Targeted Projects**:
- Expect clear hypotheses with null/alternative
- Demand power analysis or justification
- Scrutinize sample size carefully
- Question success criteria rigorously
- Validate statistical framework thoroughly

**For Pilot/Preliminary Work**:
- Lower bar for sample size (but acknowledge limitation)
- Focus on what can be learned with constraints
- Emphasize clear next steps with more resources
- Validate that pilot objectives are achievable
- Check that pilot will inform full study design

### Mode-Specific Tone Adjustment

**Balanced Mode** (default):
- Fair assessment with some skepticism
- Point out likely problems, not just possible problems
- Acknowledge strengths where present
- Mix of warnings and suggestions
- Constructive alternatives

**Gentle Mode**:
- Constructive criticism, encouraging tone
- Frame concerns as "considerations" not "problems"
- Lead with alternatives and suggestions
- Only flag truly critical issues as 🔴
- Acknowledge constraints and challenges

**Harsh Mode**:
- Maximum skepticism, assume Murphy's Law
- Challenge every assumption
- "What could go wrong" mentality
- More findings at higher severity
- Point out unlikely but possible problems
- Devil's advocate perspective

### Evidence-Based Critique

Always support critiques with:

**Benchmarks & Typical Values**:
- "Bulk RNA-seq typically requires N≥10-15 per group for 80% power"
- "scRNA-seq datasets usually have 30-50% of samples failing QC"
- "GWAS require p<5×10⁻⁸ for genome-wide significance"
- "{Tool X} on {data size} typically needs ~{RAM estimate}"

**Literature Citations** (when applicable):
- "Hart et al. (2013) show diminishing returns after N=15 for RNA-seq"
- "Recent benchmarks (Soneson & Robinson 2018) show Method A outperforms Method B for {use case}"
- "SEQC consortium established that N≥3 is minimum for DE, but N≥6 recommended"

**Known Issues**:
- "{Tool Y} has known convergence issues with sparse data (see GitHub issues)"
- "{Dataset Z} is known to have batch effects (reported in 3+ papers)"
- "{Method A} assumes normality, often violated in {data type}"

**Domain Expertise**:
- "In scRNA-seq, doublets typically 5-10% of cells depending on loading"
- "Visium 55μm spots capture 5-10 cells on average - cell type mixtures expected"
- "Spatial autocorrelation inflates p-values - spatial FDR correction needed"

### Prioritization of Feedback

**Most Important** (always flag as 🔴 Critical):
1. Sample size clearly insufficient for stated aims
2. No control samples when required
3. Statistical method fundamentally inappropriate
4. Required data not available
5. Fatal experimental design flaw

**Very Important** (flag as 🟡 Warning):
1. Sample size borderline/uncertain
2. Timeline unrealistic
3. Tool deprecated or unstable
4. Batch effects not addressed
5. Multiple testing not considered

**Important** (flag as 🔵 Suggestion):
1. Alternative method may be more robust
2. Additional validation would strengthen
3. Documentation incomplete
4. Resource estimates uncertain

**Nice to Have** (flag as 💡 Alternative):
1. Different approach with trade-offs
2. Simpler method with similar power
3. Additional data type to consider
4. Exploratory backup analyses

### Domain-Specific Sensitivity

**Adjust scrutiny based on field norms**:

- **Clinical/Translational**: Higher bar for sample size, controls, validation
- **Basic Biology**: More tolerance for exploratory, hypothesis-generating
- **Methods Development**: Focus on benchmarking, comparison to existing
- **Re-analysis**: Focus on novel angle, differentiation from prior work

**Acknowledge field-specific practices**:
- Some fields accept N=3 biological replicates as standard
- Some fields have different multiple testing traditions
- Some platforms have known limitations (Visium resolution, 10X doublet rate)
- Some data types have established pipelines (GATK for WGS, Seurat for scRNA-seq)

### Examples of Good vs Bad Feedback

**❌ Bad** (vague, unhelpful):
```markdown
🟡 WARNING: Sample size may be too small
- Issue: N=10 seems low
- Recommendation: Add more samples
```

**✓ Good** (specific, actionable, evidence-based):
```markdown
🟡 WARNING: Sample size borderline for differential expression detection
- **Issue**: N=10 per group provides ~60% power to detect 2-fold changes at alpha=0.05
- **Why this matters**: 40% of true DE genes will be missed (false negatives), limiting discovery
- **Evidence**: Standard power analysis for bulk RNA-seq (Hart et al. 2013) suggests N≥12-15 per group for 80% power
- **Recommendation**:
  - Ideal: Increase to N=15 per group for robust DE detection, OR
  - Acceptable: Proceed with N=10 but acknowledge power limitation in methods, focus on larger effect sizes (>2-fold), plan validation of top hits
- **Alternative**: Use single-cell resolution (if available) to gain statistical power from cell-level replicates
```

---

## Notes

- This review is intentionally skeptical - helps identify weaknesses before major time investment
- Not all concerns will apply to every context - use scientific judgment
- Review feedback is constructive - goal is to strengthen project, not block it
- Multiple review passes OK - initial review harsh, later reviews gentler as issues addressed
- Review comments are appended inline - easy to see what needs improvement
- Users can remove/mark-resolved review comments after addressing issues
- Re-run review after major template updates to check if issues resolved
