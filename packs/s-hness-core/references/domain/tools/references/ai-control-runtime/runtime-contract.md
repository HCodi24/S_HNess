# Runtime Contract

Define a stable control and observation contract between an AI controller, the orchestrator, and external drivers. Adapter-specific SDK objects and exceptions must not cross this boundary.

## Session operations

- `session.open`: create a scoped session from a project profile and permission policy.
- `session.attach`: attach to an existing permitted app, browser, process, or host context.
- `session.observe`: read normalized UI, DOM, process, log, file, and state observations.
- `session.close`: release handles and clean up according to the project policy.

Every session has an identifier, project identity, granted capabilities, start time, deadline, cancellation state, and evidence destination.

## Action operations

The stable action vocabulary may include:

- `focus`, `click`, `type`, `hotkey`, `select`, `navigate`, and `wait`;
- `file.open`, `file.edit`, `file.save`, and `file.verify`;
- `web.open`, `web.tab`, `web.form`, and `web.assert`;
- `process.launch`, `process.attach`, and `process.read-state`;
- `invoke.cli`, `invoke.api`, and `invoke.mcp`; and
- `evidence.capture` and `assert.record`.

Each action must carry the session ID, capability name, target reference, normalized arguments, timeout, retry policy, and idempotency classification.

## Results and failures

Return a normalized result with action ID, status, observation delta, evidence references, elapsed time, and structured error when applicable. Use these terminal classifications:

- `pass`: the requested action or assertion completed with sufficient evidence;
- `fail`: the action or assertion ran and contradicted the expected result; and
- `unverified`: the required evidence or environment was unavailable.

Never convert a permission denial, unavailable live host, or missing evidence into `pass`.