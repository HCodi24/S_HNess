# API Contracts

For every operation define purpose, transport, address, input, success output, error output, identity, authorization, idempotency, concurrency, cache behavior, and compatibility.

Use stable product-level schemas. Distinguish invalid, unauthenticated, forbidden, missing, conflicting, rate-limited, dependency, and unexpected failures when clients need different recovery.

Prefer additive evolution during client overlap. A breaking change requires migration order, compatibility window, telemetry, and retirement criteria. Verify producer and consumer expectations with contract tests.
