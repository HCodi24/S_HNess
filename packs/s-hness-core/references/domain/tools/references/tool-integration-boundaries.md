# Tool Integration Boundaries

Wrap each external SDK, API, device, file format, operating-system service, process, or host application behind a capability-oriented adapter.

- Keep external object types and exceptions inside the adapter.
- Translate values and failures into stable internal contracts.
- Define acquisition, ownership, release, cleanup, and reconnect behavior.
- Record thread affinity, concurrency, timeout, cancellation, and retry constraints.
- Detect capabilities and versions instead of assuming them.
- Make permissions and credentials explicit without embedding secrets.
- Preserve idempotency or identify operations that cannot be retried safely.
- Provide test doubles for internal behavior and contract tests for adapters.
- List the application, license, hardware, account, network, or OS prerequisites for live tests.

A mocked pass proves the internal contract only. Report live integration as `unverified` when its prerequisites are absent.
