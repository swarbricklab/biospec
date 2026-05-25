---
template_name: Computational Task/Analysis
analysis_id: {n}
schema_version: 0.3.0
last_updated: YYYY-MM-DD
---

---
**Navigation**: [Project Overview](../project_overview.md) | [Intent Overview](../intent_overview.md) | [Dataset Overview](../dataset_overview.md) | [Analysis Overview](../analysis_overview.md) | [Dependencies](../dependencies.md) | [Project Resources](../project_resources.md)

---

# Analysis {n}: {Short Descriptor}
<!-- This template represents a single computational analysis objective or task. Replace {n} with a number, avoiding duplicates -->

## Description
<!-- Summarize the analysis -->

## Input Data
<!-- Specific data inputs for this analysis. For tool development: requirements, specifications, existing code to integrate with. -->
- **Primary input**:
- **Subset/filters**:
- **Required preprocessing**: 

## Priority
**Priority Level**: Must Have | Nice to Have | Future Consideration

**Priority Rationale**: 
<!-- Why is this analysis at this priority level? -->

## Analysis Flow
<!--
Storyboard the analysis as a sequence of discrete steps. Use one repeated
`### Step {s}` block per step, in execution order. Do NOT collapse these
into a single table — the repeated-header format is intentional and lets
downstream editors / reviewers comment per step.

Each step block should be short: what runs, what comes in, what comes out,
key choices made and why.

Replace {s} with a number (1, 2, 3...). Add as many `### Step {s}` blocks
as the analysis needs.
-->

### Step {s}: {Short verb-phrase}
- **What runs**: <!-- The tool, function, or notebook executed in this step -->
- **Inputs**: <!-- Data/files/parameters consumed -->
- **Outputs**: <!-- Files/objects produced -->
- **Key choices**: <!-- Parameter choices, normalisation, filters, thresholds — and why -->

## Execution & Reproducibility
<!--
Everything needed for another person — or future-you — to re-run this analysis
and get the same result. If a field doesn't apply, leave it blank rather than
inventing a value.
-->
- **Environment**: <!-- Language + version, key package versions, lockfile path (e.g., renv.lock, environment.yml, requirements.txt) -->
- **Random seeds**: <!-- Seeds used for reproducible stochastic steps (clustering, sampling, train/test split) -->
- **Compute**: <!-- Hardware profile and expected wall-time / memory ceiling -->
- **Output location**: <!-- Where results are written; relative to project root or absolute path -->

## Expected Outputs
**Primary Outputs**:
- 

**Intermediate/Additional Files**:
- 

**Visualizations to Create**:
- 

## Assumptions & Limitations
<!-- Key assumptions underlying this analysis and known limitations. E.g., assumes samples are independent, limited to human data, requires minimum sample size. -->
- 

## Success Criteria
<!-- How will we know this analysis is complete? -->

**Criteria**:
- 

## Validation Strategy
<!--
Break validation out by concern. Leave blanks for fields that don't apply, but
think about each — these are the failure modes that catch up with a project
late. For tool/method development, repurpose these (unit/integration tests,
benchmarks, acceptance criteria) under the same headings.
-->

### Controls
<!-- Positive/negative controls. Known-good or known-bad inputs whose results you can sanity-check against. -->
-

### Sanity checks
<!-- Quick checks that intermediate outputs look right (e.g., marker gene specificity, sample sheet alignment, expected sample counts). -->
-

### Leakage
<!-- Information that must NOT cross the boundary between training/test, discovery/validation, or model input/outcome. -->
-

### Sensitivity
<!-- Robustness to parameter choices, alternate batches, alternative tools. Where will you vary inputs to confirm results are not artefacts? -->
-

### Multiple testing
<!-- Correction approach (BH FDR, Bonferroni, FWER), the family being corrected over, and the threshold. -->
-

### Failure modes
<!-- What does failure look like? What alternative will you try if the primary approach fails? Link back to the Intent's decision rule where applicable. -->
-

## Related Components
<!-- Links to related components -->

**Addresses Intents**:
<!-- List intent IDs this analysis helps address -->
- [Intent {n}: {Short Identifier}](../intents/intent-{n}.md)

**Uses Datasets**:
<!-- List dataset IDs this analysis operates on. For tool development tasks without data dependencies, this may be N/A. -->
- [Dataset {n}: {Name}](../datasets/dataset-{n}.md)

**Back to Overview**: [Analysis Overview](../analysis_overview.md)


## Notes
<!-- Any additional notes or considerations -->
