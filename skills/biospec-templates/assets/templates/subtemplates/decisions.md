---
template_name: Decisions Register
schema_version: 0.3.0
last_updated: YYYY-MM-DD
---

---
**Navigation**: [Project Overview](../project_overview.md) | [Intent Overview](../intent_overview.md) | [Dataset Overview](../dataset_overview.md) | [Analysis Overview](../analysis_overview.md) | [Dependencies](../dependencies.md) | [Project Resources](../project_resources.md)

---

# Decisions Register

<!--
A running log of project-level decisions: what was chosen, what was rejected,
why, and when to revisit. Append new entries; do not edit historic ones in
place — superseded decisions should be marked superseded and reference the
new entry's id.

Place this file at biospec/registers/decisions.md when scaffolding a project.
Each `## Decision {n}` block below is one entry. Add new entries as needed.
-->

## Decision {n}
- **id**: D{n}
- **date**: YYYY-MM-DD
- **topic**: <!-- One-line topic, e.g. "Batch correction tool", "Cohort inclusion criterion" -->
- **decision**: <!-- The choice that was made -->
- **rationale**: <!-- Why this choice over the alternatives -->
- **alternatives_considered**: <!-- The other options on the table and why they were not selected -->
- **revisit_when**: <!-- The condition that would cause this decision to be re-opened (cohort grows, new tool released, performance unacceptable, etc.) -->

## Notes
<!--
Free-form notes about decision-making process or things that don't fit a
single decision entry. Keep this section short — most content belongs in
numbered Decision entries above.
-->
