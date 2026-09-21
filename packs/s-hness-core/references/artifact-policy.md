# Artifact Policy

Harness source contains reusable instructions only.

Store all task-specific artifacts in the user-designated target workspace, including:

- topic-specific plan files and project documentation;
- product source and configuration;
- tests, fixtures, reports, and processed data;
- CAD models and generated media; and
- build, package, release, or verification outputs.

Never create task artifacts in this harness, an installed plugin directory, or a plugin cache. For a new independent `s-plan` topic, treat the current project workspace as the target by default and write `plans/<topic-slug>.md`. Create the `plans` directory together with the file when needed. If the current workspace cannot be resolved safely, stop before writing.

Update an existing plan only when the user identifies that plan or explicitly continues it from the current conversation. Preserve unrelated content. An existing root `plan.md` remains a valid explicit target but is never the automatic destination for a new topic.
