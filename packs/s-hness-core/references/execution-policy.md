# Execution Policy

Classify side effects before execution:

- `none`: inspection, analysis, planning, and read-only verification;
- `workspace-write`: edits limited to the user-designated target workspace; and
- `external`: installation, live services, devices, desktop applications, publishing, deployment, or communication with third parties.

For `workspace-write`, confirm the exact workspace and approved scope. For `external`, require explicit authorization immediately before the action and define success, failure, stopping, and recovery behavior.

Never treat a plan as authorization to commit, push, publish, deploy, purchase, message, delete valuable data, or mutate a live system. Preserve unrelated user changes and prefer recoverable operations.
