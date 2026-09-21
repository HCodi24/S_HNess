# Loop State, Test Matrix, and Repair Contract

Read this reference when `$s-loop` creates, resumes, or repairs a plan run.

## Checkpoint state

When a persistent run is authorized, keep state beside the loop log at `reports/<plan-slug>-loop-state.json`. The state must include:

- `plan_path`, `plan_hash`, `target_workspace`, and baseline identifier;
- `started_at`, `updated_at`, selected execution mode, TDD setting, and repair budget;
- `current_phase` and an ordered `phases` array; and
- for each phase: ID/name, status (`pending`, `running`, `passed`, `failed`, or `unverified`), attempts, last event, test status, and evidence/log pointers.
- `run_id`, budget values, baseline paths, lock path, artifact root, event-log path, and summary path.

Write state before a phase starts, after every material action, after each test/repair attempt, and at terminal handoff. Use atomic replacement where the environment supports it. Do not mark a phase `passed` before its implementation, test, verification, and required review gates have evidence.

## Run budget and watchdog

Resolve these limits before mutation and record them in state: maximum wall-clock duration, maximum total repair attempts, maximum repairs per phase, maximum transient retries per command, and maximum duration for one test command. Use limits from the plan when present; otherwise ask the user to choose or explicitly delegate. There is no implicit unlimited mode. Announce a long-running check and stop with the appropriate incomplete status when a limit is reached.

## Resume rules

On resume, verify the plan path/hash, target workspace, repository instructions, and state schema. Resume only the recorded `running` phase or the next `pending` phase whose dependencies and entry conditions pass. Skip a `passed` phase only when its plan hash and recorded evidence still match the current run; never skip `failed` or `unverified` work silently. If the plan or workspace changed materially, stop with `needs_input` and preserve the old state.

## Baseline and scope guard

Capture the initial repository status, changed paths, relevant file hashes, and the current phase's allowed ownership before mutation. After each implementation or repair batch, inspect the diff and classify paths as pre-existing, in-scope, generated/test artifact, or unexpected. Stop before continuing when a new unexpected path or out-of-scope mutation appears. Never discard or reset unrelated changes automatically; preserve diagnostics and ask for recovery.

## Risk-based test matrix

Assign each phase a risk level in the plan or during preflight and record why:

| Risk | Minimum evidence |
| --- | --- |
| Low | targeted regression plus relevant static/unit check |
| Medium | targeted regression plus relevant unit/component/contract and build/lint/type checks; integration when a boundary changes |
| High | all applicable lower-level checks plus integration/end-to-end or acceptance checks; add security, performance, migration, accessibility, or recovery checks when the risk involves them |

If a required level cannot run, record the exact unavailable environment and return `unverified`; do not silently downgrade the matrix. Use established project commands and fixtures.

## Structured event log

Alongside human-facing progress, append one redacted JSON object per event to `reports/<plan-slug>-loop-events.jsonl`. Each event must contain `run_id`, timestamp, phase, event type, action, paths, result, acceptance/risk reference, command or scenario when safe, error classification/evidence when applicable, retry/repair data, and next step. Never include secrets, tokens, credentials, or raw sensitive payloads. Keep the JSONL append-only and link each event to its phase state/evidence.

## Artifacts and summary

Use `reports/<plan-slug>-loop-artifacts/<phase-id>/` for test outputs that already exist or are produced by established runners, such as logs, JUnit/coverage reports, screenshots, snapshots, traces, or build outputs. Do not invent a report format or copy secrets. At final integration, write `reports/<plan-slug>-loop-summary.md` with a phase/status table, budget usage, acceptance coverage, test artifact links, errors and recovery, remaining unverified behavior, and residual risks.

## Locking and parallel safety

Acquire `reports/<plan-slug>-loop.lock` for the run and record `run_id`, owner, start time, and target workspace. If a lock exists, inspect whether its owner is active; do not delete an active lock. Recover a stale lock only after an explicit safe stale determination and preserve the old state. For Parallel mode, acquire a separate lock per phase and require disjoint ownership, state, migrations, generated outputs, and dependencies. Shared state/log/summary writes must remain serialized.

## Bounded repair loop

- Default repair budget: at most two repair attempts per phase and one retry of the same transient command, unless the approved plan sets a smaller budget.
- Each repair attempt must record a distinct failure hypothesis, affected paths, authorized scope, expected test change, and outcome. Repeating the same failed hypothesis is a stop condition.
- An autonomous repair may change product code, tests, or fixtures only within the current phase's approved scope and only when it does not alter architecture, schemas/migrations, security boundaries, live data, or external systems.
- After a repair, run the targeted failing check first, then the full risk matrix for the phase. Do not declare success from a narrow retry alone.
- Architecture changes, schema/migration changes, destructive recovery, security-sensitive changes, or a repair outside scope require user approval; log the proposed options and trade-offs before stopping.
- Exhausted budget, repeated failure, contradictory evidence, or an unavailable required environment ends the loop with `failed` or `unverified`, preserving diagnostics.
