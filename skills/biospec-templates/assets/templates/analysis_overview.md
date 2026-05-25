---
template_name: Analysis Overview
schema_version: 0.3.1
last_updated: YYYY-MM-DD
---

# Analysis Overview

<!-- This file orchestrates and aggregates all computational analyses for the project -->

---
**Navigation**: [Project Overview](project_overview.md) | [Intent Overview](intent_overview.md) | [Dataset Overview](dataset_overview.md) | [Analysis Overview](analysis_overview.md) | [Dependencies](dependencies.md) | [Project Resources](project_resources.md)

---

## Analyses
<!-- Computational analysis objectives organized by priority -->

### Must Have (High Priority)
<!-- Links to critical analysis files -->
1. [Analysis {n}: {Descriptor}](analyses/analysis-1.md)

### Nice to Have (Moderate Priority)
<!-- Links to secondary analysis files -->
- [Analysis {n}: {Descriptor}](analyses/analysis-2.md)

### Future Considerations
<!-- Links to future analysis files -->
- [Analysis {n}: {Descriptor}](analyses/analysis-3.md)

<!-- Add new analyses by creating analysis-{n}.md in analyses/ and adding a row to the appropriate priority section above -->

## Summary Table
<!--
Aggregated view of all analyses.

Column mapping guidance:
- Analysis ID: link text should match the analysis title (`Analysis {n}: {Descriptor}`).
- Descriptor: mirrors the title — kept for table scannability.
- Priority: mirrors analyses/analysis-{n}.md → Priority Level; that file is the source of truth.
- Addresses Intents: comma-separated intent IDs (e.g. `I1, I2`).
- Uses Datasets: comma-separated dataset IDs (e.g. `D1, D3`).
- Status values: Planned | In Progress | Blocked | Complete | Deferred.
-->
| Analysis ID | Descriptor | Priority | Addresses Intents | Uses Datasets | Status |
|-------------|------------|----------|-------------------|---------------|--------|
| [Analysis 1: {Descriptor}](analyses/analysis-1.md)  |  | Must Have |  |  |  |
| [Analysis 2: {Descriptor}](analyses/analysis-2.md)  |  | Nice to Have |  |  |  |


## Overall Analysis Strategy
<!-- High-level computational considerations across all analyses -->

### Execution Order & Artefact Reuse
<!--
Narrative description of how analyses connect: which analysis's outputs feed
which downstream analysis, and the rationale for the ordering. Capture the
*what* (e.g. "analysis A1 produces a cleaned count matrix that A2 and A3
both consume") rather than restating the edge list — the authoritative edge
graph lives in dependencies.md (Project Graph).
-->
- 

### Sequencing Notes
<!--
Free-text notes on ordering, blockers, or sequencing risks across analyses.
The authoritative analysis-to-analysis dependency edges live in
dependencies.md (Project Graph) — use this section for narrative caveats
that the graph can't carry (e.g. "A4 should only start after A2 is locked
because of cohort overlap").
-->
- 
