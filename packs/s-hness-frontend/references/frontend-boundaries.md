# Frontend Boundaries

Keep application shell and routing, feature workflows, reusable UI primitives, state/data adapters, and platform integrations distinguishable. Shared code must have a current cross-feature responsibility, not merely anticipated reuse.

Feature code may compose primitives and data adapters. Generic primitives must not import product features. External framework, browser, native bridge, analytics, or storage details belong behind narrow boundaries when they would otherwise spread.

Follow the established framework and repository layout. Add layers only when they remove a concrete dependency or ownership problem.
