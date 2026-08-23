# Web System Boundaries

Use this reference for full-stack topology and rendering decisions.

## Decision order

1. Preserve the repository's established stack and conventions when they satisfy the requirement.
2. Follow technologies selected by the approved specification.
3. For a new system, compare options against user experience, team capability, hosting, data, security, latency, cost, and operations.

Do not select a framework because it is popular or because an example uses it.

## Responsibility map

- **Browser:** interaction state, presentation, progressive enhancement, and client-side validation for usability.
- **Web server or edge:** request routing, rendering where selected, session enforcement, aggregation, and response policy.
- **Application services:** business use cases, authorization, transactions, and stable domain behavior.
- **Workers:** deferred, scheduled, or retryable processing outside request latency.
- **Data stores:** authoritative state, indexing, consistency, retention, and recovery.
- **External adapters:** third-party APIs, identity providers, payments, messaging, storage, or search.

Keep authoritative authorization and business validation on a trusted server boundary. Do not expose secrets or privileged credentials to browser code.

## Rendering

Choose static generation, server rendering, client rendering, streaming, or a hybrid per route and user need. Record SEO, personalization, freshness, cacheability, interaction, latency, and hosting consequences. Avoid applying one rendering mode globally without evidence.

## Completion check

Confirm state ownership, trust boundaries, dependency direction, rendering, caching, failure behavior, observability, and deployment units are explicit.
