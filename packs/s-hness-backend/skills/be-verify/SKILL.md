---
name: be-verify
description: Verify backend behavior across domain logic, APIs, persistence, integrations, security controls, and operational failure modes. Use backend-focused evidence; use web-verify for browser-to-service workflows.
---

# Be Verify

Map approved acceptance criteria and material risks to the lowest trustworthy test level. Apply the core verification gate before reporting success.

Always follow [backend verification profile](../../references/backend-verification-profile.md).

When source structure changed, also apply the [backend project structure gate](../../references/backend-project-structure.md).

## Evidence

Use the relevant combination of unit, contract, persistence integration, adapter integration, concurrency, migration, authorization, resilience, performance, service health, and structure-boundary checks. Confirm every new directory has a current responsibility and dependency direction. Record command or scenario, environment, fixture, result, and remaining risk.

## Completion

Assign `verified` only when required available checks pass. Return `failed` for required failures and `unverified` when required infrastructure or evidence is unavailable. A mock does not prove a live dependency or production recovery path.
