---
name: s-cook
description: Orchestrate an approved multi-phase engineering plan through execution, verification, review, and handoff gates. Use for end-to-end planned delivery; use s-run for one focused phase or change.
---

# S Cook

Run an approved plan from the user-designated target workspace. Do not create a missing plan, resolve product decisions, or reinterpret scope inside this skill; route those cases to `s-plan`.

Treat the plan as an ordered set of explicit phases, not as one undifferentiated implementation batch. Execute only the current phase, complete its verification and review gate, record its phase status, and then move to the next phase. In Parallel mode, independent phases may run concurrently only when the plan proves disjoint ownership and dependencies; each phase still receives its own evidence and status.

For every phase, resolve the narrowest domain and internal capability IDs from the [domain capability registry](../../references/domain-capabilities.md), then pass that guidance to the phase owner. The user invokes the core lifecycle skill; domain capabilities are loaded internally and are not required to remain public entries.

## Required context

- approved plan or explicit plan path;
- target workspace and repository instructions;
- current changes, dependencies, test commands, and environment prerequisites; and
- relevant internal domain capabilities for each phase.

Reject or route back to `s-plan` when the selected plan lacks explicit phase boundaries, phase-level acceptance/verification, entry/exit conditions, or stopping gates. Do not reinterpret a monolithic plan as phase work during cook.

When no path is supplied, use a plan only when its exact path was established unambiguously in the current conversation. If multiple topic plans or no selected plan can be identified, stop and ask for the plan path. Do not default to `<target-workspace>/plan.md`, select the newest file, or infer a plan from filename similarity.

## Execution selector

Before making any change, summarize risk and ask the user to select both an execution mode and TDD setting. Do not silently choose defaults.

1. **Standard** — execute, verify, and review each phase; stop at every phase boundary.
2. **Fast** — only for low-risk work; run targeted checks, omit a separate review pass, and continue unless the plan defines a gate.
3. **Hard** — require approval before and after every phase, full relevant verification, and a separate review pass.
4. **Parallel** — only when phases have independent dependencies and disjoint file ownership; integrate and verify before completion.

Ask whether TDD is `on` or `off`. If invocation text preselects a mode or TDD, show that selection and still request confirmation before editing.

## Pipeline

After confirmation, follow [cook pipeline](references/cook-pipeline.md). Apply `s-run` behavior to implementation, `s-verify` behavior to evidence, and `s-review` behavior when the selected mode requires review.

Every mode must run the [`s-test`](../s-test/SKILL.md) workflow for each phase and pass the [verification gate](../../references/verification-gate.md) before that phase is marked complete and before a successful final result. Fast mode reduces breadth, not the requirement to test. TDD `off` changes test order, not whether post-implementation checks run.

Follow [execution policy](../../references/execution-policy.md) and [artifact policy](../../references/artifact-policy.md). A selected mode never authorizes installation, commit, push, publish, deployment, live-system changes, or destructive operations.

## Progress updates

Apply the `s-run` progress-update rules throughout every phase. Do not wait for a phase boundary to tell the user what is happening: announce each material mutation or coherent batch with its purpose and affected paths, give source and destination for file moves or renames, then report the outcome and next step. Keep updates concise by grouping routine read-only checks and closely related edits.


## Output

At every phase boundary report completed behavior, acceptance criteria covered, changed areas, verification and review evidence, unresolved risks, environment limitations, the phase status, and the next phase/gate. Do not report the whole plan as complete while any phase is incomplete.

## Completion

Finish successfully only when every in-scope phase has an explicit status and the final verification status is `verified`. Return a failed or unverified handoff instead of a success claim when required checks fail or cannot run. Stop immediately when scope is unresolved, a dependency is unavailable, verification fails materially, or a required approval is missing.
