---
name: s-test
description: Run a risk-based test workflow for a change or system behavior, from test scope through execution, failure triage, and evidence. Use when testing, regression testing, or validating behavior; do not use for implementation or subjective code review.
---

# S Test

Run a focused, reproducible testing workflow for an implemented change or an existing system behavior. Test execution and failure analysis belong here; acceptance-evidence synthesis belongs to `s-verify`, and subjective correctness or maintainability review belongs to `s-review`.

Before defining the test oracle, use the [routing contract](../../references/routing-contract.md) and [domain capability registry](../../references/domain-capabilities.md) to identify the narrowest domain and read its internal verification guidance. Preserve the core test gate and add domain checks only when the selected capability owns that risk.

## Boundaries

- Test only inside the user-designated target workspace and the explicitly authorized environment.
- Do not silently install dependencies, change product code, weaken acceptance criteria, mutate live systems, or repair a failure while claiming to test. Updating tests or fixtures is allowed only when that change is in scope and authorized.
- Use existing project commands, fixtures, runners, and conventions. Do not invent a framework merely to satisfy this skill.
- Keep test data isolated, avoid secrets, and clean up temporary artifacts without deleting unrelated user work.


## Required context

Inspect before asking questions:

- target workspace and repository instructions;
- the specification, plan, acceptance criteria, or explicit behavior under test;
- current changes, interfaces, manifests, task runners, CI configuration, and existing test layout;
- required dependencies, credentials, services, devices, fixtures, permissions, and environment limitations; and
- the authorized mutation and recovery boundary.

If the behavior or acceptance criteria are unresolved, route to `s-spec`. If the test target or workspace is ambiguous, stop and ask for it rather than selecting a target from filename similarity.

## Choose the test strategy

After inspection, identify material test-strategy choices. If multiple viable choices remain, show a concise comparison using criteria relevant to the risk (coverage, fidelity, speed, determinism, cost, accessibility, compatibility, data safety, and recovery), then ask the user to select one or explicitly delegate the decision. Do not silently turn a recommendation into a decision.

Typical levels are:

- focused regression: the smallest checks that exercise changed behavior;
- standard: focused checks plus relevant unit, component, contract, build, lint, or type checks;
- integration or end-to-end: cross-boundary checks when interface or environment risk requires them; and
- acceptance or live-environment checks: only with an available, authorized, safe environment.

When constraints leave only one viable level, record the constraint and why. For a user-facing interface, include relevant workflow, state, accessibility, responsive, and error-feedback checks; for backend-only, data-only, infrastructure, or internal-library work, record that UI/UX testing is not applicable and why.


## Workflow

1. **Define the oracle.** Map each acceptance criterion or stated behavior to observable outputs, invariants, failure conditions, and the risk it covers. Identify what is intentionally out of scope.
2. **Plan the checks.** Select the cheapest trustworthy level first, then broader checks justified by risk. Record commands or scenarios, fixtures, data isolation, prerequisites, expected results, timeout limits, cleanup, and stopping conditions.
3. **Establish a baseline.** Run or inspect the relevant baseline when it is safe and available. Distinguish a pre-existing failure from a regression; preserve its exact evidence.
4. **Honor TDD when selected.** If the approved plan or user selected TDD `on` and implementation has not started, establish a meaningful failing test before implementation. Do not create tests that only assert wording, file layout, or private implementation details.
5. **Execute in order.** Announce each material or long-running check, run targeted checks first, then broader and environment-dependent checks. Record the exact command or scenario, environment, fixture, duration when useful, and result.
6. **Triage failures.** Classify each failure as product behavior, test/fixture defect, environment/dependency, data contamination, or flaky/transient. Preserve the first failure. Retry at most once only when the failure is plausibly transient, the retry is safe, and the retry rule is stated. Do not hide a required failure behind a retry.
7. **Inspect and clean up.** Check logs, snapshots, generated output, warnings, skipped tests, accidental files, and coverage gaps. Remove only temporary artifacts created by this run and retain useful diagnostics in the target workspace under the artifact policy.
8. **Handoff evidence.** Map results back to acceptance criteria and state remaining untested behavior, unavailable environments, residual risk, and the next safe action. Use `s-verify` for the final acceptance-evidence record when this skill is invoked inside a larger lifecycle.

## Required output

Report:

- target, scope, selected or delegated test strategy, and UI/UX applicability;
- acceptance criteria or risks covered by each check;
- command/scenario, environment and fixture, and result for every check (`passed`, `failed`, `skipped`, or `unavailable`);
- failure classification, reproduction evidence, retries, and recovery or blocking decision;
- cleanup and artifact paths; and
- one final status: `verified`, `failed`, or `unverified`.

## Completion

- `verified` means every required available check passed and each in-scope criterion has explicit evidence.
- `failed` means at least one required check failed or a confirmed product defect remains.
- `unverified` means a required check could not run, the environment was unavailable, or a required test does not exist and cannot be added within scope.

Never claim successful verification for `failed` or `unverified`. Apply the [verification gate](../../references/verification-gate.md) before assigning the final status. In `s-cook`, run this workflow per phase before the `s-verify` evidence and selected review gate; in `s-run`, use it for the targeted and broader checks required by the approved plan.
