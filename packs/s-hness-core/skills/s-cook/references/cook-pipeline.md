# Cook Pipeline

Read this reference after the user confirms execution mode and TDD.

## Preflight

1. Resolve the exact target workspace and plan path.
2. Inspect repository instructions, existing changes, required domain guidance, test commands, and unavailable dependencies.
3. Map each phase to acceptance criteria, file ownership, verification, review, approval, and stopping condition.
4. Reject Parallel mode when phases share files, state, migrations, generated outputs, or ordered dependencies.
5. Record baseline status without altering unrelated user changes.

## Per-phase loop

1. Announce the phase boundary, scope, side effects, verification, and required approval.
2. When TDD is on, establish a meaningful failing test before implementation. Do not create tests that merely assert wording or implementation details.
3. Execute the smallest complete increment using `s-run` rules and relevant domain guidance.
4. Apply the shared verification gate: run targeted checks first, then broader checks justified by the selected mode and risk. Testing remains mandatory in Fast mode and when TDD is off.
5. Apply `s-review` as a distinct pass in Standard and Hard modes. In Fast mode, report that assurance is reduced. In Parallel mode, review integrated results after branches converge.
6. Update progress in the target workspace plan only when the user authorized plan-file updates.
7. Report the phase record and stop at the gate required by the selected mode or plan.

## Failure behavior

- Stop on a material test failure, scope conflict, unexpected architecture change, unavailable required environment, unsafe target, or missing approval.
- Do not weaken acceptance criteria or skip a required check to continue.
- Preserve useful diagnostics and describe recovery without discarding user work.
- Retry only when the failure is transient, the retry is safe, and the stopping count is explicit.

## Final integration

Run integration-level checks justified by cross-phase risk, reconcile interfaces and generated artifacts, review the combined change, and assign `verified`, `failed`, or `unverified`. Only `verified` permits a successful completion claim. Handoff readiness does not authorize commit, release, publish, or deploy.
