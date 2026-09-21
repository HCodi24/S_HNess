---
name: s-loop
description: Autonomously execute an approved phase-based plan through implementation, thorough testing, verification, and important progress logging. Use when the user wants the AI to carry a plan through its phases; stop on material failure, missing approval, or unresolved scope.
---

# S Loop

Run an approved, phase-based plan as a bounded execution loop. For each phase, implement the smallest complete increment, test it thoroughly, verify its acceptance criteria, record what happened, and continue only when the phase gate passes. This skill provides autonomous progression within approved boundaries; it does not turn an unresolved request into a plan or authorize external side effects.

## Boundaries and ownership

- Require an exact approved plan path and a resolved target workspace. Reject a monolithic or phase-incomplete plan and route it to `s-spec`/`s-plan`.
- Apply `s-run` for implementation, `s-test` for test execution and failure triage, `s-verify` for acceptance evidence, and `s-review` when the selected assurance mode requires a separate review.
- Obtain or confirm execution mode, TDD setting, mutation scope, and any required external approvals before starting. Once authorized, progress through eligible phases without asking the user to repeat routine confirmations.
- Apply the [state, test matrix, and repair contract](references/loop-state-and-repair.md) for checkpoints, resume, risk-based test depth, and bounded repair attempts.
- Use the same contract for run budgets, scope/diff guards, structured event logs, test artifacts, summaries, and locks.
- Do not silently install dependencies, modify live systems, commit, push, publish, deploy, weaken acceptance criteria, skip a failed phase, or invent architecture. Material choices with multiple viable options require a comparison and user selection or explicit delegation.
- Treat Parallel as an optimization only for phases with disjoint files, state, migrations, generated outputs, and dependencies. Track and gate each phase separately.

## Required context

Inspect before starting:

- the exact plan and its phase contracts;
- specification, acceptance criteria, architecture/domain decisions, and repository instructions;
- current changes, file ownership, dependencies, test commands, environment prerequisites, and recovery boundaries; and
- whether a persistent log/state artifact is authorized and where it belongs under the artifact policy;
- an existing loop state file when this is a resume; and
- baseline status/diff, run budget, lock ownership, and artifact destinations.

If the target, plan, phase boundary, acceptance criterion, environment, or required decision is unresolved, stop before mutation and return `needs_input` with the smallest missing question.

## Progress log

Report important progress in the conversation throughout the loop, not only at the end. Before and after each material mutation or long-running check, state the phase, purpose, affected paths, outcome, and next step. For moves or renames, state source and destination before acting.

Set the log and artifact destinations before the first mutation. When workspace-write is authorized and no paths are supplied, use `reports/<plan-slug>-loop-events.jsonl`, `reports/<plan-slug>-loop-artifacts/<phase-id>/`, and `reports/<plan-slug>-loop-summary.md` in the target workspace; if an artifact would conflict with scope or policy, ask for a path or permission before writing it. Always report the same events inline as well. Write one append-only structured event record when persistent logging is authorized and use the schema in [the loop contract](references/loop-state-and-repair.md).

- timestamp and phase ID/name;
- event: `started`, `decision`, `changed`, `test`, `completed`, `error`, `blocked`, or `recovered`;
- action and affected path(s), with source/destination for moves;
- result and acceptance criteria covered;
- command/scenario and test result when applicable;
- error classification, exact evidence, retry/recovery taken, and residual risk; and
- next step or stopping condition.

Never write secrets, tokens, or sensitive payloads to the log. If no persistent artifact is authorized, keep the same record inline and include it in the final handoff.

When persistent state is authorized, use `reports/<plan-slug>-loop-state.json` beside the event log and acquire `reports/<plan-slug>-loop.lock` before mutation. Update state at phase start, after material actions, after every test/repair attempt, and at handoff using atomic replacement where supported. Validate the plan hash and lock ownership before resuming; never silently resume a materially changed plan or run concurrently against the same state.

## Run controls and artifact outputs

Before mutation, resolve and record the global wall-clock, test-command, retry, and repair budgets from [the loop contract](references/loop-state-and-repair.md). Capture the baseline diff and allowed phase paths. After every implementation or repair batch, inspect the diff and stop on an unexpected path. Collect established test outputs under the phase artifact directory, redact sensitive data, and write the final summary report only after all phases and final integration checks have terminal statuses.

## Risk and repair controls

Assign each phase a low, medium, or high risk and apply the minimum test matrix from [the loop contract](references/loop-state-and-repair.md). If a required check is unavailable, keep the phase `unverified` instead of downgrading it. On a product or test failure, run the bounded repair loop from that reference: distinct hypothesis, authorized scope, targeted retest, then the complete phase matrix. Stop when the repair budget is exhausted or the proposed fix crosses architecture, schema, security, live-system, or scope boundaries.

## Bounded loop

1. **Preflight.** Resolve the plan, validate that every phase has scope, dependencies, entry/exit conditions, acceptance criteria, verification, and stopping gate; resolve budgets and artifact paths; acquire the run lock; and record the baseline/diff without altering unrelated work.
2. **Start phase.** Select the next incomplete phase whose dependencies and entry conditions pass. Log the phase start, scope, side effects, approval boundary, and expected evidence.
3. **Implement.** Apply `s-run` and relevant domain guidance to the current phase only. Keep the increment small enough that its behavior and file ownership remain inspectable, then run the scope/diff guard before testing.
4. **Test deeply.** Assign the phase risk and apply `s-test` using the required matrix: run the narrowest trustworthy checks first, then all broader unit/contract/integration/end-to-end or acceptance checks justified by risk and environment. Capture established outputs in the phase artifact directory. Add a meaningful regression test when behavior changed and the approved scope permits it.
5. **Verify and review.** Apply `s-verify` to map evidence to the current phase's acceptance criteria. Apply the selected review gate, inspect the diff and accidental files/artifacts/warnings/skips, and append all results to state, JSONL events, and inline progress.
6. **Close phase.** Mark only the current phase `passed`, `failed`, or `unverified`. Record completed behavior, changed areas, tests, evidence, unresolved risk, and the next phase. Continue automatically only when the phase is `passed` and its gate allows continuation.
7. **Handle failure.** Log the error immediately with classification (`product`, `test`, `environment`, `dependency`, `data`, or `transient`). Preserve diagnostics. For an in-scope, safe repair, apply the bounded repair loop: record a distinct hypothesis, change only allowed paths, run the targeted failing check, then the full phase matrix. Retry a transient command at most once; otherwise stop at the failed or unverified phase and describe recovery without discarding user work.
8. **Final integration.** After all phases pass, run integration-level checks justified by cross-phase risk, reconcile interfaces and generated outputs, run final verification/review, write the summary report, and release the run/phase locks safely.

## Required handoff

Return one final status: `verified`, `failed`, or `unverified`. Include:

- plan and target workspace;
- phase-by-phase status and the phase currently stopped, if any;
- completed behavior and affected paths;
- important decisions and user delegations;
- every test command/scenario, result, environment limitation, and remaining unverified behavior;
- errors, retries, recovery, residual risks, and stopping reason; and
- persistent state, JSONL event log, phase artifact root, summary report, lock status, or the inline progress log.

`verified` requires every phase and final integration check to pass. `failed` means a required phase/check failed. `unverified` means a required check or environment was unavailable. Never claim success for `failed` or `unverified`, and tell the user the safe next action.

## Completion

The loop is complete only when every phase has an explicit terminal status, all required testing and verification evidence is recorded, and the final status is `verified`, `failed`, or `unverified`. A loop run never authorizes commit, release, publication, deployment, or deletion of retained backups.
