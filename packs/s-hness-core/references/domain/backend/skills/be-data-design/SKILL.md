---
name: be-data-design
description: Design backend data ownership, schemas, consistency, indexing, retention, and migration behavior. Use for persistence decisions; do not use for API shape or frontend state alone.
---

# Be Data Design

Inspect the current schema, access patterns, data volume, integrity rules, privacy constraints, and operational environment. Preserve the established data technology unless an approved requirement makes it unsuitable.

Follow [data lifecycle](../../references/data-lifecycle.md).

## Output

Define authoritative ownership, entities or records, identifiers, relationships, invariants, transaction boundaries, consistency, indexing, retention, audit needs, migration sequence, compatibility window, rollback or forward-recovery, and verification.

Separate domain concepts from storage-specific representations. Never assume a migration is reversible when it discards or transforms data.

## Completion

Data design is complete when reads, writes, invariants, migration safety, recovery, and test fixtures are explicit. Do not execute migrations.
