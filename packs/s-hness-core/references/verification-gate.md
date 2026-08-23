# Verification Gate

Apply this gate after any implementation and before reporting a successful result.

## Discover the test surface

Inspect repository instructions, package or project manifests, task runners, CI configuration, and existing test layout. Use established commands and conventions. Do not invent a new framework or install dependencies merely to satisfy the gate without user authorization.

## Mandatory sequence

1. Identify the acceptance criteria and changed behavior.
2. Run the narrowest existing tests or checks that exercise the change.
3. Add or update a meaningful regression test when behavior changed, no adequate test exists, and doing so is within the approved scope.
4. Run the broader relevant suite required by risk and the selected execution mode.
5. Inspect the final change and test output for accidental files, snapshots, generated artifacts, warnings, or skipped coverage.
6. Assign one final verification status:
   - `verified`: all required available checks passed;
   - `failed`: at least one required check failed; or
   - `unverified`: required checks could not run or do not exist.

## Mode coverage

- **Fast:** targeted regression checks are still mandatory; reduced assurance must be stated.
- **Standard:** targeted checks plus the relevant broader unit, contract, integration, build, lint, or type checks.
- **Hard:** full relevant suites and environment-dependent integration or acceptance checks when available.
- **Parallel:** checks for each independent branch plus integrated verification after convergence.

TDD controls whether a failing test is established before implementation. It never removes post-implementation verification.

## Result rule

Do not describe the outcome as successfully verified when status is `failed` or `unverified`. A failed required check blocks successful completion. An unavailable environment may permit a partial handoff only when the limitation, remaining risk, and exact unrun check are explicit.
