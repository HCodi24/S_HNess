# Backend Verification Profile

- **Unit:** domain rules, validation, policy, state transitions, and normalized errors.
- **Contract:** API/message schemas, auth outcomes, compatibility, and adapter boundaries.
- **Integration:** real persistence, framework, identity, queues, caches, and external adapters in a declared environment.
- **System:** complete service workflows, concurrency, retries, cancellation, partial failure, and recovery.
- **Operational:** migration checks, startup configuration, health, metrics, logs, alerts, backup/restore, and performance boundaries.

Use deterministic fixtures and isolated data. Record exact commands, versions, environment, result, and cleanup. Passing fakes does not prove a real integration.
