---
name: s-discover
description: Clarify an early engineering idea into a bounded goal, audience, workflow, constraints, and observable success criteria. Use before specification when material product decisions remain unresolved.
---

# S Discover

Inspect the available workspace and supplied context before asking questions. Ask only about product intent or tradeoffs that cannot be discovered locally and would change the plan.

Apply the [user design gate](../../references/user-design-gate.md). Even when the workspace suggests an answer, obtain the user's direct input about code architecture and the UI/UX relevant to the actual interface. Keep these questions grounded in the observed repository and problem. This step captures preferences and constraints; do not select implementation architecture during discovery.

When discovery exposes multiple material ways to satisfy the goal, compare the relevant options and trade-offs and ask the user to choose or explicitly delegate the decision before closing discovery.

Before asking discovery questions, use the [routing contract](../../references/routing-contract.md) and [domain capability registry](../../references/domain-capabilities.md) to identify the narrowest candidate domain and read only the matching internal capability guidance. Use that guidance to frame domain-specific constraints; do not let it silently select architecture or replace the user design gate.

## Output

Produce a discovery brief containing:

- target user and desired outcome;
- current workflow or starting state;
- goals, non-goals, and boundaries;
- environment, integrations, data, permissions, and constraints;
- observable success criteria;
- the user's architecture direction or explicit delegation, plus applicable UI/UX decisions or a justified not-applicable finding;
- comparisons and user selections or explicit delegations for material decisions with multiple viable options;
- confirmed facts, assumptions, and unresolved decisions; and
- recommended domain and next lifecycle phase.

Do not select implementation architecture or create product artifacts unless the user asks to continue.

## Completion

Discovery is complete when `s-spec` can define precise behavior without inventing product intent and the user-design gate has been recorded. Route unclear domain ownership through [routing contract](../../references/routing-contract.md).
