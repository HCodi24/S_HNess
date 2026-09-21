---
name: s-spec
description: Convert an understood engineering request into an implementable specification with behavior, interfaces, constraints, failure handling, and testable acceptance criteria. Do not choose architecture or write code.
---

# S Spec

Define what the product or change must do before deciding how it will be implemented. Inspect the discovery brief, existing workspace, current behavior, repository instructions, and relevant domain rules before asking questions.

First apply the [routing contract](../../references/routing-contract.md) and [domain capability registry](../../references/domain-capabilities.md). Infer the narrowest domain from the request, resolve the matching internal capability IDs, and read their internal `SKILL.md` files plus directly linked references before defining requirements. Keep routing separate from architecture selection and return `needs_input` when a required product decision is unresolved.

## Required context

- target users, desired outcome, goals, and non-goals;
- current workflow or system behavior;
- target workspace and existing interfaces when present;
- environment, integrations, data, permissions, and constraints; and
- explicit product decisions from discovery; and
- the user's recorded architecture direction or delegation and applicable UI/UX decisions from the [user design gate](../../references/user-design-gate.md).

Ask only about unresolved product behavior that would materially change requirements, interfaces, risk, or acceptance. Do not resolve architecture, framework, storage, hosting, or implementation choices unless they are themselves user requirements.

Carry the recorded architecture and UI/UX input forward as constraints, dependencies, or unresolved domain-design decisions without choosing the implementation. If discovery did not obtain the required direct input, return `needs_input` to `s-discover` instead of inventing it.

For material product-behavior, interface, compatibility, or quality decisions with multiple viable options, compare the options using relevant requirements and acceptance impact, then obtain the user's choice or explicit delegation. Do not hide an unresolved choice as an assumption; return `needs_input` when it would change the specification.

When the request contains multiple deliverable steps, analyze and partition it into explicit implementation phases before planning. Each phase must have a bounded outcome, in-scope and out-of-scope behavior, inputs and outputs, dependencies, side effects, acceptance criteria, verification evidence, and entry/exit conditions. Keep the analysis behavior- and risk-oriented; do not invent implementation architecture. If the work is genuinely atomic, state why a single phase is sufficient.


## Output

Follow the [specification contract](../../references/specification-contract.md). Produce:

- purpose, scope, goals, and non-goals;
- actors and primary workflows;
- functional requirements and state transitions;
- inputs, outputs, interfaces, validation, and error behavior;
- data ownership, permissions, privacy, and consequential side effects;
- measurable quality, compatibility, and environment constraints;
- user-facing experience requirements appropriate to the interface, or an explicit UI/UX not-applicable rationale;
- edge cases and recovery behavior;
- testable acceptance criteria mapped to requirements; and
- confirmed facts, assumptions, dependencies, and unresolved decisions.
- option comparisons and selected or delegated decisions for every material alternative that affects the specification.
- phase-by-phase analysis for every in-scope phase, including its behavior, dependencies, acceptance criteria, verification, and entry/exit conditions.

Return the specification inline by default. Write a persistent specification only when requested, and only in the user-designated target workspace under the [artifact policy](../../references/artifact-policy.md).

## Completion

The specification is complete when domain design and planning can proceed without inventing product behavior, every in-scope requirement has observable acceptance evidence, and each phase boundary is explicit enough for `s-plan` and `s-cook` to execute one phase at a time. If a material decision remains, return `needs_input`; do not hide it as an assumption. Do not design architecture or implement code.
