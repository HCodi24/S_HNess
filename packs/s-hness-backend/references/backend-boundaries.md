# Backend Boundaries

Keep transport adapters, application workflows, domain rules, external integrations, and infrastructure concerns distinguishable even when a small service combines them physically.

Application workflows coordinate use cases and transactions. Domain behavior must not depend on HTTP, queues, database records, or transient SDK objects. External calls belong behind adapters with normalized outcomes.

Split deployable services only for a demonstrated ownership, security, scaling, release, data, or failure-isolation need. Every boundary adds compatibility, observability, and operational cost.
