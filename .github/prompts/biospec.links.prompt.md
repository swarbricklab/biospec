---
description: Validate and enhance cross-references between BioSpec documents
agent: BioSpec
---

# BioSpec Link Management

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty). The user may:
- Request specific links to be added between components
- Ask to validate/fix existing links
- Provide context about relationships between intents, datasets, and analyses

## Outline

Your task is to parse BioSpec documents, validate existing links, identify missing relationships, and propose new cross-references for user approval.

### 1. Discovery & Validation

**Parse the project structure:**
- Scan `project/` directory for all BioSpec documents
- Identify all intents in `project/intents/`
- Identify all datasets in `project/datasets/`
- Identify all analyses in `project/analyses/`
- Read overview files: `intent_overview.md`, `dataset_overview.md`, `analysis_overview.md`

**Extract component metadata:**
For each intent, dataset, and analysis file, extract:
- ID (from filename and frontmatter)
- Short name/identifier (from title)
- Type (for intents: question/aim/goal; for analyses: priority level)
- Existing cross-references in "Related Components" section

**Validate existing links:**
- Check that all markdown links point to valid files
- Verify links use correct relative paths (e.g., `../datasets/dataset-1.md` from intent files)
- Confirm bidirectional consistency (if Intent 1 links to Dataset 1, does Dataset 1 link back?)
- Report any broken or inconsistent links to the user

### 2. Relationship Analysis

**Identify potential missing links by analyzing:**

**Content-based connections:**
- Keywords and terminology overlap between documents
- Explicit mentions of component names in descriptions
- Stated objectives and how they align

**Logical dependencies:**
- Intents that mention specific data types → suggest linking to matching datasets
- Analyses that describe methods matching intent objectives → suggest connections
- Datasets with metadata matching analysis requirements → propose links

**Sequential dependencies:**
- Analyses with stated prerequisites → check if dependencies are linked
- Intents with milestones → verify supporting analyses are connected

### 3. User Approval Process

For each potential new link identified:

**Present ONE suggestion at a time** with context:
```
Proposed Link: {Source Component} → {Target Component}

Reason: [Explain why this connection makes sense based on content analysis]

Source context: [Relevant excerpt from source document]
Target context: [Relevant excerpt from target document]

Add this link? (yes/no)
```

**After user response:**
- If approved: Add the link to BOTH documents (ensure bidirectionality)
- If rejected: Note the decision and continue

**Limit to 5 suggestions** per interaction unless user requests more.

### 4. Link Implementation

When adding approved links:

**In subtemplate files (intents/, datasets/, analyses/):**
- Add to "Related Components" section
- Use proper markdown format: `[Component Type {n}: {Name}](../relative/path.md)`
- Maintain alphabetical or logical ordering
- Ensure bidirectional links (add link in both source and target)

**In overview files:**
- Update summary tables to reflect new relationships
- Add entries to lists of components

### 5. Report Summary

After processing all links, provide a concise summary response (do not generate a markdown file):

**Links Validated:**
- ✓ {n} existing links verified as correct
- ✗ {n} broken links fixed

**New Links Added:**
- {n} Intent ↔ Dataset connections
- {n} Intent ↔ Analysis connections  
- {n} Dataset ↔ Analysis connections
- {n} Analysis → Analysis dependencies

**Links Rejected:**
- {n} proposed links declined by user

**Next Steps:**
- Suggest running this command periodically as project evolves
- Remind user that manual link editing is always possible

## Important Guidelines

**DO:**
- Explain WHY each link makes sense (don't just suggest blind connections)
- Wait for explicit user approval before adding links
- Maintain bidirectional consistency
- Use templated link formats for consistency
- Update both individual files AND overview aggregators

**DON'T:**
- Add links without user approval
- Create links between unrelated components just because fields are empty
- Modify links the user explicitly rejected in this session
- Assume relationships without textual evidence

**REMEMBER:**
Your role is to help organize and clarify relationships that exist in the project specification, not to invent connections. Links should reflect genuine dependencies and relationships evident in the document content.

