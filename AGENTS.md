# S_HNess Instructions

This repository is an instruction harness for engineering work. It is not a product repository. Keep generated product source, plans, tests, reports, datasets, models, and build outputs in the user-designated target workspace.

## Routing

Use `packs/s-hness-core` as the public domain-neutral outer layer. Core routes to internal backend, frontend, web, and tools capabilities under `packs/s-hness-core/references/domain/`, including `tools/ai-control-runtime` for AI-controlled app/web interaction. Use public `s-control` for explicit app/website authorization and live interaction requests. Use `packs/s-hness-maintenance` only for explicitly requested local S_HNess plugin maintenance.

- Explicit skill invocation takes precedence.
- Use `s-route` when phase or domain is unclear.
- Use core lifecycle skills for general work.
- Use `s-spec` to define required behavior and acceptance criteria before domain design and `s-plan`.
- Every `s-plan` workflow must create `plans/<topic-slug>.md` for a new independent topic, or update an exact existing plan only when the user identifies or explicitly continues it. It must read the selected file back before reporting completion. Never append a new topic to root `plan.md` merely because that file exists. A planning request after native `/plan` mode follows the same workflow.
- Use `s-cook` only for an approved multi-phase plan; use `s-run` for one focused execution phase.
- Let core load the narrowest internal domain capability for API, persistence, service, frontend, web, or software-tool responsibilities using the domain capability registry.
- Load `s-hness-maintenance` only when the user explicitly requests a local S_HNess plugin reinstall or refresh. Use its deterministic script instead of reconstructing the filesystem and Codex CLI workflow manually.
- Do not route isolated visual/frontend work or backend-only service work to the Web pack when a narrower domain owns it.
- Add future domain guidance under the core capability registry only when the request needs that specialization.
- For multi-domain work, load only the packs that own an actual responsibility.
- When tool source is created or reorganized, include `tool-product-design` to define the project tree, directory responsibilities, and dependency direction.

Internal domain capabilities must extend the core lifecycle rather than duplicate discovery, planning, execution, verification, or review.

## Side effects

Inspection and analysis do not authorize mutation. Before consequential writes or external actions, confirm the target, scope, approval requirement, verification, and recovery boundary. Never infer authorization to install, commit, push, publish, deploy, or operate a live system.

## Documentation

Write skill instructions in English. Write user-facing repository documentation in Vietnamese. Keep references conditional and avoid empty directories or speculative domain packs.
