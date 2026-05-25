# BioSpec — agent guide

This repo is the source for the **BioSpec** agent-skills plugin. If you are an
agent working **inside this repo** (developing the plugin), the rules below
apply. If you are an agent working in a *user* repo that has BioSpec installed,
your touch-point is the `using-biospec` skill — read its `SKILL.md` instead.

## What BioSpec is

A small set of agent skills that help researchers in computational
biology / bioinformatics document their projects in structured form. The
skills operate on a per-project `biospec/` directory; the master templates
live under `skills/biospec-templates/assets/templates/`. The plugin works
in Claude Code, Codex, and any other agent host that reads `SKILL.md`.

## Layout of this repository

```
.claude-plugin/plugin.json          # Claude Code plugin manifest
.codex-plugin/plugin.json           # Codex plugin manifest
skills/
├── using-biospec/                  # Bootstrap — loaded via the AGENTS.md snippet
├── biospec-setup/                  # Scaffold biospec/ in a user repo
├── biospec-autofill/               # Populate from external sources (cited)
├── biospec-edit/                   # Apply user-dictated edits (propose-first)
├── biospec-review/                 # Discuss / critique (read-only)
├── biospec-sync/                   # Validate links, regenerate diagram
└── biospec-templates/              # Master templates + schema reference
validation/                         # Routing matrix + minimal scratch fixture
```

## Invariant rules carried into every skill

These are the rules every BioSpec verb-skill enforces. They are inherited from
the original `BioSpec.agent.md` and live now in `skills/using-biospec/SKILL.md`
plus each verb-skill's Iron Law and Red Flags table.

- **Truth & precedence** — user's current message > attachments > existing
  BioSpec docs > repo scan. Conflicts are flagged, never silently merged.
- **Scope lock** — when the user names a cohort / intent / dataset / analysis,
  ignore unrelated components until they widen scope.
- **Reference vs implementation** — tool/method mentions in source documents
  are background unless the project explicitly commits.
- **Template integrity** — preserve headings, `<details>` blocks, repeated
  `### Step {s}` headers, and `<!-- guidance -->` comments.
- **Propose-first writes** — every write-capable skill presents a diff and
  applies only on explicit user approval.
- **No invention** — leave fields blank rather than guess; cite source path
  and excerpt for nontrivial autofills.

## Developing this plugin

When working in this repo:

- Skill bodies are kept under their token budgets: `using-biospec` ≤ 200 words,
  index skills ≤ 200, verb skills ≤ 500. Use `references/` files for the
  spill (one level deep from `SKILL.md`).
- Descriptions are third person and start with "Use when…". Do not summarise
  workflow in the description — that pulls Claude away from the body.
- Every write-capable skill needs an Iron Law as its first line after the H1,
  and a Red Flags table that pre-empts the rationalisations agents reach for
  under pressure.
- Audit greps run cleanly:
  ```
  rg -nE 'manage_todo_list|vscode/(vscodeAPI|execute)|^agent: BioSpec' skills/
  rg -nE 'description:.*\b(I|my|you|your)\b' skills/
  rg -nE 'description:.*\b(First|Then|Next|Finally),' skills/
  rg -nE '\[not-started\]|\[in-progress\]|\[completed\]' skills/
  rg -nE '(^|[^./\w])project/' skills/
  ```
- Schema bumps require touching every template's `schema_version` and adding a
  "Changes since" entry to `skills/biospec-templates/references/schema.md`.
- Validation: walk `validation/routing-matrix.md` against both Claude Code and
  Codex before merging anything that touches descriptions or `references/`.

## Acknowledgments

The CLI portion of earlier BioSpec releases was adapted from GitHub's
[spec-kit](https://github.com/github/spec-kit). The current line is structured
after the skills conventions of
[obra/superpowers](https://github.com/obra/superpowers) and
[mattpocock/skills](https://github.com/mattpocock/skills), and follows
Anthropic's
[Skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices).
