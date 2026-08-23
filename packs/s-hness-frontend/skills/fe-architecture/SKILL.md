---
name: fe-architecture
description: Design frontend project structure, navigation, feature and component boundaries, dependency direction, and rendering responsibilities. Use whenever frontend source is created or reorganized; do not use for backend or full-stack topology.
---

# Fe Architecture

Design from the approved specification, existing repository, supported platforms, rendering environment, design system, and team conventions. Preserve the current framework and structure unless a concrete requirement justifies change.

Read [frontend boundaries](../../references/frontend-boundaries.md).

Always apply the [frontend project structure gate](../../references/frontend-project-structure.md) when work creates, reorganizes, or materially extends frontend source.

## Output

Define the current and proposed directory tree, responsibility of every proposed directory, allowed imports and dependency direction, application shell, routes and navigation, feature boundaries, component layers, shared primitives, rendering and hydration responsibilities, error boundaries, configuration, code-splitting boundaries, and test locations.

## Completion

Architecture is complete when each UI workflow and directory has a clear owner, shared code has a justified responsibility, dependency direction is explicit, no speculative or empty layer is proposed, and implementation can be planned without inventing frontend structure. Do not implement code.
