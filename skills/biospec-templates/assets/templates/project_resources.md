---
template_name: Project Resources
schema_version: 0.3.1
last_updated: YYYY-MM-DD
---

---
**Navigation**: [Project Overview](project_overview.md) | [Intent Overview](intent_overview.md) | [Dataset Overview](dataset_overview.md) | [Analysis Overview](analysis_overview.md) | [Dependencies](dependencies.md) | [Project Resources](project_resources.md)

---

# Project Resources
<!-- A record of the resources and workspace you and your team will primarily work within for the project -->

## Computational Resources

### Hardware Specifications
<!-- Provide details about the hardware this project will primarily utilise -->
- **CPU**: <!-- E.g., 8 cores; up to 64 cores -->
- **RAM**: <!-- E.g., 32GB; up to 512GB -->
- **GPU**: <!-- Available/Unavailable | Model: -->
- **Operating System**: <!-- E.g., Linux, Windows -->
- **Environment**: <!-- local | HPC | cloud | hybrid | local + HPC -->

<details>
<summary>HPC/Cloud Details (expand if using remote compute)</summary>

- **Infrastructure**:
- **Job submission method**:
- **Additional information**: <!-- For example, HPC Project Code -->

</details>

### Data Storage
<!-- Describe the data storage and backup approach for this project -->
- **Location**: <!-- local | network | cloud | hybrid -->
- **Storage Capacity**: <!-- gigabytes | terabytes -->
- **Backup Strategy**: <!-- E.g., DVC, cloud backups -->

## Version Control
### Code Management
<!--
Source of truth for the primary repository URL lives in
project_overview.md → Primary Repository. The fields below capture how the
team works with that repo and any secondary repos.
-->
- **Repository Type**: <!-- git | other -->
- **Repository Name**: 
- **Repository Location**: <!-- Should match project_overview.md → Primary Repository (do not redeclare a different URL) -->
- **Other Associated Repositories**: <!-- Any secondary repositories related to your project (e.g. data repo, fork, internal mirror) -->

### Environment Management
<!--
Project-wide defaults captured here. Per-analysis deviations (specific
lockfile path, alternate container, special compute profile) live in
analysis.md → Execution & Reproducibility — they override these defaults
for that analysis only.
-->
- **Container Preference**: <!-- Docker | Apptainer | Singularity | Conda | None -->
- **Package Installation**: 

### Software Stack
<!-- Describe the preferred languages or tools for your project if relevant -->
- **Core Languages**:
- **Preferred Tools/Packages/Frameworks**: 

## Links to Standard Operating Procedures (SOP) (if applicable) 
<!-- Relative path or URL to any in-house conventions for items like data management or code documentation. These may describe guardrails or best practices your organisation provides. Provide as a bullet point list of {header}:{link} pairs. -->
