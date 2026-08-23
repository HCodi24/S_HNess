---
name: s-cook
description: Orchestrate an approved multi-phase engineering plan through execution, verification, review, and handoff gates. Use for end-to-end planned delivery; use s-run for one focused phase or change.
---

# S Cook

Run an approved plan from the user-designated target workspace. Do not create a missing plan, resolve product decisions, or reinterpret scope inside this skill; route those cases to `s-plan`.

## Required context

- approved plan or explicit plan path;
- target workspace and repository instructions;
- current changes, dependencies, test commands, and environment prerequisites; and
- relevant installed domain skills for each phase.

When no path is supplied, use `<target-workspace>/plan.md` only if the target workspace is already known.

## Execution selector

Before making any change, summarize risk and ask the user to select both an execution mode and TDD setting. Do not silently choose defaults.

1. **Standard** — execute, verify, and review each phase; stop at every phase boundary.
2. **Fast** — only for low-risk work; run targeted checks, omit a separate review pass, and continue unless the plan defines a gate.
3. **Hard** — require approval before and after every phase, full relevant verification, and a separate review pass.
4. **Parallel** — only when phases have independent dependencies and disjoint file ownership; integrate and verify before completion.

Ask whether TDD is `on` or `off`. If invocation text preselects a mode or TDD, show that selection and still request confirmation before editing.

## Pipeline

After confirmation, follow [cook pipeline](references/cook-pipeline.md). Apply `s-run` behavior to implementation, `s-verify` behavior to evidence, and `s-review` behavior when the selected mode requires review.

Every mode must pass the [verification gate](../../references/verification-gate.md) before a successful final result. Fast mode reduces breadth, not the requirement to test. TDD `off` changes test order, not whether post-implementation checks run.

Follow [execution policy](../../references/execution-policy.md) and [artifact policy](../../references/artifact-policy.md). A selected mode never authorizes installation, commit, push, publish, deployment, live-system changes, or destructive operations.

## Output

At every phase boundary report completed behavior, acceptance criteria covered, changed areas, verification and review evidence, unresolved risks, environment limitations, and the next gate.

## Completion

Finish successfully only when every in-scope phase has an explicit status and the final verification status is `verified`. Return a failed or unverified handoff instead of a success claim when required checks fail or cannot run. Stop immediately when scope is unresolved, a dependency is unavailable, verification fails materially, or a required approval is missing.
