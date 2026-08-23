# Tool Interface Profile

Apply the sections that match the selected tool form.

## Common states

Define input validation, help, progress, cancellation, partial success, actionable errors, recovery, and confirmation before destructive or external effects. Separate a proposed action from an executed action.

## CLI and automation

Specify command grammar, defaults, help, exit codes, stdout versus stderr, structured output, quiet/non-interactive modes, signal handling, and behavior when confirmation is impossible.

## Desktop and native panels

Specify navigation, focus order, keyboard operation, accessibility names, scaling, empty/loading/error states, long-running work, close behavior, and recovery after host or process interruption.

## TUI

Specify keyboard navigation, focus, resizing, color-independent status, terminal capability fallback, cancellation, and cleanup on exit.

## Chat

Specify intent confirmation, preview, approval, progress updates, cancellation, resumability, evidence, and how the user distinguishes guidance from actual execution.
