---
name: web-system-design
description: Design a full-stack web system across browser, server, data, and delivery boundaries. Use for end-to-end web architecture; do not activate for isolated frontend styling or backend-only service design.
---

# Web System Design

Design from the approved specification, user journey, data ownership, trust boundaries, operational constraints, and the existing repository. If product behavior or acceptance criteria remain unresolved, route them to `s-spec` before selecting architecture. Keep the result stack-neutral unless the project or approved specification selects technologies.

## Decisions

- browser, server, worker, storage, and external-service responsibilities;
- rendering and navigation model;
- request, event, and background-work data flow;
- authentication boundary and session ownership;
- caching, consistency, and invalidation responsibilities;
- failure isolation, observability, and scaling boundaries; and
- local, test, preview, and production topology.

Read [web system boundaries](../../references/web-system-boundaries.md) before choosing a new full-stack topology or rendering model.

## Output

Produce component responsibilities, dependency direction, data flows, interfaces, consequential decisions, risks, and verification implications. Preserve an existing architecture unless a concrete requirement justifies change.

## Completion

Design is complete when ownership and boundaries are explicit enough for `$s-plan web` to create implementation increments without inventing architecture. Do not implement code.
