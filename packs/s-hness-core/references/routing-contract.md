# Routing Contract

Use this contract when a request must be classified before work begins.

```yaml
phase: discover | spec | plan | cook | loop | run | control | test | debug | verify | review | deliver
domains:
  - general | web | frontend | backend | tools | iot | multi | unresolved
skills:
  - installed-skill-name
capabilities:
  - internal-domain-capability-id
workspace: absolute-path | unresolved
side_effect: none | workspace-write | external
approval_required: true | false
verification:
  - expected evidence
assumptions:
  - explicit assumption
```

## Precedence

1. Honor a compatible explicitly invoked skill.
2. Infer phase from the requested outcome, not isolated keywords.
3. Select the narrowest domain that owns the work.
4. Use multiple domains only when the request crosses real responsibility boundaries.
5. If no internal domain capability owns the work, route through core and identify the missing specialization.

`skills` identifies the public core skill that owns the next action. `capabilities` identifies the internal domain guidance that core should load for that action; it does not
make an internal capability a separately invocable public skill. Use public `s-control` for live authorization and interaction requests; it delegates to `tools/ai-control-runtime`.

Routing describes the next workflow. It never grants permission to execute it.

Use `s-spec` after discovery when product behavior, interfaces, failures, constraints, and acceptance criteria must be defined. Route to domain design after the specification is stable, then use `s-plan`.

Use `s-cook` when the user wants end-to-end execution of an approved multi-phase plan. Use `s-run` for one focused phase, increment, or change.

Use `s-loop` when the user explicitly wants autonomous progression through an approved phase-based plan with implementation, deep testing, verification, and important progress/error logging. `s-loop` still stops on material failure, missing approval, unresolved scope, or unavailable required environment.

Use `s-control` when the user wants AI to authorize, configure, attach to, or interact with a named app or website. It must obtain explicit approval immediately before activating the grant or performing live interaction, and it does not bypass host or OS permissions.

Use `s-test` for a standalone, risk-based test workflow that defines test scope, compares material strategy choices, executes checks, triages failures, and records evidence. Use `s-verify` afterward when the results must be mapped to acceptance criteria for a lifecycle handoff.

`debug` and `deliver` have no dedicated public skill. Route `debug` to `s-test` for reproduction and failure triage, then to `s-run` for an authorized focused fix. Route `deliver` to `s-run` (or `s-cook` for a multi-phase delivery plan) with the tool packaging and delivery-verification capabilities; delivery never authorizes publishing or deployment.

## Installed domain mapping

For `backend`, choose the narrowest internal capability:

- `be-api-design` for public or internal service contracts;
- `be-data-design` for persistence ownership, schemas, and migrations;
- `be-service-design` for use-case, service, worker, and adapter boundaries;
- `be-security-reliability` for backend security, resilience, and recovery; and
- `be-verify` for backend-focused evidence.

For `frontend`, choose the narrowest internal capability:

- `fe-architecture` for application, route, feature, and dependency boundaries;
- `fe-ui` for interaction and component-state design;
- `fe-state-data` for client and server-data ownership and synchronization;
- `fe-quality` for accessibility, responsive, localization, and performance requirements; and
- `fe-verify` for frontend-focused evidence.

For `web`, choose the narrowest internal capability:

- `web-system-design` for full-stack architecture and rendering boundaries;
- `web-integration` for browser-service contracts, identity flows, and cross-boundary failures;
- `web-deployment` for environments, rollout, migration, and recovery design; and
- `web-verify` for browser-to-service verification evidence.

For `tools`, choose the narrowest internal capability:

- `tool-product-design` for tool form, architecture, runtime boundaries, and project structure;
- `tool-interface-design` for CLI, TUI, desktop, chat, plugin, add-in, or automation interactions;
- `tool-integration-design` for SDK, API, file, OS, process, device, and host-application boundaries;
- `tool-packaging-design` for build artifacts, installation, updates, migrations, rollback, and uninstall; and
- `tool-delivery-verify` for source, behavior, integration, package, and delivery evidence.

The complete phase/domain-to-capability mapping is maintained in
[domain capabilities](./domain-capabilities.md). Use that registry instead of copying
domain guidance into the core lifecycle skills.

Combine a Web skill with the core phase rather than replacing it. For example, planning a new full-stack topology uses `s-plan` with `web-system-design`; executing the approved plan remains owned by `s-run`.

For full-stack work, Web owns cross-boundary topology and contracts. Add only the FE or BE skills that own the internal responsibilities in scope. Do not load both packs automatically for work confined to one side.

When planning or executing work that creates, reorganizes, or materially extends backend source, include `be-service-design` so the backend structure gate is applied. For equivalent frontend work, include `fe-architecture`. This requirement also applies inside full-stack Web plans.

When planning or executing work that creates, reorganizes, or materially extends a software-tool source tree, include `tool-product-design` so the tool structure gate is applied. Tool delivery verification uses `tool-delivery-verify` alongside the core verification gate.
