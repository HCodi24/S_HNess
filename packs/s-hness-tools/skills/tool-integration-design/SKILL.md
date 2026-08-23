---
name: tool-integration-design
description: Design stable boundaries between a software tool and SDKs, APIs, files, operating systems, processes, devices, or host applications. Use for adapter contracts, lifecycle, compatibility, and failure handling; do not execute live integrations.
---

# Tool Integration Design

Define integration boundaries that isolate external volatility from stable tool behavior. Preserve user-selected technologies and existing project conventions. Do not claim a live capability without evidence.

Read the [tool integration boundaries](../../references/tool-integration-boundaries.md), then specify:

- required external capabilities and the adapter contract for each one;
- connection, session, process, file, handle, or host-object lifecycle;
- normalization of external values and errors into stable internal types;
- permission, authentication, concurrency, thread-affinity, timeout, retry, and cancellation behavior;
- capability detection and supported version matrix;
- recovery and cleanup behavior for partial failures; and
- test doubles, contract tests, and prerequisites for live verification.

Keep external SDK and platform types inside adapters. Mark unavailable or untested live paths explicitly.
