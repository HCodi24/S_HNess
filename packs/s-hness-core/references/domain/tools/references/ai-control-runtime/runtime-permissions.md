# Runtime Permissions

Effective permission is the intersection of:

```text
harness safety ceiling
  ∩ project allowlist
  ∩ OS/Codex/host permissions
  ∩ session grant
```

A lower layer can remove authority but cannot expand it.

## Project policy requirements

A project policy should identify:

- permitted app and browser profiles;
- allowed actions and target scopes;
- process launch/attach rules;
- file roots and read/write/delete boundaries;
- network, API, MCP, and external-transfer rules;
- credential references without storing secret values;
- unattended mode, duration, iteration, retry, and diff limits;
- approval requirements for destructive or irreversible actions; and
- emergency stop, cancellation, watchdog, and recovery behavior.

Use explicit allowlists and deny by default. A missing, malformed, expired, or conflicting policy is a denial.

## Approval classes

- `automatic`: observation and non-destructive test actions within the allowlist;
- `session-approved`: a bounded workflow approved before unattended execution; and
- `per-action-approved`: deletion, publishing, external transfer, credential use, closing unsaved work, or policy changes.

The runtime must preview a consequential action before execution and record the approval decision, actor, scope, and time.

## Unattended execution

Unattended mode is valid only when a user has explicitly approved a named workflow and finite budgets. It must stop on budget exhaustion, repeated failure, permission mismatch, emergency stop, host loss, or ambiguous state. It must not silently grant new capabilities or broaden targets.