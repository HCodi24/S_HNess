# Tool Form Selection

Choose the smallest form that satisfies the specification and target environment.

| Form | Prefer when | Main constraints |
| --- | --- | --- |
| CLI | Scriptability, pipelines, remote use, or repeatable operations dominate | Stable arguments, exit codes, stdout/stderr, non-interactive mode |
| TUI | Terminal use needs persistent navigation or live status | Terminal capability, resizing, keyboard navigation, fallback behavior |
| Desktop | Rich local interaction, files, graphics, or background state dominate | OS lifecycle, accessibility, packaging, updates |
| Chat | Intent is conversational and operations need proposal/approval | Ambiguity, progress, cancellation, auditability, side-effect gates |
| Plugin or add-in | The workflow must live inside a host application | Host lifecycle, API versions, thread affinity, installation, recovery |
| Automation worker | Scheduled or event-driven execution dominates | Idempotency, retries, observability, secrets, operational ownership |
| Library | Another program owns interaction and lifecycle | Stable API, compatibility, dependency footprint, documentation |
| Service | Multiple clients or remote access require a managed boundary | Protocol, auth, deployment, persistence, operations |

Evaluate interaction frequency, host ownership, platform reach, permissions, distribution, offline behavior, background execution, integration locality, and operational burden. Hybrid forms are valid only when each surface owns a distinct responsibility.
