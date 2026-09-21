---
name: be-security-reliability
description: Design or review backend authentication, authorization, secret handling, abuse controls, observability, resilience, and recovery. Use for backend security and operational risk, not for a standalone formal security audit.
---

# Be Security Reliability

Start from assets, actors, trust boundaries, failure budget, availability needs, data sensitivity, and existing platform controls. Prioritize risks supported by the system context rather than producing a generic checklist.

Follow [security and reliability profile](../../references/security-reliability-profile.md).

## Output

Define identity and authorization enforcement, credential and secret lifecycle, input and output protection, rate or quota controls, dependency timeouts, retries and circuit behavior, queue safety, concurrency, audit events, health signals, alerts, backup, restore, incident stopping conditions, and residual risk.

## Completion

The design is complete when important threats and operational failures map to preventive controls, detection, recovery, and verifiable evidence. Do not change live policy or infrastructure without explicit authorization.
