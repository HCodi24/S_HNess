# Runtime Interface

Expose a technology-neutral interface for supervised and unattended control.

## Request flow

1. Parse the intent into a named workflow and target capability.
2. Show the resolved project, targets, actions, risk class, budgets, and approval needs.
3. Obtain the required approval or reject the request.
4. Report progress, observations, evidence, retries, recovery, and cancellation.
5. Return a structured terminal result and a resumable report when configured.

Separate a proposed action from an executed action. The user must be able to distinguish guidance, preview, waiting for approval, execution, partial completion, failure, and unavailable evidence.

## Automation surface

CLI or API consumers should receive machine-readable output containing session ID, action ID, status, evidence paths, error category, and next safe action. Non-interactive execution must fail closed when approval is required but unavailable.

Long-running workflows need heartbeats, deadline display, cancellation, emergency stop, and cleanup status. Progress output must not expose credentials, sensitive page contents, or uncontrolled external data.

## Interaction states

Support idle, loading, approval-needed, running, paused, partial, pass, fail, unverified, cancelled, recovered, and stopped states. A stopped or cancelled workflow must not be reported as successful.