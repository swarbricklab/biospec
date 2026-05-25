---
template_name: Intent Document
intent_id: {n}
intent_type: question | aim | goal
schema_version: 0.3.1
last_updated: YYYY-MM-DD
---

---
**Navigation**: [Project Overview](../project_overview.md) | [Intent Overview](../intent_overview.md) | [Dataset Overview](../dataset_overview.md) | [Analysis Overview](../analysis_overview.md) | [Dependencies](../dependencies.md) | [Project Resources](../project_resources.md)

---

# Intent {n}: {Short Identifier}
<!-- This template represents a single research question, aim, or goal, along with its associated hypothes(is/es) and outcome(s) if applicable -->

## Statement
<!-- Provide the research question, aim, or goal -->
**Type**: Question | Aim | Goal

**Statement**: 

**Mode**: confirmatory | exploratory | methodological
<!--
- confirmatory: testing a specific, pre-specified hypothesis or aim (was "targeted" pre-0.3.1)
- exploratory: open-ended discovery; no fixed primary endpoint
- methodological: building / benchmarking a tool or workflow rather than testing biology (was "methods-dev" pre-0.3.1)
-->

**Priority**: High | Medium | Low

**Falsifier**:
<!--
The objective falsifier — the specific result (effect size, threshold, qualitative
pattern) that would cause you to abandon, pivot, or escalate this intent. If the
answer is "nothing would change our mind," the intent is not yet well-posed.
Renamed from "Decision rule / what would change our mind" in 0.3.1.
-->


## Framing
<!--
Context that bounds the intent. Mark fields N/A where they do not apply
(e.g. PICO/PECO for non-clinical intents). Where overlap with other templates
exists, this block holds the intent-specific view; project-wide context lives
in project_overview.md.
-->

- **PICO / PECO**:
  - Population:
  - Intervention / Exposure:
  - Comparator:
  - Outcome:
- **Expected effect size / minimum detectable effect (MDE)**:
  <!-- What you *expect* to see (e.g., HR ~1.5, OR ~2.0, Cohen's d ~0.4). Distinct
       from the Falsifier, which is what would *change your mind*. -->
- **Prior literature anchors**:
  <!-- 1-3 key citations specific to this intent. Project-wide references live in
       project_overview.md → Prior Work & Inspiration. -->
- **Stakeholders / audience**:
  <!-- Who cares about this answer? Clinicians, collaborators, funder milestone,
       downstream consumers. -->
- **Time horizon / exit criteria**:
  <!-- When does pursuing this stop being worthwhile? E.g., "stop investing if no
       signal by Q3"; "park if cohort accrual stalls below 50% by month 6".
       Distinct from the Falsifier (which is result-based, not time-based). -->
- **Pre-registration link**:
  <!-- OSF, clinicaltrials.gov, protocols.io, or internal protocol ID where
       applicable (especially for `confirmatory` mode). -->


<details>
<summary>Associated Hypotheses (expand if this intent involves testable hypotheses)</summary>

<!--
Only fill this section if there are testable hypotheses associated with this intent.
For exploratory intents or tool development goals, skip this section entirely.
-->

- **Does this intent have associated hypotheses?**: Yes | No

<!-- Repeat this block for each hypothesis present, replacing {h} with a number (1, 2, 3...) -->
### Hypothesis {h} Details
- **Short ID**: H{h}-{descriptor}
- **Statement**:
- **Rationale**: <!-- Why do you expect this hypothesis to be true? -->
- **Pre-specified**: Yes | No
  <!-- Yes = locked in before looking at the data (required for confirmatory mode and
       pre-registered analyses). No = generated post-hoc or during exploration. -->
- **Direction**: directional | non-directional
  <!-- directional: predicts the sign of the effect (e.g., "higher X → shorter survival").
       non-directional: predicts a difference without specifying sign. Affects one- vs
       two-sided testing. -->
- **Null Hypothesis**: <!-- The default assumption to be tested against. Frequentist framing
                          is the default; replace or omit for Bayesian designs. -->
- **Alternative Hypothesis**: <!-- What the data would support if null is rejected -->

</details> 

<details>
<summary>Expected Outcomes (expand to specify deliverables)</summary>

<!-- What outcomes are expected from addressing this intent? -->

<!-- Repeat this block for each outcome, replacing {n} with a number -->
**Outcome {n}**:
- **Statement**:
- **How it will be measured**: <!-- How will this outcome be measured or verified? For research: statistical tests, metrics. For tool development: tests passing, feature complete, user acceptance. -->
- **How it will be communicated/visualised**: <!-- How will this outcome be communicated? For research: figures, tables, reports. For tool development: documentation, demos, changelogs. -->

</details>


## Success Criteria
<!--
Scope this to *scientific* success — what would let the team say "we have an
answer worth defending" (e.g., "we can confidently rank the top 5 drivers of
relapse with stable ordering across two batches"). Operational/statistical
thresholds (FDR, AUC, model convergence) belong in analysis.md → Success
Criteria. The Falsifier above is the inverse: the result that would let us
say "we don't have an answer."
-->

**Criteria**:
- 

## Related Components
<!-- Links to related components -->

**Related Datasets**:
<!-- List dataset IDs that can address this intent. For tool development projects without data dependencies, this may be N/A. -->
- [Dataset {n}: {Name}](../datasets/dataset-{n}.md)

**Related Analyses**:
<!-- List analysis IDs needed to address this intent -->
- [Analysis {n}: {Descriptor}](../analyses/analysis-{n}.md)

**Back to Overview**: [Intent Overview](../intent_overview.md)

## Notes
<!-- Any additional notes or considerations -->
