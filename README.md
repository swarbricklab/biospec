# BioSpec

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL_v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

Structured templates and agent skills for documenting computational biology and bioinformatics research projects. The resulting specifications benefit human researchers, AI coding assistants, and reviewers — anyone who needs a stable project reference during development.

## Why BioSpec

Computational biology projects accumulate ad-hoc context that scatters across slide decks, grant proposals, meeting notes, and chat threads. AI coding agents in particular drift without a stable project reference. BioSpec defines a small, opinionated schema for that reference and ships a set of agent skills that help you populate, refine, and maintain it.

The skills enforce a few habits that matter for research code: no invention, propose-first writes, scope lock, source citations for any extracted content, and the distinction between background prior-work and what the project actually commits to. The schema is intentionally small — eight singleton overviews plus three repeated subtemplates (intents, datasets, analyses) plus a decisions register.

## Install

BioSpec ships as a plugin for any agent host that reads the SKILL.md format — Claude Code, Codex CLI, Codex App, Factory Droid, Gemini CLI, OpenCode, Cursor, GitHub Copilot CLI.

### Claude Code

```bash
git clone https://github.com/swarbricklab/BioSpec.git ~/.claude/plugins/biospec
```

Restart Claude Code. The seven skills (`using-biospec`, `biospec-setup`, `biospec-autofill`, `biospec-edit`, `biospec-review`, `biospec-sync`, `biospec-templates`) appear in `/skills`.

### Codex

```bash
git clone https://github.com/swarbricklab/BioSpec.git ~/.codex/plugins/biospec
```

Restart Codex. Same seven skills.

### Standalone (any SKILL.md-aware host)

Clone this repo and point your agent host at the `skills/` directory. The plugin manifests under `.claude-plugin/` and `.codex-plugin/` are optional metadata — the skills themselves are portable.

## Quick start

In a repo where you want to set up a BioSpec project:

```
> set up biospec in this repo
```

The `biospec-setup` skill scaffolds `biospec/{intents,datasets,analyses,registers}/`, copies the singleton overview templates, and offers to append a one-paragraph bootstrap snippet to your repo's `AGENTS.md` or `CLAUDE.md`. The snippet auto-loads the BioSpec invariant rules on every subsequent session.

From there:

| You say | Skill that runs |
|---|---|
| "fill the templates from this proposal" (and attach it) | `biospec-autofill` — cited extraction |
| "change the success criterion on intent-1 to p<0.01" | `biospec-edit` — propose-first |
| "review intent-1 — are the criteria specific enough?" | `biospec-review` — Critical mode |
| "what other clustering methods are worth considering?" | `biospec-review` — Exploratory mode |
| "validate the cross-references in biospec/" | `biospec-sync` mode=links |
| "regenerate the dependency diagram" | `biospec-sync` mode=diagram |

## What's in a BioSpec project

```
biospec/
├── project_overview.md          # Scope, scientific context, prior work
├── project_resources.md         # Compute, software, storage
├── intent_overview.md           # Index of research questions / aims
├── dataset_overview.md          # Index of data sources
├── analysis_overview.md         # Index of computational tasks
├── dependencies.md              # Mermaid graph of relationships
├── intents/
│   └── intent-{n}.md            # Per-intent: statement, mode, decision rule, hypotheses
├── datasets/
│   └── dataset-{n}.md           # Per-dataset: provenance, governance, modalities
├── analyses/
│   └── analysis-{n}.md          # Per-analysis: storyboarded flow, validation strategy
└── registers/
    └── decisions.md             # Append-only decisions log
```

Schema reference lives at `skills/biospec-templates/references/schema.md`.

## What the skills enforce

Every write-capable BioSpec skill applies the same rules:

- **No invention** — fields stay blank rather than be filled with guesses.
- **Propose-first writes** — every change is shown to you as a Before/After diff before it's applied.
- **Source citation** — autofill cites the source path and excerpt for each nontrivial fill.
- **Reference vs implementation** — methods and tools mentioned as background go into `Prior Work & Inspiration`, not into the analysis plan.
- **Scope lock** — when you name a cohort or component, the skill ignores unrelated parts of the project until you widen scope.
- **Template integrity** — headings, `<details>` blocks, and the repeated `### Step {s}` blocks in analyses are preserved exactly.

Each skill's own rules and Red Flags table are documented at the top of its `SKILL.md`. The full developer-facing guide lives in [AGENTS.md](AGENTS.md).

## Contributing

The approach for contributions is currently being decided. Please check back later for more details.

## License

AGPL-3.0. See [LICENSE](LICENSE).

## Acknowledgments

BioSpec was partly inspired by [GitHub's spec-kit](https://github.com/github/spec-kit). The skill structure follows the conventions of [obra/superpowers](https://github.com/obra/superpowers) and [mattpocock/skills](https://github.com/mattpocock/skills), and Anthropic's [Skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices).
