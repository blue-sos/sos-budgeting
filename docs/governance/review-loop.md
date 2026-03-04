# Review Loop

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

## Loop Definition

Use this loop for non-trivial changes:

1. Implement from execution plan.
2. Run local checks.
3. Run targeted agent review prompts.
4. Apply feedback.
5. Re-run checks.
6. Repeat until stable.

## Escalation Rule

Escalate to a human only when policy, product, or safety judgment is required.

## Recording Rule

For meaningful changes, capture key review outcomes in the active execution plan's decision log.
