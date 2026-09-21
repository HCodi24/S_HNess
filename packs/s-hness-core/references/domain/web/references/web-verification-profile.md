# Web Verification Profile

Use this reference to select evidence for a full-stack web workflow.

## Test layers

- **Unit:** pure validation, transformations, policy, and state transitions.
- **Contract:** request, response, error, auth, compatibility, and generated-client boundaries.
- **Integration:** real framework, persistence, identity, cache, queue, and external adapters in a declared environment.
- **Browser workflow:** user journey across navigation, forms, network, server state, and recovery.
- **Deployment:** artifact startup, health, routing, TLS, configuration, migration, telemetry, and rollback behavior.

## Required risk checks

Select checks relevant to the feature: keyboard and assistive technology, responsive layout, supported browsers, authentication and authorization, CSRF/CORS/XSS-sensitive behavior, caching and stale data, concurrency and duplicate submission, loading and failure states, performance budgets, observability, and privacy.

## Workflow record

Record starting state, user action, expected visible result, expected server or data state, cleanup, environment, browser or viewport, and result. Keep fixtures deterministic and never run destructive tests against valuable production data.

Passing mocked or local tests does not establish production behavior. Mark unavailable infrastructure honestly.
