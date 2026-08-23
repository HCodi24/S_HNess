# Specification Contract

Use this contract to describe required product behavior independently of implementation architecture.

## Required sections

1. **Purpose and scope:** target users, desired outcome, goals, non-goals, and product boundary.
2. **Current state:** existing behavior, workflow, interfaces, and relevant limitations.
3. **Actors and workflows:** who or what initiates each workflow, preconditions, normal flow, and observable outcome.
4. **Functional requirements:** uniquely identified behaviors using precise normative language.
5. **Interfaces and data:** inputs, outputs, validation, state ownership, persistence or retention expectations, and external contracts.
6. **Failure and recovery:** invalid input, authorization failure, conflicts, partial completion, cancellation, retry, timeout, unavailable dependency, and recovery where applicable.
7. **Quality constraints:** measurable security, privacy, performance, accessibility, reliability, compatibility, and operational requirements justified by the request.
8. **Acceptance criteria:** observable scenarios mapped to requirements and suitable for verification.
9. **Decisions and dependencies:** confirmed facts, explicit assumptions, external prerequisites, unresolved decisions, and out-of-scope work.

## Requirement quality

Each requirement must state an observable behavior or constraint and avoid prescribing implementation unless required by compatibility or user choice. Replace vague terms such as "fast", "secure", "easy", or "reliable" with measurable boundaries or mark them as unresolved.

Keep product validation separate from interface convenience validation. Identify the authoritative owner of permission, state, and side effects.

## Acceptance quality

Acceptance criteria must identify starting state, action or event, expected visible result, expected state or external effect, and relevant failure behavior. Include important negative paths at the same level of care as the happy path.

Do not use acceptance criteria that merely require a file, class, framework, or internal implementation detail to exist unless that artifact is itself the requested deliverable.

## Completion check

Confirm scope is bounded, interfaces and failures are explicit, constraints are measurable, every requirement maps to acceptance evidence, and no unresolved product decision is disguised as an assumption.
