# Web Integration Contracts

Use this reference when frontend and backend responsibilities meet.

## Contract shape

For each operation define purpose, method or message type, route or topic, request, success response, error response, auth requirement, idempotency, cache behavior, and compatibility expectations.

Use stable product-level values. Do not leak database records, framework exceptions, transient SDK objects, internal stack traces, or secrets across the boundary.

## Identity and browser security

Make ownership explicit for login, logout, session renewal, authorization failure, CSRF defense, CORS, cookie attributes, redirect validation, and sensitive-data handling. Browser visibility is not authorization.

## Failure behavior

Separate validation, unauthenticated, forbidden, not found, conflict, rate-limited, dependency, and unexpected failures when users or clients need different recovery. Define timeout, cancellation, retry, duplicate submission, stale data, and partial success where applicable.

## Evolution

Prefer additive changes when old and new clients can overlap. For breaking changes, define migration order, compatibility window, telemetry, and retirement criteria. Verify contracts from both producer and consumer perspectives.
