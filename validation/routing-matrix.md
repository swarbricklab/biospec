# BioSpec skill routing matrix

This matrix is the **RED phase** of skill authorship (per Vincent's superpowers
red-green-refactor). Every description must route its positive prompt and reject
its near-miss prompt. A failure here is fixed by sharpening the description,
not by patching the skill body.

Run every row against both Claude Code and Codex before the v0.3.0 merge gate
(Phase 6). Cross-model spot-check on Opus and Sonnet — if firing differs, the
description still isn't specific enough.

## How to walk this matrix

1. Start a fresh agent session in a workspace with the seven skills installed.
2. Read the **Prompt** column verbatim to the agent.
3. Observe which skill (if any) routes.
4. Check against the **Expected route** column.
5. For the **Behavioural assertion**, follow the prompt through and confirm.
6. Mark the row pass/fail. Failures: sharpen the description, retest.

The fixture lives at `validation/fixtures/minimal-biospec/` — `cd` into it
before running any prompt that touches files.

## Per-skill rows

### `using-biospec`

| Prompt class | Prompt | Expected route | Behavioural assertion |
|---|---|---|---|
| Positive | `Plan how to add a new RNA-seq batch correction step. We have a biospec/ directory.` | `using-biospec` auto-loads via state predicate (biospec/ marker); planning proceeds with BioSpec context loaded. | Agent reads project_overview.md + relevant subtree before proposing edits. |
| Near-miss | `Plan how to set up a new Python project.` | No BioSpec skill routes. | Agent does generic planning without trying to scaffold biospec/. |

### `biospec-setup`

| Prompt class | Prompt | Expected route | Behavioural assertion |
|---|---|---|---|
| Positive | `Set up biospec in this repo.` | `biospec-setup` | Scaffolds biospec/{intents,datasets,analyses,registers}/ from bundled templates, stamps dates programmatically, offers bootstrap snippet, asks one confirmation; does not manually reproduce template Markdown. |
| Near-miss | `Set up a new Python project for me.` | No BioSpec skill routes. | No biospec/ directory created. |

### `biospec-autofill`

| Prompt class | Prompt | Expected route | Behavioural assertion |
|---|---|---|---|
| Positive | `Here's a grant proposal (proposal.md attached). Populate the biospec docs from it.` | `biospec-autofill` | If scope is unclear, asks project-domain areas with "all likely" as default; then reads proposal.md, direct-fills only high-confidence non-conflicting fields, cites source path + excerpt, leaves uncertain fields blank, reports compactly. |
| Near-miss | `Update intent-1.md to change "Hypothesis: cell type X drives Y" to "Hypothesis: cell type X correlates with Y".` | `biospec-edit` (user-dictated, no external source) | NOT autofill. |

### `biospec-edit`

| Prompt class | Prompt | Expected route | Behavioural assertion |
|---|---|---|---|
| Positive | `Change the success criterion on intent-1 to require p<0.01.` | `biospec-edit` | Proposes Before/After diff, waits for explicit approval, then applies. Preserves storyboard repeated-header blocks. |
| Near-miss | `Review intent-1 for me.` | `biospec-review` | NOT edit. Read-only output. |

### `biospec-review`

| Prompt class | Prompt | Expected route | Behavioural assertion |
|---|---|---|---|
| Positive (critical) | `Review intent-1 — are the success criteria specific enough?` | `biospec-review` (Critical mode) | States assumed mode (Critical). Loads references/scientific-rigor.md. Returns structured critique. NEVER writes. |
| Positive (exploratory) | `What other clustering methods could I consider for dataset-1?` | `biospec-review` (Exploratory mode) | States assumed mode (Exploratory). Discusses options + trade-offs. NEVER writes. |
| Near-miss | `Apply the fixes you just suggested.` | `biospec-edit` (review redirects to edit for application) | Review explicitly refuses to write; recommends biospec-edit. |

### `biospec-sync`

| Prompt class | Prompt | Expected route | Behavioural assertion |
|---|---|---|---|
| Positive (links) | `Validate the cross-references in biospec/ and fix anything broken.` | `biospec-sync` mode=links | Dry-run diff first, applies on approval. Bidirectional links checked. 5 suggestions max per round. |
| Positive (diagram) | `Regenerate the dependency diagram.` | `biospec-sync` mode=diagram | Scans intents/datasets/analyses, builds mermaid LR graph, proposes diff to dependencies.md, applies on approval. |
| Near-miss | `What's the status of my biospec docs?` | No BioSpec skill routes (status workflow dropped). | Agent answers from project_overview.md or asks the user what they mean. |

### `biospec-templates`

| Prompt class | Prompt | Expected route | Behavioural assertion |
|---|---|---|---|
| Positive | `What fields does the dataset template have for sensitive-data classification?` | `biospec-templates` | Reads references/schema.md, returns field-by-field answer. No writes. |
| Near-miss | `Add a new field to the dataset template.` | `biospec-templates` refuses (masters are pristine). Routes to issue/PR conversation instead. | Iron Law: NEVER MODIFY assets/templates/ DIRECTLY. |

## Mixed-signal boundary rows (the hard ones)

These rows exist because the descriptions interact. If the routing here drifts,
the descriptions are bleeding into each other.

| # | Prompt | Expected route | Why |
|---|---|---|---|
| M1 | `Here's the protocol PDF — update intent-2 to reflect the new endpoints.` (PDF attached) | `biospec-autofill` | External source + edit-shaped instruction → autofill wins. Direct-fills cited non-conflicting source facts. |
| M2 | `Set the priority on intent-1 to High based on these notes.` (no notes attached) | `biospec-edit` | User-dictated value, no external source → edit. |
| M3 | `Can you discuss whether intent-1's hypothesis is testable? Be critical.` | `biospec-review` Critical | "Discuss" + "critical" → review wins over discuss. Critical mode declared. |
| M4 | `Let's brainstorm some hypotheses for dataset-1.` | `biospec-review` Exploratory | Brainstorm phrasing → Exploratory mode declared. |
| M5 | `Tell me where the analysis template lives and what its frontmatter looks like.` | `biospec-templates` | Schema/structure question → templates skill. |

## Cross-cutting behavioural assertions

These must hold across every write-capable skill route. Walk them per phase
during validation.

- **No invention.** Agent leaves fields blank rather than guessing.
- **Write mode respected.** Autofill direct-fills cited high-confidence,
  non-conflicting source facts; setup/edit/sync propose before applying.
- **Autofill intake.** Options use project domains, not internal doc filenames;
  repo-scan prompts ask depth and accept free-text paths/folders.
- **Source citation required.** Autofill cites path + excerpt for nontrivial
  fills. Edit cites the user instruction.
- **Deletion confirmed.** Any delete requires explicit OK after impact analysis.
- **Mode signalled when ambiguous.** Review states its assumed mode in one
  sentence at the top of its response.
- **Storyboard blocks preserved.** Repeated `### Step {s}` headers must not be
  collapsed to a table.
