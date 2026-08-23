---
name: s-verify
description: Verify an engineering outcome against its specification and acceptance criteria using risk-appropriate evidence. Use after implementation or for validation-only requests; do not substitute subjective review for testing.
---

# S Verify

Start from observable behavior, stable boundaries, and material failure modes. Use the cheapest test level that provides trustworthy evidence, then add environment-dependent checks only where integration risk requires them.

Always apply the [verification gate](../../references/verification-gate.md) before assigning a final result.

## Verification record

For every check report:

- acceptance criterion or risk covered;
- command, scenario, or inspection performed;
- environment and fixture when relevant;
- result: `passed`, `failed`, `skipped`, or `unavailable`; and
- remaining unverified behavior.

Do not claim a live platform, device, service, deployment, or licensed application works when that environment was unavailable. Keep generated evidence in the target workspace under the [artifact policy](../../references/artifact-policy.md).

## Completion

Verification is complete when every in-scope acceptance criterion has explicit evidence or an honest unavailable/skipped status with its reason. Assign `verified` only when all required available checks pass; otherwise assign `failed` or `unverified`.
