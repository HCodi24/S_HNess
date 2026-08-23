---
name: tool-interface-design
description: Design the interaction contract for CLI, TUI, desktop, chat, plugin, add-in, and automation tools. Use for commands, screens, feedback, errors, progress, cancellation, and accessibility; do not use for backend API design alone.
---

# Tool Interface Design

Design an interface that exposes the approved tool behaviors without coupling the application core to one presentation technology. Do not implement the interface.

Read the [tool interface profile](../../references/tool-interface-profile.md), then define:

- the command, screen, panel, or conversational interaction model;
- inputs, outputs, validation, help, defaults, and discoverability;
- idle, loading, empty, success, partial, error, cancellation, and recovery states;
- progress and long-running operation behavior;
- accessibility, keyboard, responsive, and non-interactive requirements that apply;
- machine-readable output and exit behavior where automation is supported; and
- approval and confirmation boundaries for destructive or external actions.

Keep presentation-specific objects outside stable application and domain contracts. State assumptions and unresolved product decisions explicitly.
