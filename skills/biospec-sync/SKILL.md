---
name: biospec-sync
description: Use when the user asks to validate cross-references, fix broken links, find missing relationships between BioSpec components, or regenerate the dependency diagram. Modes — links (validate + propose new cross-references), diagram (rebuild the mermaid graph in dependencies.md). Scans biospec/, computes the desired derived state, proposes a diff, applies only on approval.
---

# biospec-sync

**NEVER APPLY DIFFS BEFORE PRESENTING THEM AND RECEIVING APPROVAL.**

## Mode selection

- **links** — *validate links*, *fix references*, *find missing connections*. Walks the link graph and proposes new cross-references one at a time.
- **diagram** — *regenerate diagram*, *update the dependency graph*. Rebuilds the mermaid graph in `biospec/dependencies.md`.

Ambiguous → ask. Do not silently pick.

## Core Pattern (both modes)

1. **Pre-flight.** Confirm `biospec/` exists with the singleton overviews. Missing → recommend `biospec-setup`.
2. **Scan.** Read every file in `biospec/intents/`, `biospec/datasets/`, `biospec/analyses/`, plus the overview files and `dependencies.md`. Extract per-component metadata (id, type, title, current cross-refs).
3. **Compute desired state** (per mode rules below).
4. **Diff** — current vs desired, as a dry-run.
5. **Apply on approval.** Update `last_updated` in every touched file.

## Mode: links

**Validation rules:**

- Every markdown link must resolve to an existing file.
- Relative paths only: from subtemplates `../datasets/dataset-1.md`; from overviews `intents/intent-1.md`.
- Links are bidirectional: if `intent-1.md` lists `dataset-1.md`, `dataset-1.md` must list `intent-1.md` back.
- Overview tables/lists must mention every component file that exists.

**Proposing new links:**

Identify candidates by terminology overlap, explicit mentions, and logical dependencies (data → analysis → intent). Present **one at a time**:

```
Proposed Link: <source> → <target>
Reason: <why>
Source context: <excerpt>
Target context: <excerpt>
Add this link? (yes/no)
```

Limit **5 suggestions per round**. *Why: stays inside the user's review window without forcing pagination.* On approval add to both source and target (bidirectional) and refresh overview tables.

## Mode: diagram

For `biospec/dependencies.md`:

- `graph LR` (left to right).
- Node prefixes: `D{n}` datasets, `A{n}` analyses, `I{n}` intents. Numbers match the component's `_id`.
- Node label: `D{n}["Dataset {n}:<br/>{Short Title}"]` — `<br/>` before the title.
- Edges by type: `D → A`, `A → I`, `A → A` (sequential), `D → I` (direct, rare).
- Dedup edges. Drop placeholder rows when no real file exists.

Refresh the **Links to Individual Components** list under the diagram. If many nodes are disconnected, append: "Some components appear disconnected. Run `biospec-sync` in `links` mode to find missing relationships."

## Common Mistakes

- Non-bidirectional links. If Intent → Dataset, add Dataset → Intent.
- Bundling many proposed links into one approval. One at a time. 5 max per round.
- Editing `dependencies.md` without a fresh scan first.
- Recreating placeholder rows (`Dataset {n}: {Name}`) when no actual file exists.

## Red Flags

| Excuse | Override |
|---|---|
| "I'll add all 12 link suggestions at once for speed." | One at a time. 5 max per round. **No exceptions.** |
| "I'll batch-update bidirectional pairs silently." | No. Each side is part of the same approval. |
| "The diagram is stale; let me regenerate without asking." | Propose the diff first. |
| "Status of the docs?" | Out of scope. The `status` workflow is dropped. |
