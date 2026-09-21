---
name: s-plan
description: Create and persist a decision-complete implementation plan in a topic-specific file in the current target workspace. Use for implementation-planning requests, explicit $s-plan invocations, and planning requests made after entering native /plan mode; do not implement the plan.
---

# S Plan

Plan work in the current user-designated target workspace. This skill is invoked as `$s-plan`; a domain may follow as prompt text, for example `$s-plan web`. The native `/plan` command enters Plan Mode but does not replace this skill; apply this workflow to the planning request made in that mode.

Before planning, use the [routing contract](../../references/routing-contract.md) and [domain capability registry](../../references/domain-capabilities.md) to infer the narrowest domain from the request. Resolve and read the selected internal capability `SKILL.md` files and their directly linked references. A domain argument narrows routing when supplied; the user does not need to name backend, frontend, web, or tools capabilities manually.

## Required context

- approved specification, acceptance criteria, and target workspace;
- required architecture or domain-design decisions;
- existing repository conventions and instructions;
- environment and integration constraints; and
- installed domain guidance relevant to the request.

Inspect discoverable facts before asking the user. Preserve existing architecture unless a concrete requirement justifies change.

Before writing the plan, apply the [user design gate](../../references/user-design-gate.md) and explicitly reconfirm with the user how the proposed code boundaries reflect their architecture direction. For work with a user-facing interaction, also reconfirm the problem-specific UI/UX direction and states that affect implementation; otherwise record why UI/UX is not applicable. A prior explicit answer may be cited and confirmed without repeating the same question verbatim. Do not complete or write the plan while either required decision is missing or contradicted; return `needs_input` or route missing architecture to the applicable domain-design skill.

If more than one material implementation path remains, present a concise comparison of the paths, trade-offs, and verification or recovery implications, then ask the user to select one or explicitly delegate the decision. Do not write a decision-complete plan with an unselected material alternative.

## Required artifact

Produce an explicitly phase-based plan. For every phase, state its outcome, scope and non-scope, dependencies, implementation boundary, affected components, side effects, verification, acceptance criteria, entry condition, exit condition, risks, approval/stopping gate, and review gate. Include interface or schema changes when applicable, state explicit assumptions, and trace the confirmed architecture and applicable UI/UX decisions into the affected phase and its verification.

Each phase must be independently understandable and executable as one focused increment. Do not collapse the whole request into one implementation phase when the approved specification identifies multiple deliverable behaviors or dependency boundaries. Preserve phase ordering; mark phases that may run in Parallel only when their ownership, state, migrations, generated outputs, and dependencies are disjoint. If the specification identifies a single atomic phase, preserve that rationale in the plan.

Include the comparison and selected or delegated outcome for each material alternative in the plan's assumptions or decision record. Map every specification phase to exactly one plan phase or explicitly document a justified merge.

For a new independent planning topic, create `<target-workspace>/plans/<topic-slug>.md` as described by [artifact policy](../../references/artifact-policy.md). Derive a concise, stable kebab-case slug from the requested topic and follow an existing project plan-naming convention when one is present. The planning request authorizes only the selected plan artifact; it does not authorize product-code changes or any external side effect.

Before writing, resolve the workspace and plan path to absolute paths and report them when ambiguity exists. If the user explicitly designates another target workspace, that workspace becomes current for this plan. Never redirect a plan into the harness, an installed plugin, or a plugin cache.

Treat a request as a continuation only when the user identifies an existing plan path or explicitly asks to revise or continue the plan established in the current conversation. Update that exact file and preserve unrelated content. Otherwise create a new topic-specific file; do not append to `plan.md` or another existing plan merely because it is present. If the proposed slug collides with an unrelated plan, choose a more specific slug and report the resolved path instead of overwriting.

After writing, read the selected file back and confirm its absolute path. If it cannot be written or verified, report the failure and do not claim planning completed. Return a concise summary inline; the selected topic-specific file is the canonical artifact for that plan.

## Completion

The plan is complete only when every specification requirement and acceptance criterion maps to an explicit phase and verification step, every phase has entry/exit and stopping criteria, no implementer decision remains unresolved, and the selected plan file has been written and read back successfully. Route missing product behavior or phase analysis to `s-spec` and missing architecture to the applicable domain-design skill. Do not edit product code.
