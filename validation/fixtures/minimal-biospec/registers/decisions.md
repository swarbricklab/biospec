---
template_name: Decisions Register
schema_version: 0.3.0
last_updated: 2026-05-25
---

# Decisions Register

A running log of project-level decisions: what was chosen, why, what
alternatives were considered, and when to revisit.

## Decision 1
- **id**: D1
- **date**: 2026-04-15
- **topic**: Batch correction tool
- **decision**: Use Harmony over BBKNN or scVI
- **rationale**: Faster on this cohort size; team familiar with the API
- **alternatives_considered**: BBKNN (graph-only, harder to inspect), scVI (probabilistic, longer training)
- **revisit_when**: Cohort size exceeds 200 patients or batches grow beyond 8
