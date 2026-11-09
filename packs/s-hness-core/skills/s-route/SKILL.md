---
name: s-route
description: Route an engineering request to the correct lifecycle phase and internal domain capabilities before planning or execution. Use when the right workflow is unclear; do not perform the routed work itself.
---

# S Route

Classify the request without changing the target workspace.

## Routing rules

1. Honor an explicitly invoked skill or domain unless it conflicts with the request.
2. Select one lifecycle or control phase: `discover`, `spec`, `plan`, `cook`, `loop`, `run`, `control`, `test`, `debug`, `verify`, `review`, or `deliver`.
3. Select the narrowest applicable domain. Use `general` when no internal domain capability is required and `multi` only when responsibilities genuinely cross domains.
4. Recommend only public core skills in `skills` and registered internal capability IDs in `capabilities`. If no registered capability owns the work, keep the core workflow and report the missing specialization.
5. Ask a question only when the unresolved choice would materially change scope, risk, or output.

Do not interpret routing as authorization to write files, call external systems, install software, publish, or deploy.

Before returning the contract, read the [routing contract](../../references/routing-contract.md) and [domain capability registry](../../references/domain-capabilities.md). For a backend, frontend, web, or tools request, return the narrowest matching internal capability IDs in `capabilities`; resolve each ID to its internal `SKILL.md` path using the registry. An explicitly invoked core lifecycle skill remains the public owner, while an explicitly named domain skill is treated as a routing signal rather than a separate public entry.

For a request to authorize or operate a named app or website, use `phase: control`, `skills: [s-control]`, and include `tools/ai-control-runtime` in `capabilities`. Keep live authorization and interaction approval explicit.

## Output

Return the routing contract defined in [routing contract](../../references/routing-contract.md), followed by one concise recommendation for the next prompt or skill invocation.

## Completion

Routing is complete when phase, domain, target workspace, side-effect class, approval need, and expected verification are explicit.
