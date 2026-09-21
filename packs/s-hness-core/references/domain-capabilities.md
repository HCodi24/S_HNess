# Domain Capability Registry

This registry is the core routing index for specialized guidance. The entries are internal
capabilities, not additional public lifecycle skills. Core selects the narrowest domain and
loads only the entries needed for the current phase.

## Capability identifiers

| Domain | Internal capability IDs |
|---|---|
| backend | `backend/be-api-design`, `backend/be-data-design`, `backend/be-service-design`, `backend/be-security-reliability`, `backend/be-verify` |
| frontend | `frontend/fe-architecture`, `frontend/fe-ui`, `frontend/fe-state-data`, `frontend/fe-quality`, `frontend/fe-verify` |
| web | `web/web-system-design`, `web/web-integration`, `web/web-deployment`, `web/web-verify` |
| tools | `tools/tool-product-design`, `tools/tool-interface-design`, `tools/tool-integration-design`, `tools/tool-packaging-design`, `tools/tool-delivery-verify`, `tools/ai-control-runtime` |

## Source path resolution

For an internal capability ID `<domain>/<skill>` resolve the source at:

`packs/s-hness-core/references/domain/<domain>/skills/<skill>/SKILL.md`

Each relocated capability retains its original sibling `references/` directory, so relative links from the capability remain local to that domain boundary.

## Phase mapping

| Phase | Domain signal | Capability selection |
|---|---|---|
| control | named desktop app, website, or AI interaction target | Select `tools/ai-control-runtime`; add the narrowest tool capability needed for the selected integration or interface. The public owner is `s-control`. |
| discover | backend, frontend, web, or tools | Select only the design capability that owns the unresolved responsibility. |
| spec | backend, frontend, web, or tools | Select the capability needed to define the relevant behavior and failure boundary. |
| plan | backend, frontend, web, or tools | Select the capability needed to make the implementation structure and verification decision-complete. |
| run | backend, frontend, web, or tools | Select the implementation-relevant capability; add structure guidance when source is created or reorganized. |

AI-controlled app/web workflows select `tools/ai-control-runtime` in addition to any narrower tool capability needed for product form, interface, integration, packaging, or delivery verification.
| test | backend, frontend, web, or tools | Select the matching domain verification capability and retain the core test workflow. |
| cook | backend, frontend, web, or tools | Resolve capabilities per child phase; do not preload unrelated domain guidance. |
| loop | backend, frontend, web, or tools | Resolve capabilities for the current bounded phase; keep loop controls in core. |
| verify | backend, frontend, web, or tools | Select the matching domain verification capability and retain the core verification gate. |
| review | backend, frontend, web, or tools | Select the matching domain guidance for correctness and operational-risk review. |
| deliver | tools | Select tool packaging and delivery verification capabilities when tool delivery is in scope. |
| reinstall/refresh | maintenance | Load maintenance only when the user explicitly requests local S_HNess plugin maintenance. |

## Selection rules

1. An explicitly invoked core skill remains the lifecycle owner.
2. An explicit domain capability name is treated as a routing signal and loads the matching
   internal capability; it is not exposed as a separate public entry.
3. Choose the narrowest domain. Use `multi` only when the request has genuinely independent
   responsibilities in more than one domain.
4. Do not load maintenance for ordinary engineering work.
5. Routing does not grant permission to mutate files, install plugins, access live systems,
   publish, deploy, or communicate externally. Those decisions remain governed by the
   execution policy and the current user authorization.

## Source and verification boundary

Domain capability source lives under the core plugin's non-indexed reference boundary after
the packaging phase. Relative links inside a capability must remain valid after relocation.
The source tree and manifest validator can prove packaging consistency, but they cannot prove
that a running Codex client hides the old domain entries from every installed cache. That
client-level visibility remains `unverified` until checked in the actual client environment.