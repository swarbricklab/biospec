# Minimal BioSpec fixture

A tiny, realistic BioSpec-shaped project used to exercise the verb skills
during validation. Treat this as **read-only test data** — the routing matrix
asks agents to *propose* edits and dry-run changes, never to apply them
in-place.

When walking the routing matrix:

1. `cp -r minimal-biospec /tmp/biospec-scratch && cd /tmp/biospec-scratch`
2. Run the prompts from `../prompts/`
3. Observe behaviour; restore from this directory between runs.

Behavioural assertions baked into this fixture:
- Storyboard repeated-header blocks in `analyses/analysis-1.md` (Step 1 / Step 2)
  must not be collapsed by `biospec-edit`.
- All cross-references resolve via relative paths from this directory.
- Schema version is `0.3.1` everywhere.
- A two-entry `registers/decisions.md` (DR1, DR2) exists for `biospec-review` to
  pick up via one-hop dependency read.
