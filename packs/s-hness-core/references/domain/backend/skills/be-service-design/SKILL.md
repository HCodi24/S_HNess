---
name: be-service-design
description: Design backend project structure, application and service boundaries, workflows, dependencies, background work, and failure isolation. Use whenever backend source is created or reorganized; do not use for API syntax or schema details alone.
---

# Be Service Design

Design from the approved specification, current repository, domain ownership, data consistency, and operational constraints. Prefer the smallest number of deployable boundaries that satisfy independent ownership, scaling, security, and failure requirements.

Read [backend boundaries](../../references/backend-boundaries.md).

Always apply the [backend project structure gate](../../references/backend-project-structure.md) when work creates, reorganizes, or materially extends backend source.

## Output

Produce the current and proposed directory tree, responsibility of every proposed directory, allowed dependency direction, component responsibilities, synchronous and asynchronous workflows, transaction and idempotency boundaries, timeout and retry ownership, background jobs, external adapters, configuration, observability, and failure isolation.

## Completion

Service design is complete when each use case and directory has one clear responsibility, dependencies follow declared boundaries, no speculative or empty layer is proposed, and failures have bounded recovery. Do not implement code or deploy services.
