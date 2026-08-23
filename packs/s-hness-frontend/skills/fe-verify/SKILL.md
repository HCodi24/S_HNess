---
name: fe-verify
description: Verify frontend logic, component behavior, accessibility, responsive layouts, browser workflows, and performance. Use frontend-focused evidence; use web-verify for full browser-to-backend workflows.
---

# Fe Verify

Map approved acceptance criteria and material UX risks to the lowest trustworthy test level. Apply the core verification gate before reporting success.

Always follow [frontend verification profile](../../references/frontend-verification-profile.md).

When source structure changed, also apply the [frontend project structure gate](../../references/frontend-project-structure.md).

## Evidence

Use the relevant combination of state/logic tests, component interaction tests, contract mocks, browser workflows, keyboard and assistive-technology checks, responsive and visual inspection, supported-browser checks, measured performance, and structure-boundary checks. Confirm every new directory has a current responsibility and allowed import direction.

Record command or scenario, environment, browser or viewport, input method, fixture, result, and remaining risk.

## Completion

Assign `verified` only when required available checks pass. Return `failed` for required failures and `unverified` when required browsers, assistive technology, services, or evidence are unavailable. Snapshots alone do not prove usability or accessibility.
