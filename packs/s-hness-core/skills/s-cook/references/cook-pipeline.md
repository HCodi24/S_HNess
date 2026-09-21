# Cook Pipeline

Read this reference after the user confirms execution mode and TDD.

## Preflight

1. Resolve the exact target workspace and plan path.
2. Inspect repository instructions, existing changes, required domain guidance, test commands, and unavailable dependencies.
3. Validate that the plan contains explicit ordered phases. Map each phase to its outcome, scope, dependencies, acceptance criteria, file ownership, verification, review, approval, entry/exit, and stopping condition.
4. Reject Parallel mode when phases share files, state, migrations, generated outputs, or ordered dependencies.
5. Record baseline status without altering unrelated user changes.

## Per-phase loop

1. Announce the phase boundary, scope, side effects, verification, and required approval.
2. When TDD is on, establish a meaningful failing test before implementation. Do not create tests that merely assert wording or implementation details.
3. Execute the smallest complete increment using `s-run` rules and relevant domain guidance.
4. Run the `s-test` workflow for the current phase: execute targeted checks first, then broader checks justified by the selected mode and risk; classify failures and retain exact evidence. Testing remains mandatory in Fast mode and when TDD is off.
5. Apply the shared verification gate and use `s-verify` to map the current phase's test evidence to its acceptance criteria. Testing remains mandatory even when a separate review pass is omitted.
6. Apply `s-review` as a distinct pass in Standard and Hard modes. In Fast mode, report that assurance is reduced. In Parallel mode, review each branch and then the integrated results after branches converge.
7. Update progress in the target workspace plan only when the user authorized plan-file updates.
8. Report the phase record, mark only the current phase status, and stop at the gate required by the selected mode or plan before starting the next phase.

## Failure behavior

- Stop on a material test failure, scope conflict, unexpected architecture change, unavailable required environment, unsafe target, or missing approval.
- Do not weaken acceptance criteria or skip a required check to continue.
- Preserve useful diagnostics and describe recovery without discarding user work.
- Retry only when the failure is transient, the retry is safe, and the stopping count is explicit.

## Final integration

Run integration-level checks justified by cross-phase risk, reconcile interfaces and generated artifacts, review the combined change, and assign `verified`, `failed`, or `unverified`. Only `verified` permits a successful completion claim. Handoff readiness does not authorize commit, release, publish, or deploy.
