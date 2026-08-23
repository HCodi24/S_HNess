---
name: tool-product-design
description: Design a software tool's product form, runtime boundaries, architecture, and project structure. Use for CLI, TUI, desktop, chat, plugin, add-in, automation, library, or service tools; do not use for ordinary domain-only feature design.
---

# Tool Product Design

Turn an approved specification into a stack-neutral tool architecture. Preserve the target repository's conventions unless the specification requires a justified change. Do not implement code.

## Workflow

1. Establish users, operating platforms, interaction mode, host lifecycle, integration points, offline needs, distribution constraints, and required side effects.
2. Read [tool form selection](../../references/tool-form-selection.md) when the tool form is undecided or multiple forms are plausible.
3. Select the tool form and separate host, application workflow, stable domain behavior, external integrations, and infrastructure concerns.
4. When creating, reorganizing, or materially extending source, read and apply the [tool project structure](../../references/tool-project-structure.md).
5. Define state and configuration ownership, dependency direction, platform boundaries, extension points, and implications for testing and packaging.

## Output

Provide the selected tool form and rationale, host/runtime model, component responsibilities, data and control flow, current and proposed project trees when applicable, directory responsibilities, dependency rules, state/configuration ownership, extension points, platform constraints, and unresolved decisions.

Do not propose empty speculative directories. A source-structure design is incomplete until every added or changed directory has a responsibility and dependency direction.
