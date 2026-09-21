# Runtime Verification

Map each capability and failure mode to the lowest trustworthy evidence level.

| Level | Evidence |
|---|---|
| Unit | policy evaluation, budgets, normalization, and result classification |
| Contract | orchestrator-to-driver request/result and permission boundaries |
| Integration | real MCP/API/CLI/browser/desktop boundary when available and authorized |
| System | supervised or unattended workflow through the selected host |
| Lifecycle | session cleanup, watchdog, cancellation, recovery, and evidence retention |

## Required checks

- permissions deny actions outside the project allowlist;
- session budgets stop iteration, duration, retry, and repeated-failure overruns;
- emergency stop and cancellation release handles and preserve evidence;
- driver selection prefers stable native paths and falls back only when permitted;
- failures distinguish `pass`, `fail`, and `unverified`;
- evidence contains action, assertion, observation, and environment context;
- a hung app, browser, MCP server, or process triggers watchdog/recovery behavior; and
- unattended workflows cannot expand their targets or capabilities at runtime.

Mock drivers and contract tests can verify internal behavior. They cannot prove that a real app, browser, OS, device, account, license, network, MCP server, or API works. Report unavailable live prerequisites as `unverified`.