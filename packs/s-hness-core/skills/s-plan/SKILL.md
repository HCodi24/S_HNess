---
name: s-plan
description: Create and persist a decision-complete implementation plan as plan.md in the current target workspace. Use for implementation-planning requests, explicit $s-plan invocations, and planning requests made after entering native /plan mode; do not implement the plan.
---

# S Plan

Plan work in the current user-designated target workspace. This skill is invoked as `$s-plan`; a domain may follow as prompt text, for example `$s-plan web`. The native `/plan` command enters Plan Mode but does not replace this skill; apply this workflow to the planning request made in that mode.

## Required context

- approved specification, acceptance criteria, and target workspace;
- required architecture or domain-design decisions;
- existing repository conventions and instructions;
- environment and integration constraints; and
- installed domain guidance relevant to the request.

Inspect discoverable facts before asking the user. Preserve existing architecture unless a concrete requirement justifies change.

## Required artifact

Produce ordered increments with outcome, dependencies, implementation boundary, affected components, verification, acceptance criteria, risks, and review gates. Include interface or schema changes when applicable and state explicit assumptions.

Always write or update `plan.md` at the root of the current target workspace described by [artifact policy](../../references/artifact-policy.md). The planning request authorizes this file only; it does not authorize product-code changes or any external side effect.

Before writing, resolve the workspace to an absolute path and report it when ambiguity exists. If the user explicitly designates another target workspace, that workspace becomes current for this plan. Never redirect `plan.md` into the harness, an installed plugin, or a plugin cache.

When `plan.md` already exists, inspect it first, preserve unrelated content, and update only the requested scope. After writing, read the file back and confirm its absolute path. If the file cannot be written or verified, report the failure and do not claim planning completed.

Return a concise summary inline together with the saved path; the persistent `plan.md` is the canonical plan artifact.

## Completion

The plan is complete only when every specification requirement and acceptance criterion maps to an increment and verification step, no implementer decision remains unresolved, and `plan.md` has been written and read back successfully. Route missing product behavior to `s-spec` and missing architecture to the applicable domain-design skill. Do not edit product code.
