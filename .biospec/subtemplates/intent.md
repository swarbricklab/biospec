---
template_name: Intent Document
intent_id: {n}
intent_type: question | aim | goal
schema_version: 0.1.1
last_updated: YYYY-MM-DD
---

---
**Navigation**: [Project Overview](../project_overview.md) | [Intent Overview](../intent_overview.md) | [Dataset Overview](../dataset_overview.md) | [Analysis Overview](../analysis_overview.md) | [Dependencies](../dependencies.md) | [Project Resources](../project_resources.md) | [Status](../status.md)

---

# Intent {n}: {Short Identifier}
<!-- This template represents a single research question, aim, or goal, along with its associated hypothes(is/es) and outcome(s) if applicable -->

## Statement
<!-- Provide the research question, aim, or goal -->
**Type**: Question | Aim | Goal

**Statement**: 

**Priority**: High | Medium | Low

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
- **Null Hypothesis**: <!-- The default assumption to be tested against -->
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
<!-- What defines success in addressing this intent? -->

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
