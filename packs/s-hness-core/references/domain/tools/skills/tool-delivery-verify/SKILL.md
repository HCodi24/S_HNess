---
name: tool-delivery-verify
description: Verify a software tool's structure, build, behavior, integrations, package, installation, update, rollback, and uninstall evidence. Use before delivery or to assess readiness; do not treat mocks as proof of live platform integration.
---

# Tool Delivery Verify

Verify the tool against its specification and delivery design using observable evidence. Read the [tool project structure](../../references/tool-project-structure.md) when source structure is in scope and the [tool verification profile](../../references/tool-verification-profile.md) for evidence levels.

## Verification

1. Map acceptance criteria to focused checks.
2. Inspect project boundaries and dependency direction.
3. Run the narrowest relevant tests, then broader build and regression checks proportional to risk.
4. Verify interface behavior, integrations, packaging, installation, update, rollback, and uninstall only where they are in scope and the environment supports them.
5. Record the command or procedure, environment, result, and residual risk for every claim.

Return exactly one overall status:

- `verified`: all required evidence passed;
- `failed`: required evidence ran and failed; or
- `unverified`: required evidence could not run or is missing.

Mocks and adapters can verify internal contracts but cannot prove a live OS, device, SDK, host application, or external service path. Never convert unavailable evidence into success.
