# Web Delivery Profile

Use this reference for environments, rollout, and recovery.

## Environments

Keep local, test, preview, staging, and production differences explicit. Configuration must be environment-owned, validated at startup, and free of committed secrets. A preview environment must not silently use production data or credentials.

## Delivery units

Identify immutable browser assets, server or edge runtimes, workers, migrations, and configuration separately. Record ordering constraints and the compatibility period between old and new units.

## Rollout

Define preflight, artifact identity, migration readiness, health criteria, smoke tests, observation window, staged exposure when supported, and a clear stop condition.

## Recovery

Rollback must account for code, configuration, schema, cache, queues, and external side effects. If a migration is not backward reversible, define forward recovery and data-restoration boundaries before rollout.

## Evidence

Capture artifact version, target environment, checks performed, relevant metrics or logs, final status, and cleanup. Never report deployment success from a build result alone.
