# Artifact Policy

Harness source contains reusable instructions only.

Store all task-specific artifacts in the user-designated target workspace, including:

- `plan.md` and project documentation;
- product source and configuration;
- tests, fixtures, reports, and processed data;
- CAD models and generated media; and
- build, package, release, or verification outputs.

Never create task artifacts in this harness, an installed plugin directory, or a plugin cache. For `s-plan`, treat the current project workspace as the target by default and place `plan.md` at its root. If the current workspace cannot be resolved safely, stop before writing.

When `plan.md` already exists, preserve unrelated content and update only the approved scope.
