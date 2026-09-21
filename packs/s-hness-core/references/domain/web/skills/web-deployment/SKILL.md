---
name: web-deployment
description: Design or review deployment topology, environments, configuration, migrations, rollout, and recovery for a web system. Do not perform a live deployment unless the user explicitly authorizes it.
---

# Web Deployment

Inspect the current hosting model, CI/CD, domains, certificates, data stores, secret handling, and operational constraints. Prefer existing platform conventions unless they fail an approved requirement.

Read [web delivery profile](../../references/web-delivery-profile.md) before proposing production topology, rollout, or recovery.

## Output

Define:

- build and runtime units;
- environment and configuration boundaries;
- DNS, TLS, CDN, origin, service, worker, and data-store topology as applicable;
- migration ordering and backward-compatibility window;
- health checks, observability, capacity assumptions, and alerts;
- preview, staged rollout, rollback, and recovery procedures; and
- exact prerequisites and approvals for any live action.

## Safety

A deployment plan is not deployment authorization. Never expose secrets, mutate production, change DNS, run migrations, or publish artifacts without explicit approval immediately before the action.

## Completion

The deployment design is complete when rollout and rollback are executable, observable, and bounded, with unavailable infrastructure stated explicitly.
