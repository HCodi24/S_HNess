# Tool Verification Profile

Use the narrowest evidence that proves each acceptance criterion, then broaden according to risk.

| Level | Proves |
| --- | --- |
| Unit | Stable rules and transformations |
| Contract | Interface and adapter assumptions |
| Integration | Real boundaries available in the test environment |
| System | User-visible workflow through the selected host or process |
| Package | Artifact creation, contents, identity, and launch/load behavior |
| Lifecycle | Install, update, migration, rollback, repair, and uninstall |

Also inspect source-tree responsibilities, dependency direction, forbidden framework or SDK leakage, generated-file placement, and absence of empty speculative directories.

For every check, record the environment, command or procedure, result, and limitation. Use `verified`, `failed`, or `unverified`. An unavailable host application, license, device, account, network, or supported platform makes the affected claim `unverified`, not passed.
