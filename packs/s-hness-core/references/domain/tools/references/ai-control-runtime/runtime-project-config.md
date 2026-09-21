# Runtime Project Configuration

Project-specific configuration belongs in the consuming project root, not in the harness. A `.s-hness/` directory is optional and must not be required by the runtime. Follow the project's existing naming and layout conventions; the following is one valid root-level arrangement:

```text
project/
├── apps/
│   └── <app-profile>.yaml
├── web/
│   └── <site-profile>.yaml
├── permissions.yaml
├── loop-policy.yaml
├── workflows/
├── test-plans/
└── artifacts/
```

## Profile responsibilities

An app or site profile may define process/window identity, launch or attach method, supported drivers, selectors or UI hints, action allowlist, verification conditions, reset method, and environment prerequisites.

`permissions.yaml` defines project targets and allowed actions. `loop-policy.yaml` defines mode, duration, iterations, retry count, repeated-failure stop, diff limits, and emergency-stop behavior. Workflows compose named actions without embedding credentials.

Keep secrets in the approved secret store or OS credential boundary and refer to them by opaque name. Do not put secret values, personal paths, uncontrolled URLs, or generated artifacts in reusable harness guidance.

Malformed or missing configuration is a preflight failure. The runtime must not guess a target, widen a path, require a hidden directory convention, or continue with an implicit default that changes authority.