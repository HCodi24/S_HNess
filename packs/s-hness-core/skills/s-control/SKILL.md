---
name: s-control
description: Authorize and operate an AI control connection for a named desktop app or website through a user-approved project profile and bounded runtime session.
---

# S Control

Use this skill when the user wants AI to connect to, authorize, configure, or interact with a named desktop app, website, or other controllable target.

This is the direct user-facing control entrypoint. It is not a planning or testing lifecycle skill. Route the control work to the internal `tools/ai-control-runtime` capability and load narrower tool guidance when the request also requires product, interface, integration, packaging, or delivery design.

## Control workflow

1. Identify the exact target application or website, target workspace, intended outcome, and whether the request is onboarding, one-time interaction, testing, or bounded unattended execution.
2. Inspect the consuming project's root-level control profile and available control mechanisms without contacting or mutating the live target yet. Use the project's existing file and directory conventions; do not require a `.s-hness/` directory.
3. Select the strongest available driver in this order: native integration/API/CLI/MCP, UI automation, then browser or computer-use fallback. Report unavailable mechanisms instead of pretending an integration exists.
4. Produce a permission proposal containing the target identity, requested actions, data boundaries, duration, retry/iteration limits, destructive-action policy, and evidence to be collected.
5. Ask for explicit user approval immediately before creating or activating a grant, attaching to the target, launching it, or performing live interaction. Approval for the conversation is not a standing grant for unrelated targets or future runs.
6. After approval, create or update the project-owned profile at the project root or another path explicitly selected by the user, establish a named session, enforce the intersection of harness safety, project allowlist, and host/OS permissions, then execute only the approved actions.
7. Observe and record normalized results and evidence for material actions. Stop on denied permission, ambiguous target identity, unsafe state, timeout, repeated failure, unsaved destructive state, or an explicit stop request.
8. Report `pass`, `fail`, or `unverified`, the effective permissions, actions taken, evidence location, and any residual access. Revoke or close the session when the requested scope ends.

## Non-negotiable boundaries

- Do not claim that a skill can bypass OS, browser, app, MCP, or user permissions. A skill can request and coordinate authorization; the host integration must grant it.
- Do not place app-specific profiles, credentials, selectors, screenshots, logs, or test artifacts in the harness. They belong to the consuming project root or its explicitly approved project-owned artifact location.
- Do not infer permission to delete data, publish, send external data, use credentials, close unsaved work, change policies, or continue indefinitely. These require a separately approved policy boundary.
- Unattended operation means explicitly pre-approved, time-bounded, iteration-bounded operation with an emergency stop and failure recovery policy.
- If no executable runtime or compatible driver is available, complete only the design/onboarding portion and mark live interaction `unverified`.

## References

Read the internal runtime guidance relevant to the current request:

- [runtime contract](../../references/domain/tools/references/ai-control-runtime/runtime-contract.md)
- [runtime permissions](../../references/domain/tools/references/ai-control-runtime/runtime-permissions.md)
- [runtime drivers](../../references/domain/tools/references/ai-control-runtime/runtime-drivers.md)
- [runtime interface](../../references/domain/tools/references/ai-control-runtime/runtime-interface.md)
- [runtime project config](../../references/domain/tools/references/ai-control-runtime/runtime-project-config.md)
- [runtime verification](../../references/domain/tools/references/ai-control-runtime/runtime-verification.md)

## Example invocations

```text
$s-control authorize SolidWorks so AI can open a file, read state, and run a check
$s-control connect to this staging website, run the login workflow, and record evidence
$s-control rerun tests on the authorized app for at most 20 iterations
```

The first invocation is an authorization/onboarding request. Later invocations may reuse only the active project grant and session policy that the user approved.
