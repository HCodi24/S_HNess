---
name: s-spec
description: Convert an understood engineering request into an implementable specification with behavior, interfaces, constraints, failure handling, and testable acceptance criteria. Do not choose architecture or write code.
---

# S Spec

Define what the product or change must do before deciding how it will be implemented. Inspect the discovery brief, existing workspace, current behavior, repository instructions, and relevant domain rules before asking questions.

## Required context

- target users, desired outcome, goals, and non-goals;
- current workflow or system behavior;
- target workspace and existing interfaces when present;
- environment, integrations, data, permissions, and constraints; and
- explicit product decisions from discovery.

Ask only about unresolved product behavior that would materially change requirements, interfaces, risk, or acceptance. Do not resolve architecture, framework, storage, hosting, or implementation choices unless they are themselves user requirements.

## Output

Follow the [specification contract](../../references/specification-contract.md). Produce:

- purpose, scope, goals, and non-goals;
- actors and primary workflows;
- functional requirements and state transitions;
- inputs, outputs, interfaces, validation, and error behavior;
- data ownership, permissions, privacy, and consequential side effects;
- measurable quality, compatibility, and environment constraints;
- edge cases and recovery behavior;
- testable acceptance criteria mapped to requirements; and
- confirmed facts, assumptions, dependencies, and unresolved decisions.

Return the specification inline by default. Write a persistent specification only when requested, and only in the user-designated target workspace under the [artifact policy](../../references/artifact-policy.md).

## Completion

The specification is complete when domain design and planning can proceed without inventing product behavior, and every in-scope requirement has observable acceptance evidence. If a material decision remains, return `needs_input`; do not hide it as an assumption. Do not design architecture or implement code.
