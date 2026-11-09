---
name: s-reinstall
description: Reinstall one or more local S_HNess plugins from canonical harness source through a deterministic staged workflow with validation, backup, rollback, and post-install evidence. Use only when the user explicitly asks to refresh or reinstall installed S_HNess plugins.
---

# S Reinstall

Refresh installed S_HNess plugins without reconstructing filesystem or Codex CLI commands ad hoc.

## Boundaries

Resolve the canonical root in this order: a root the user explicitly supplies, the `S_HNESS_ROOT` environment variable, then the default `C:\GitHub\S_HNess`. Stop and ask when the resolved root does not exist. The deterministic script is [reinstall-s-hness-plugin.ps1](../../scripts/reinstall-s-hness-plugin.ps1). It may read canonical source, the personal marketplace, installed plugin source, system `plugin-creator` helpers, and Codex CLI state.

The mutation boundary is limited to staging, backing up, and replacing explicitly named plugin directories under the current user's `plugins` directory, then running `codex plugin add`. A request to reinstall does not authorize deleting retained backups, changing marketplace configuration by hand, committing, publishing, or modifying unrelated plugins.

## Workflow

1. Resolve the exact plugin names and canonical root. Read the canonical repository instructions and current changes. Reject names without a matching `packs/<plugin-name>` source and personal marketplace entry.
2. Run the script with the resolved names and `-WhatIf`. Report canonical source, active target, planned backup behavior, prerequisites, and any preflight failure.
3. Immediately before external writes, ask for explicit approval and name every plugin that will be replaced. Stop after the dry run when approval is absent.
4. After approval, run the same script without `-WhatIf` and with `-Confirm:$false`. Do not replace it with handwritten copy, move, cachebuster, or install commands while it is available.
5. Report progress for staging, validation, source-to-target replacement, Codex registration, verification, and rollback if triggered.

Dry-run command:

```powershell
& <plugin-root>\scripts\reinstall-s-hness-plugin.ps1 -PluginName s-hness-core, s-hness-maintenance -CanonicalRoot <canonical-root> -WhatIf
```

After approval, remove `-WhatIf` and add `-Confirm:$false`.

## Completion

Return exactly one overall status: `verified`, `failed`, or `unverified`. A verified result requires active and cached versions, the `codex plugin list` entry, plugin validation, and a retained backup path for every plugin. Tell the user to open a new thread after success.
