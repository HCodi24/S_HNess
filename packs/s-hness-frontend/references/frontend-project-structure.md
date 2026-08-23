# Frontend Project Structure Gate

Apply this gate whenever frontend work creates, reorganizes, or materially extends source code.

## Decision order

1. Inspect and preserve a clear existing repository structure.
2. Follow the approved specification, design system, and conventions of the selected frontend framework.
3. Use the responsibility map below only for a new project or a demonstrated ownership/dependency problem.
4. Create only directories required by current features.

## Required structure output

Before implementation, provide:

- the relevant current tree;
- the proposed tree showing retained, changed, and new areas;
- one responsibility statement for every proposed directory;
- allowed imports and dependency direction;
- locations for application setup, routes, feature workflows, reusable UI, state/data adapters, platform integrations, styles/assets, and tests; and
- explicit deviations from repository conventions with reasons.

## Default responsibility map

Adapt names and depth to the ecosystem:

```text
<frontend-root>/
├── src/
│   ├── app/               # Bootstrap, providers, global routing, configuration
│   ├── routes/            # Route composition and page-level loading boundaries
│   ├── features/          # User workflows and feature-owned UI/state
│   ├── ui/                # Reusable design-system primitives and composition
│   ├── data/              # API clients, query/mutation adapters, schema mapping
│   ├── platform/          # Browser/native bridges, storage, analytics adapters
│   └── styles/            # Shared tokens and global styles when required
├── tests/                 # Cross-feature and browser-level tests when needed
└── public/                # Static public assets only when the framework uses it
```

Small frontends may combine folders. Do not create empty `routes`, `data`, `platform`, `styles`, `tests`, or `public` areas without current responsibilities.

## Dependency rules

- App setup composes features and adapters; it does not own feature behavior.
- Routes compose feature entrypoints and route-level loading/error behavior.
- Features may use UI primitives and data/platform adapters; features should not reach into another feature's internals.
- Reusable UI primitives do not import product features or server-data workflows.
- Data adapters normalize external contracts and do not own presentation state.
- Platform-specific APIs remain behind narrow adapters when direct use would spread.

Avoid unbounded `components`, `common`, `shared`, `helpers`, or `utils` directories. Name shared areas by responsibility, define import rules, and promote code only after genuine reuse or stable ownership is demonstrated.

## Verification

Fail the structure gate when a new directory has no current responsibility, feature internals are imported across ownership boundaries, reusable UI depends on product features, API/platform details spread through components, or generated product artifacts enter the harness.
