---
name: s-run
description: Execute an approved engineering plan phase by phase with explicit side-effect boundaries, verification, and review gates. Use for planned delivery; do not use when scope or architecture is unresolved.
---

# S Run

Execute only inside the user-designated target workspace. Read the approved plan, repository instructions, current changes, and relevant domain guidance before editing.

## Workflow

1. Summarize the current phase, affected areas, expected side effects, verification, and stopping condition.
2. Obtain approval immediately before any consequential or previously unauthorized action.
3. Implement the smallest complete increment while preserving unrelated user changes.
4. Apply the [verification gate](../../references/verification-gate.md): run targeted tests, add a meaningful regression test when needed and in scope, then run broader checks justified by risk.
5. Report evidence and stop at each plan review gate.

Follow [execution policy](../../references/execution-policy.md) and [artifact policy](../../references/artifact-policy.md). Do not silently install dependencies, change architecture, weaken acceptance criteria, commit, push, publish, or deploy.

## Completion

Finish successfully only when every in-scope phase has a status and the final verification status is `verified`. If tests fail or required checks cannot run, return `failed` or `unverified` with the exact evidence instead of claiming success.
