---
name: s-route
description: Route an engineering request to the correct lifecycle phase and optional domain pack before planning or execution. Use when the right workflow is unclear; do not perform the routed work itself.
---

# S Route

Classify the request without changing the target workspace.

## Routing rules

1. Honor an explicitly invoked skill or domain unless it conflicts with the request.
2. Select one lifecycle phase: `discover`, `plan`, `run`, `debug`, `verify`, `review`, or `deliver`.
3. Select the narrowest applicable domain. Use `general` when no installed domain pack is required and `multi` only when responsibilities genuinely cross domains.
4. Recommend only installed skills. If a useful domain pack is unavailable, keep the core workflow and report the missing specialization.
5. Ask a question only when the unresolved choice would materially change scope, risk, or output.

Do not interpret routing as authorization to write files, call external systems, install software, publish, or deploy.

## Output

Return the routing contract defined in [routing contract](../../references/routing-contract.md), followed by one concise recommendation for the next prompt or skill invocation.

## Completion

Routing is complete when phase, domain, target workspace, side-effect class, approval need, and expected verification are explicit.
