# Runtime Drivers and Integration

Use capability-oriented adapters for every external boundary.

## Selection order

```text
native/API/CLI
  → UI automation
  → browser interaction or computer-use fallback
```

The orchestrator selects a driver from a project profile and capability detection. It must not assume that a driver, browser, process, license, account, or host is available.

## Driver families

- `process-native`: process, file, CLI, or application-native control;
- `ui-automation`: semantic controls, windows, selectors, and accessibility trees;
- `browser`: tabs, navigation, DOM, forms, and browser state;
- `computer-use`: visual mouse, keyboard, and screen interaction fallback; and
- `mcp`: explicit tool calls through a permitted MCP server.

All drivers implement normalized lifecycle, observe, act, cancel, timeout, and cleanup operations. External handles, browser objects, SDK values, and platform exceptions stay inside the adapter.

## Failure and recovery

Normalize failures into categories such as permission denied, target missing, host unavailable, timeout, stale state, transport error, unsupported capability, and unknown state. Retry only when the operation is safe and idempotent. Reconnect or reset only through the project profile; otherwise stop and preserve evidence.

Live integration requires the real app, browser, host, account, license, network, or OS capability. Test doubles prove only the internal adapter contract.