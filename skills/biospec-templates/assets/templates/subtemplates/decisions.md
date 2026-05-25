---
template_name: Decisions Register
schema_version: 0.3.1
last_updated: YYYY-MM-DD
---

---
**Navigation**: [Project Overview](../project_overview.md) | [Intent Overview](../intent_overview.md) | [Dataset Overview](../dataset_overview.md) | [Analysis Overview](../analysis_overview.md) | [Dependencies](../dependencies.md) | [Project Resources](../project_resources.md)

---

# Decisions Register

<!--
A running log of project-level decisions: what was chosen, what was rejected,
why, and when to revisit. Append new entries; do not edit historic ones in
place — when superseding, set the old entry's `status` to `superseded` and its
`superseded_by` to the new entry's id, and set the new entry's `supersedes` to
the old id.

Place this file at biospec/registers/decisions.md when scaffolding a project.
Each `## Decision {n}` block below is one entry. Add new entries as needed.

## When to log a decision here

Use this register if the decision (a) affects more than one intent/dataset/
analysis, (b) is reversible-but-costly, or (c) someone outside the immediate
author needs to find it later (handoff, audit, manuscript methods).

Decisions that stay scoped to a single analysis step live inline in
analysis.md → Analysis Flow → Step → Parameters & choices. Decision rules
about *what would change our mind* about a research intent live in
intent.md → Falsifier. Quality-related decisions about a specific dataset
live in dataset.md → Quality status.

Note on IDs: decision records use the `DR{n}` prefix (renamed from `D{n}` in
0.3.1 to avoid clashing with Dataset nodes in dependencies.md).
-->

## Decision {n}
- **id**: DR{n}
- **date**: YYYY-MM-DD
- **title**: <!-- One-line summary, e.g. "Batch correction tool", "Cohort inclusion criterion" -->
- **status**: proposed | active | superseded | deferred | reversed
  <!--
  - proposed: under discussion, not yet acted on
  - active: in effect
  - superseded: replaced by a later decision (set superseded_by)
  - deferred: parked pending more information
  - reversed: tried, reversed; revisit_when is the post-mortem trigger
  -->
- **decision**: <!-- The choice that was made -->
- **rationale**: <!-- Why this choice over the alternatives -->
- **alternatives_considered**: <!-- The other options on the table and why they were not selected -->
- **scope / affects**:
  <!-- Cross-link IDs of intents/datasets/analyses this decision applies to.
       E.g., "I1, I2; D1; A2, A4". Mirrors Related Components below. -->
- **decision_maker(s)**:
  <!-- Who approved. Critical for clinical / governance / cost decisions where
       PI or steward sign-off is required. -->
- **reversibility**: one-way door | two-way door
  <!-- one-way door: hard or expensive to undo (e.g. consent re-contact, public
       data release, cohort closure). Warrants heavier review.
       two-way door: easy to revert (e.g. parameter choice, tool swap). -->
- **confidence**: low | medium | high
  <!-- How confident the team was at the time of the decision. Useful when
       revisiting — low-confidence decisions get the benefit of the doubt for
       re-opening. -->
- **evidence**:
  <!-- References that informed the decision: papers, internal benchmarks,
       notebooks, prior decisions (DR{m}), external guidance. -->
- **supersedes**: <!-- DR{m} this entry replaces, if any -->
- **superseded_by**: <!-- DR{m} that replaces this entry, if status is `superseded` -->
- **revisit_when**:
  <!--
  The condition that would cause this decision to be re-opened. Examples:
  - cohort grows past N participants
  - new tool released with materially better performance
  - benchmark threshold not met
  - regulatory or ethics change
  - prior assumption shown to be wrong by analysis X
  -->

## Related Components
<!--
Cross-links from this register to the components touched by the decisions
above. Append per-entry pointers as the register grows; or use the per-entry
`scope / affects` field above and leave this section as a roll-up.
-->

**Affects Intents**:
- [Intent {n}: {Short Identifier}](../intents/intent-{n}.md)

**Affects Datasets**:
- [Dataset {n}: {Name}](../datasets/dataset-{n}.md)

**Affects Analyses**:
- [Analysis {n}: {Descriptor}](../analyses/analysis-{n}.md)

## Notes
<!--
Free-form notes about decision-making process or things that don't fit a
single decision entry. Keep this section short — most content belongs in
numbered Decision entries above.
-->
