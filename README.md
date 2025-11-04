# BioSpec
From ABACBS Abstract:

**BioSpec: Research project specifications to guide agent-assisted computational biology**

Large language model (LLM) coding agents can rapidly draft scripts for computational analyses. However, insufficient guidance, guardrails, or clarity in a user’s request can lead to over-engineered outputs, analytical drift, and incompatible code. Moreover, their lack of contextual memory poses limitations for multi-task research workflows. While agents can be prompted to create ad-hoc “project context” documents based on existing artefacts, these rarely provide a consistent, complete schema that captures a project’s description, intent, and constraints. Paradoxically, the very documentation needed to establish this context is often produced last, after code is written. 

To address this, we introduce BioSpec, a set of schemas and commands for iteratively specifying biomedical project context as a stable anchor for coding agents and humans during development. BioSpec formalises the components of a biomedical research project—its description, scientific intent, datasets, and resource constraints—as human- and agent-readable templates. It provides agent-agnostic commands to populate fields using user input, project notes, or pre-existing code. Additional commands are provided to validate completeness, flag ambiguities, and pose constructive questions that challenge design assumptions. The resulting context can be manually edited, version-controlled, and shared with other stakeholders, such as principal investigators and collaborators. 

We demonstrate an end-to-end use of BioSpec across a typical computational biology workflow and show how its outputs complement existing context management tools. By making project context explicit before code generation, BioSpec supports reproducible, project-grounded implementations. The toolkit will be released under an open-source licence.
