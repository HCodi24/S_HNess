---
name: web-verify
description: Verify a full-stack web workflow across browser, network, service, data, and deployment boundaries. Use for end-to-end web evidence; use narrower domain verification for frontend-only or backend-only work.
---

# Web Verify

Map acceptance criteria and material failure modes to the lowest trustworthy test level. Do not require every feature to run through every test type.

Always follow [web verification profile](../../references/web-verification-profile.md).

## Evidence

Cover the relevant combination of:

- contract tests for browser-service interfaces;
- integration tests for real framework, storage, identity, and external boundaries;
- browser workflow tests for primary success and recovery paths;
- accessibility, responsive, cross-browser, security, and performance checks; and
- deployment smoke tests, health checks, observability, and rollback evidence.

Report each check as `passed`, `failed`, `skipped`, or `unavailable`, with command or scenario, environment, fixture, and remaining risk.

## Completion

Verification is complete when every in-scope acceptance criterion has evidence or an explicit limitation. A mocked service does not prove production integration, and a local browser test does not prove deployment health.
