---
name: be-api-design
description: Design or evolve a stable backend API contract, including operations, schemas, errors, authorization, compatibility, and client-facing behavior. Do not use for internal service architecture or database design alone.
---

# Be Api Design

Start from the approved specification and existing API conventions. Keep transport choices, naming, and versioning consistent with the repository unless a requirement justifies change.

Read [API contracts](../../references/api-contracts.md) before defining a new public operation or breaking change.

## Output

Define operation purpose, request and response schemas, validation ownership, authentication and authorization, errors, idempotency, pagination or streaming, concurrency, cache behavior, compatibility, and contract-test expectations.

Do not leak persistence records, internal exceptions, SDK objects, secrets, or implementation details across the API boundary.

## Completion

The API design is complete when producers and consumers can implement independently against one observable contract and every failure path has defined behavior. Do not implement code.
