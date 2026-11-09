---
name: ai-control-runtime
description: Design and verify a permissioned runtime that lets AI interact with desktop apps and websites through stable control, observation, and recovery capabilities.
---

# AI Control Runtime

Treat this capability as the harness guidance for an AI-operated control runtime. The runtime is general-purpose; automated testing is a primary workflow, not its identity.

## Capability boundary

The runtime coordinates AI intent, user-approved permissions, control adapters, observation, evidence, bounded loops, and recovery. It does not embed a project-specific app, website, credential, selector, or test artifact.

Read the directly relevant references before making a design or implementation decision:

- [runtime contract](../../references/ai-control-runtime/runtime-contract.md)
- [runtime permissions](../../references/ai-control-runtime/runtime-permissions.md)
- [runtime drivers](../../references/ai-control-runtime/runtime-drivers.md)
- [runtime interface](../../references/ai-control-runtime/runtime-interface.md)
- [runtime project config](../../references/ai-control-runtime/runtime-project-config.md)
- [runtime verification](../../references/ai-control-runtime/runtime-verification.md)

## Operating model

1. Load the project capability profile and effective permissions.
2. Establish a named session and reject capabilities outside the intersection of harness, project, and OS/host policy.
3. Prefer native/API/CLI control, then UI automation, then browser or computer-use fallback.
4. Normalize observations, actions, failures, and evidence behind stable contracts.
5. Run only within explicit duration, iteration, retry, and stop budgets.
6. Record assertions and evidence for every material action; classify outcomes as `pass`, `fail`, or `unverified`.
7. Recover or stop safely on timeout, permission denial, host interruption, unsaved state, or repeated failure.

## Safety boundary

Unattended execution means pre-approved bounded execution, not unrestricted authority. Destructive actions, publishing, external data transfer, closing unsaved work, credential use, and policy changes require an explicit project policy and approval boundary. Fail closed when authorization or state is ambiguous.

Keep platform SDK types, process handles, browser objects, and computer-use details inside adapters. Keep project-specific profiles in the consuming project root (or another project-owned path the user selects), following the project's existing conventions as described in [runtime project config](../../references/ai-control-runtime/runtime-project-config.md); a `.s-hness/` directory is optional and must not be required. Never place them in the harness.