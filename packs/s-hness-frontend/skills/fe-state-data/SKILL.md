---
name: fe-state-data
description: Design frontend ownership and flow for local state, URL state, forms, server data, caching, synchronization, optimistic updates, and recovery. Do not define backend persistence or API contracts alone.
---

# Fe State Data

Inspect existing state tools, API contracts, navigation, offline expectations, concurrency, and cache behavior. Keep state as close as practical to its authoritative owner and avoid duplicating derived values.

Follow [state and data flow](../../references/state-data-flow.md).

## Output

Define state categories and owners, loading and refresh triggers, query keys or identity, freshness and invalidation, mutation lifecycle, optimistic behavior and rollback, cancellation, race and stale-response handling, URL/history behavior, persistence boundaries, and error recovery.

## Completion

The design is complete when every piece of state has one authoritative owner and transitions are deterministic across navigation, refresh, retries, concurrent actions, and server updates.
