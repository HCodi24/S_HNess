---
name: s-run
description: Execute an approved engineering plan phase by phase with explicit side-effect boundaries, verification, and review gates. Use for planned delivery; do not use when scope or architecture is unresolved.
---

# S Run

Execute only inside the user-designated target workspace. Read the approved plan, repository instructions, current changes, and relevant domain guidance before editing.

After reading the approved plan, use the [routing contract](../../references/routing-contract.md) and [domain capability registry](../../references/domain-capabilities.md) to select and read the internal capability guidance for the current phase. Keep the public lifecycle owner in `skills` and the selected domain guidance in `capabilities`; do not treat routing as authorization for additional side effects.

## Workflow

1. Summarize the current phase, affected areas, expected side effects, verification, and stopping condition.
2. Obtain approval immediately before any consequential or previously unauthorized action.
3. Implement the smallest complete increment while preserving unrelated user changes.
4. Run the [`s-test`](../s-test/SKILL.md) workflow: run targeted tests, add a meaningful regression test when needed and in scope, then run broader checks justified by risk.
5. Apply the [verification gate](../../references/verification-gate.md), report evidence, and stop at each plan review gate.

Follow [execution policy](../../references/execution-policy.md) and [artifact policy](../../references/artifact-policy.md). Do not silently install dependencies, change architecture, weaken acceptance criteria, commit, push, publish, or deploy.

## Source structure gate

Before creating, moving, or materially reorganizing source code, inspect the current project tree and apply the relevant internal architecture or project-structure capability guidance for the domain. Preserve coherent language, framework, and repository conventions. Place every new file in a directory with a clear responsibility, keep dependency direction consistent, and keep entry points, domain behavior, external adapters, configuration, generated output, and tests in their owned boundaries.

Prefer the smallest maintainable structure for the actual project. Do not create speculative or empty layers, place source opportunistically at the repository root, or turn generic `utils`, `helpers`, or `shared` directories into catchalls. Split files and directories when responsibilities or dependency boundaries differ, not merely to satisfy a fixed template.

For software tools, apply `tool-product-design` and its project-structure guidance whenever source is created, reorganized, or materially extended. Apply the corresponding frontend or backend architecture guidance for those domains. If the approved plan does not resolve a structural decision required for implementation, stop and return to design or planning instead of inventing architecture during execution.

## Progress updates

Keep the user informed throughout implementation, not only at phase boundaries. Before each material workspace mutation or coherent batch, state what is being changed and why, name the affected paths, and identify the next observable step. For file moves or renames, state both the source and destination before acting. After the action, report its outcome and any change to the next step.

Also announce long-running verification or other work that may leave the user waiting. Group routine read-only inspection and closely related edits into concise updates instead of narrating every command. Never expose secrets or sensitive file contents in progress messages.

## Completion

Finish successfully only when every in-scope phase has a status and the final verification status is `verified`. If tests fail or required checks cannot run, return `failed` or `unverified` with the exact evidence instead of claiming success.
