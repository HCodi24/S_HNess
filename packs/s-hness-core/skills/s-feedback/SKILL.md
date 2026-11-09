---
name: s-feedback
description: Record unwanted, incorrect, or unreasonable S_HNess behavior for later work, or apply an explicitly requested focused fix to the canonical harness source. Use when feedback originates while working in any project; do not use for defects owned only by that product.
---

# S Feedback

Handle feedback about S_HNess itself without confusing the current product workspace with the harness source.

## Canonical source

Resolve the canonical harness root in this order: a root the user explicitly supplies, the `S_HNESS_ROOT` environment variable, then the default `C:\GitHub\S_HNess`. Confirm that this directory contains both `README.md` and `packs/s-hness-core/.codex-plugin/plugin.json` before writing. If it moved or cannot be accessed, stop and ask for its new root. Never treat an installed plugin directory or plugin cache as canonical source.

## Choose a mode

- Use `log` by default when the user reports unwanted behavior, an inconsistency, or an improvement to revisit later.
- Use `fix` only when the user explicitly asks to update, change, or fix the harness now.
- If intent is ambiguous, log the feedback; do not infer permission to modify harness instructions.

## Log mode

Append one concise item under `## Chờ xử lý` in `HARNESS_FEEDBACK.md` at the canonical harness root. Replace the placeholder `Chưa có mục nào.` when adding the first item. Record `Ngày feedback: YYYY-MM-DD` using the local calendar date when the feedback is written.

After adding or updating an entry, retain at most the 10 most recent feedback entries across both sections, ordered by `Ngày feedback`. Remove older entries only after preserving the ten newest entries; do not count section headings or the `Chưa có mục nào.` placeholder.

Include:

- a short title and the `Ngày feedback` field in ISO `YYYY-MM-DD` format;
- originating project path when known;
- observed behavior and expected behavior;
- a minimal reproduction or evidence when available; and
- affected skill or pack when known.

Preserve existing entries. Do not write product source, plans, tests, or general project notes into the feedback file.

## Fix mode

1. Treat the canonical harness root as the only write target and read its `AGENTS.md`, relevant skill sources, and current changes.
2. Restate the focused change, affected files, verification, and recovery boundary. A `fix` request authorizes the scoped harness-source edit, not installation, commit, push, publication, or deployment.
3. For a small, well-understood correction, edit the smallest reusable instruction or resource that owns the behavior. For broader or unresolved changes, record the item and route it through the normal discovery, specification, and planning lifecycle.
4. Add or update a matching feedback entry, then move it to `## Đã xử lý` only after the requested behavior is implemented. Preserve the entry's original `Ngày feedback`; add separate resolution details when useful instead of replacing that date. End the completed entry with a standalone `Done` line.
5. After moving the entry, retain only the 10 most recent entries across `## Chờ xử lý` and `## Đã xử lý`, removing older entries by `Ngày feedback`. Preserve section headings and the placeholder when a section is empty.
6. Run `scripts/validate-harness.ps1` and any focused checks justified by the change. Report exact evidence as `verified`, `failed`, or `unverified`.
7. If the user wants the installed plugin refreshed, follow the local plugin cachebuster and reinstall workflow only after separate authorization for writes outside the canonical harness repository. Tell the user to start a new thread after reinstall.

Do not encode a one-off preference as a universal rule unless the user asks for that scope. Preserve unrelated user changes.

## Completion

For `log`, return the absolute feedback-file path and summarize the entry. For `fix`, return changed source paths, validation evidence, feedback-entry status, and whether the installed plugin still needs refresh.
