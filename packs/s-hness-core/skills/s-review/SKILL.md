---
name: s-review
description: Review engineering changes for correctness, regressions, interface violations, maintainability, and operational risk. Use for read-only review; do not modify files unless the user separately requests fixes.
---

# S Review

Inspect the specification, plan, relevant changes, tests, and repository instructions. Focus on defects introduced by the reviewed work and trace findings to observable impact.

## Output

List findings first, ordered by severity. Each finding must include:

- affected file, component, or interface;
- concrete failure mode and trigger;
- user or operational impact; and
- the smallest useful remediation direction.

Then report open questions, verification gaps, and a short summary. If no findings remain, say so and identify residual risks or tests that were unavailable.

## Completion

Review is complete when material correctness and regression risks have been assessed without changing the reviewed files.
