# S_HNess Instructions

This repository is an instruction harness for engineering work. It is not a product repository. Keep generated product source, plans, tests, reports, datasets, models, and build outputs in the user-designated target workspace.

## Routing

Use `packs/s-hness-core` as the domain-neutral outer layer. Add `packs/s-hness-backend` for server and data responsibilities, `packs/s-hness-frontend` for client experience responsibilities, `packs/s-hness-web` when work crosses those boundaries, and `packs/s-hness-tools` for software-tool product and delivery concerns.

- Explicit skill invocation takes precedence.
- Use `s-route` when phase or domain is unclear.
- Use core lifecycle skills for general work.
- Use `s-spec` to define required behavior and acceptance criteria before domain design and `s-plan`.
- Every `s-plan` workflow must write or update `plan.md` at the current target workspace root and read it back before reporting completion. A planning request after native `/plan` mode should follow the same workflow.
- Use `s-cook` only for an approved multi-phase plan; use `s-run` for one focused execution phase.
- Load `s-hness-backend` for API, persistence, service, backend security/reliability, or backend verification work.
- Load `s-hness-frontend` for frontend architecture, UI behavior, client state/data, accessibility/performance, or frontend verification work.
- Load `s-hness-web` for full-stack architecture, frontend-backend integration, web deployment design, or end-to-end web verification.
- Load `s-hness-tools` for CLI, TUI, desktop, chat, plugin, add-in, automation, library, or service-tool architecture, interface, external integrations, packaging, or delivery verification.
- Do not route isolated visual/frontend work or backend-only service work to the Web pack when a narrower domain owns it.
- Load any future domain pack only when the request needs that specialization.
- For multi-domain work, load only the packs that own an actual responsibility.
- When tool source is created or reorganized, include `tool-product-design` to define the project tree, directory responsibilities, and dependency direction.

Domain packs must extend the core lifecycle rather than duplicate discovery, planning, execution, verification, or review.

## Side effects

Inspection and analysis do not authorize mutation. Before consequential writes or external actions, confirm the target, scope, approval requirement, verification, and recovery boundary. Never infer authorization to install, commit, push, publish, deploy, or operate a live system.

## Documentation

Write skill instructions in English. Write user-facing repository documentation in Vietnamese. Keep references conditional and avoid empty directories or speculative domain packs.
