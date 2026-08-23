# Backend Project Structure Gate

Apply this gate whenever backend work creates, reorganizes, or materially extends source code.

## Decision order

1. Inspect and preserve a clear existing repository structure.
2. Follow the approved specification and conventions of the selected language or framework.
3. Use the responsibility map below only for a new project or when the current structure has a concrete ownership or dependency problem.
4. Create only directories required by the approved increment.

## Required structure output

Before implementation, provide:

- the relevant current tree;
- the proposed tree showing only retained, changed, and new areas;
- one responsibility statement for every proposed directory;
- allowed dependency direction between areas;
- locations for API entrypoints, application workflows, domain rules, persistence and external adapters, configuration, migrations, and tests; and
- explicit deviations from existing project conventions with reasons.

## Default responsibility map

Adapt names and depth to the ecosystem:

```text
<backend-root>/
├── src/
│   ├── entrypoints/       # HTTP, RPC, messaging, CLI, or scheduled triggers
│   ├── application/       # Use cases, orchestration, transactions, authorization flow
│   ├── domain/            # Stable business concepts and rules
│   ├── integrations/      # Persistence and external-service adapters
│   └── infrastructure/    # Runtime configuration, logging, hosting, framework setup
├── tests/
│   ├── unit/
│   ├── contract/
│   └── integration/
└── migrations/            # Only when persistence migrations exist
```

Small services may combine physical folders while keeping responsibilities clear. Do not create every example directory automatically.

## Dependency rules

- Entrypoints call application workflows; they do not own business rules.
- Application workflows depend on stable domain values and adapter interfaces.
- Domain code does not import transport, database, framework, or external SDK objects.
- Integrations translate external behavior into stable application/domain results.
- Infrastructure composes the runtime and must not become a catch-all for business behavior.
- Tests are organized by verification responsibility using ecosystem conventions; they need not mirror every source folder.

Avoid unbounded `common`, `shared`, `helpers`, `utils`, or `services` directories. If one is necessary, state its narrow responsibility and owner.

## Verification

Fail the structure gate when a new directory has no current responsibility, dependencies point against the declared direction without justification, domain behavior leaks into adapters or entrypoints, platform objects spread across layers, or product artifacts are placed in the harness.
