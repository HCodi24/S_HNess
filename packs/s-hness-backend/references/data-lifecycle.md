# Data Lifecycle

Define one authoritative owner for each durable fact. Record identifiers, invariants, relationships, transaction boundaries, consistency, access patterns, indexes, retention, deletion, privacy, audit, backup, and restore requirements.

Migrations must state preflight, ordering, old/new code compatibility, locking or load impact, validation, observation, stop condition, and recovery. Use expandable/contractible changes when old and new application versions overlap. Never test destructive migrations against valuable production data.
