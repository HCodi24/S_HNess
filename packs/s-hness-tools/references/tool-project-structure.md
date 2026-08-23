# Tool Project Structure

Preserve an existing repository's coherent conventions first. Use the following responsibility map only as a starting point, not a mandatory literal tree:

```text
<tool-root>/
|-- src/
|   |-- host/             # Process, application, plugin entry, and lifecycle
|   |-- application/      # Use cases, orchestration, and approval flow
|   |-- domain/           # Stable commands, results, and business rules
|   |-- integrations/     # SDK, API, file, device, and host adapters
|   `-- infrastructure/   # Configuration, logging, persistence, platform services
|-- tests/
|   |-- unit/
|   |-- contract/
|   |-- integration/
|   `-- system/
|-- packaging/            # Only when the tool is shipped or installed
`-- scripts/              # Only deterministic development or release helpers
```

Small tools may combine layers when separation adds no value. Do not create empty folders. Every proposed directory must have a concrete responsibility, owner, and reason to exist.

Dependencies should normally point from host and infrastructure toward application contracts, and from application toward stable domain behavior. External SDK, UI framework, persistence, and operating-system types stay at their boundaries. Tests mirror behavior and boundaries rather than duplicating every source directory.

For source creation or reorganization, record:

- the current and proposed trees;
- each added, removed, or changed directory's responsibility;
- allowed and forbidden dependency directions;
- locations for entry points, configuration, integrations, generated files, packaging, and tests; and
- any justified deviation from repository convention.
