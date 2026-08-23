---
name: tool-packaging-design
description: Design how a software tool is built, packaged, configured, installed, updated, migrated, rolled back, and uninstalled. Use when delivery lifecycle decisions are needed; do not publish or install without authorization.
---

# Tool Packaging Design

Create a reproducible delivery design for the approved tool and its supported platforms. Read the [tool packaging profile](../../references/tool-packaging-profile.md).

Define the artifact matrix, runtime prerequisites, deterministic build inputs, version and compatibility policy, configuration and secret locations, installation and first-run behavior, update and migration path, rollback strategy, uninstall and cleanup behavior, signing or notarization requirements when applicable, and release evidence.

Separate build-time, install-time, and runtime configuration. Never place secrets in source or packaged defaults. Treat publishing, signing, installation, and update rollout as side effects requiring explicit authorization.
