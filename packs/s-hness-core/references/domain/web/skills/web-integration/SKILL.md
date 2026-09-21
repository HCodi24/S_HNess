---
name: web-integration
description: Define or review contracts that connect a web frontend to backend services, authentication, and asynchronous flows. Use for cross-boundary integration; do not use for internal UI or service implementation alone.
---

# Web Integration

Treat the integration boundary as a versioned product contract. Inspect existing API conventions, generated clients, auth flows, and error handling before proposing change.

Use `be-api-design` when backend contract ownership or service semantics need deeper design. Use `fe-state-data` when frontend caching, synchronization, or mutation behavior needs deeper design. Keep this skill responsible for the shared cross-boundary agreement.

## Contract requirements

- operation purpose, request and response shape, and compatibility policy;
- identity, authorization, cookies or tokens, CSRF and CORS behavior;
- validation ownership and normalized error semantics;
- pagination, filtering, sorting, idempotency, and concurrency where relevant;
- cache directives and invalidation signals;
- timeout, retry, cancellation, offline, and partial-failure behavior; and
- telemetry correlation without exposing secrets or sensitive data.

Follow [web integration contracts](../../references/web-integration-contracts.md).

## Output

Return the agreed contracts, sequence or data flow, ownership map, failure behavior, compatibility impact, and contract-test expectations. Mark unresolved product decisions instead of silently selecting behavior.

## Completion

Integration is defined when both sides can implement independently against the same observable contract.
