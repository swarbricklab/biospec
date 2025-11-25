Prompt instructions file:
-

## User Input

```text
$ARGUMENTS
```

## Outline

Your task is to filter research documentation (manuscripts, papers, publications) to retain ONLY the information relevant to a specific project, dataset or cohort defined by the user.

Research manuscripts often contain extensive background, results, and discussion sections with details relating to other projects that could introduce confusion. The goal is to produce cleaned project documents that can be used as high-quality input for the BioSpec autofill process.

## Guiding Principles

- **Verbatim Retention**: Do NOT summarize, rewrite, or paraphrase content. Retain relevant sections exactly as they appear in the source.
- **Deletion Only**: Your only operation is to remove paragraphs or sections. Do not add new text.
- **Conservative Filtering**: If a section is ambiguous, retain it. It is better to have slightly more context than to lose critical project details.
- **Structure Preservation**: Maintain the original markdown structure (headers, lists) where possible. If a section becomes empty after filtering, remove the header.

## Procedure

1. **Parse User Directive**:
   - Read the user's input to understand the specific **Target Project** scope.
   - Note any specific inclusions (e.g., "keep dataset descriptions") or exclusions (e.g., "remove background history").

2. **Process Input Files**:
   - For each markdown file provided by the user:
     - Scan the content section by section. Look at keywords, section headers, and content.
     - **Identify Relevant Project Content**:
       - Any mention of the Target Project, dataset or cohort, by name or identifier.
       - Specific Aims / Research Questions
       - Experimental Design / Methods
       - Dataset / Cohort Descriptions
       - Analysis Plans / Computational Workflows
       - Specific Results that drive the current project's immediate next steps.
     - **Identify Irrelevant Content**:
       - Broad background information not specific to the target project.
       - Results or methods from clearly different projects or experiments not part of this scope.
       - Reference sections in publications that do not pertain to the target project.
     - **Filter**: Remove irrelevant paragraphs if they do not meet the relevance criteria.

3. **Save Output**:
   - Construct the new filename by appending `_filtered` to the original name (e.g., `manuscript.md` becomes `manuscript_filtered.md`).
   - Use the `create_file` tool (or equivalent) to save the filtered content to the new filename in the same directory as the original.
   - If you cannot save the file, output the full markdown content in a code block with the filename clearly indicated.
