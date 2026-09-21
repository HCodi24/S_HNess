# User Design Gate

Engineering discovery and planning must obtain the user's direct input about code architecture and, when the product has a user-facing interaction, UI/UX. Inspect the target workspace first so the questions name the actual system, constraints, and plausible choices instead of asking for generic preferences.

## Code architecture

Ask how the user wants the code organized and which architectural constraints or preferences matter for this change. Ground the question in the problem and existing repository: identify relevant boundaries, ownership, dependency direction, extension points, or stack choices and briefly state any observed convention worth preserving. Do not silently treat the existing structure or the agent's preferred architecture as user approval.

The user may approve a proposed direction, choose another direction, require preservation of the current architecture, or explicitly delegate the decision. Record that response and its rationale or constraints. Delegation authorizes the applicable domain-design skill to decide; it does not authorize architecture selection during specification or implementation.

## Comparing choices

Whenever a material decision has multiple viable options, do not silently choose one or present an unexamined recommendation as settled. Show the relevant options and compare them against criteria that fit the problem, such as user value, compatibility, complexity, delivery cost, performance, accessibility, security, operational risk, reversibility, and maintenance. State the main trade-offs and recommendation, if one is useful, then ask the user to choose an option or explicitly delegate the decision. Record the selected option and why; if no option is selected, keep the decision unresolved and return `needs_input` before completing the affected phase.

Do not manufacture a long menu for incidental details that have no meaningful alternative or consequence. When constraints leave only one viable option, state the constraint and why it is the only option. Domain-design may refine the comparison, but it must preserve the user's choice or explicit delegation.

## UI/UX

When the work affects a web, mobile, desktop, CLI, TUI, chat, plugin, add-in, API-consumer, or other user-facing interaction, ask about the experience decisions that materially affect this problem. Adapt the question to the interface: for example workflow and states for a GUI, command shape and feedback for a CLI, conversational flow for chat, or consumer ergonomics for an API. Cover only relevant choices such as information hierarchy, interaction flow, visual direction, accessibility, responsiveness, feedback, empty/error states, or compatibility.

Do not ask for visual styling when the problem has no visual interface. For backend-only, data-only, infrastructure, or internal-library work with no user-facing interaction, explicitly record that UI/UX is not applicable and why.

## Gate behavior

- Ask after inspecting discoverable context and present concise, problem-specific prompts rather than a generic questionnaire.
- Do not infer answers from silence. If the user has already answered a question explicitly in the current conversation or an approved artifact, cite and confirm that answer instead of asking it again verbatim.
- For every material decision with multiple viable options, compare the options and obtain the user's selection or explicit delegation before treating it as resolved.
- Discovery is not complete until the architecture response and the applicable UI/UX response or not-applicable rationale are recorded.
- Planning must explicitly reconfirm these decisions against the proposed implementation boundaries. If either decision is missing or contradicted, return `needs_input` or route to the relevant domain-design skill before writing a completed plan.
