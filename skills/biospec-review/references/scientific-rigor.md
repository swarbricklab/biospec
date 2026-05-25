# Scientific rigour checklist (Critical-mode lens)

Used by `biospec-review` when the user asks for critique. Load this only in
Critical mode — Exploratory mode does not apply this lens.

## Contents
- [Pre-flight: read these fields before critiquing](#pre-flight-read-these-fields-before-critiquing)
- [Intent-level critique](#intent-level-critique)
- [Dataset-level critique](#dataset-level-critique)
- [Analysis-level critique](#analysis-level-critique)
- [Cross-cutting concerns](#cross-cutting-concerns)
- [Critique output discipline](#critique-output-discipline)

## Pre-flight: read these fields before critiquing

Before raising any concern, confirm you have read:
- The named subtemplate's `Statement` / `Description` field.
- The `Success Criteria` and (intent only) `Decision rule / what would change our mind`.
- The `Related Components` block, plus the one-hop linked files.
- Relevant `registers/decisions.md` entries — a "missing control" may already be a logged decision with a recorded rationale.

If a concern depends on context outside this read-set, say so explicitly and ask permission to widen.

## Intent-level critique

For `biospec/intents/intent-{n}.md`:

- **Specificity**. Is the *Statement* phrased so a stranger could tell whether the intent has succeeded? "Characterise X" rarely is. "Identify TIL subsets whose abundance differs between recurrence and non-recurrence at HR > 1.3, FDR < 0.1" is.
- **Decision rule**. Is the falsifier objective and pre-committed? If "nothing would change our mind", the intent is unscientific in the Popperian sense.
- **Mode coherence**. Does the declared `Mode` (targeted / exploratory / methods-dev) match the structure? A `targeted` intent without hypotheses is suspicious; an `exploratory` intent with a single primary endpoint is suspicious.
- **Hypothesis quality** (if present). Null and alternative hypotheses both stated? Alternatives directional or non-directional and that choice explicit? Rationale grounded in cited prior work or stated as assumption?
- **Outcomes**. Are *Expected Outcomes* measurable? Tied to specific tests / metrics / artefacts?
- **Power.** Has the intent considered what cohort size or effect size it needs to detect? (Often missing.)
- **Alternative hypotheses**. Are competing explanations acknowledged?

## Dataset-level critique

For `biospec/datasets/dataset-{n}.md`:

- **Inclusion/exclusion**. Stated explicitly? Reproducible from the criteria alone?
- **Cohort definition**. Could a reader regenerate the cohort? Or is the cohort a fait accompli with no documented selection logic?
- **Batch effects**. Listed? Are batch variables in the metadata? Is there a plan to model them?
- **Sample size and power**. Stated, with the analysis's required sample size in mind?
- **Missingness**. Acknowledged? Per-variable rates known? Mechanism (MCAR / MAR / MNAR) considered?
- **Governance gaps**. Is *Permitted uses* specific enough to cover the analyses planned? Are *Forbidden uses* enforced (e.g. no re-identification in downstream pipelines)?
- **Provenance**. Accession/DOI present where the source is public? Internal version captured where in-house?
- **Quality status**. Up to date with the actual QC outcome, not a stale planning entry?
- **Linkage**. Are the dataset's connections to specific intents / analyses clear and bidirectional?

## Analysis-level critique

For `biospec/analyses/analysis-{n}.md`:

- **Endpoints and primary contrasts**. Defined? Aligned with the linked intent's Statement and Success Criteria?
- **Analysis Flow**. Each `### Step {s}` self-contained — clear inputs, outputs, key choices? Or hand-wave?
- **Confounding**. Acknowledged covariates and their handling (regression terms, stratification, matching)?
- **Multiple testing**. Correction method, family, threshold stated? Family appropriate (within-analysis vs across-intents)?
- **Leakage**. Outcome variables fenced out of feature selection / clustering / HVG calling?
- **Sensitivity**. Plan to vary resolution / threshold / batch / tool? Or single-pipeline reporting?
- **Controls**. Positive and negative controls identified where applicable (e.g. known marker genes, healthy reference, permuted labels)?
- **Reproducibility**. Environment pinned (lockfile)? Seeds set? Output location stable?
- **Failure modes**. Concrete fallbacks specified? Tied to the intent's decision rule?

## Cross-cutting concerns

- **Intent → Dataset → Analysis coherence**. Does the analysis actually answer the intent on the linked dataset, or is there a transitive gap (intent asks A, analysis answers B)?
- **Resource feasibility**. Does `project_resources.md` show the compute / storage / software the analysis requires? Or is there an implicit ask?
- **Decision-rule alignment**. Does the analysis's Failure modes section say what happens when the intent's decision rule fires?
- **Scope creep**. Are there fields with content that goes beyond what the intent committed to? Surface it.
- **Internal consistency**. Sample counts in `dataset.md` consistent with assumptions in `analysis.md`? Output locations consistent across linked files?

## Critique output discipline

For each concern, structure the entry as:

- **Observation** — quote or specific reference (filename + section).
- **Issue** — the scientific or practical flaw.
- **Why it matters** — the downstream consequence.
- **Alternatives & Suggestions** — concrete options, with pros/cons. Do NOT write the fix.
- **Question/Prompt** — a question that forces the user to resolve it.

Group by severity: **Major Concerns**, **Minor Clarifications**, **Missing Information**. Skip empty groups.

Tone: professional, objective, direct. Avoid softening every observation with praise — be honest. If something is genuinely strong, say so once.

Do **not** rewrite text or propose a Before/After. Point at the hole and offer alternatives. The user goes to `biospec-edit` (or fixes manually) once they have decided.
