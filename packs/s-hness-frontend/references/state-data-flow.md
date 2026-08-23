# State and Data Flow

Classify state as local interaction, form draft, URL/navigation, server-owned data, session/user preference, or derived state. Give each value one authoritative owner and derive duplicates when practical.

For server data define identity, fetch trigger, freshness, cache scope, invalidation, background refresh, mutation, optimistic update, rollback, timeout, cancellation, retry, stale-response rejection, and partial failure.

Do not persist sensitive or transient state without a requirement. Define behavior for refresh, back/forward navigation, multiple tabs, offline or reconnect only when relevant to the product.
