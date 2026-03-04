# Design Operating Model

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

## Purpose

Define how design decisions are authored, reviewed, and enforced for agent legibility.

## Rules

- Durable design decisions must live in `docs/design-docs/`.
- Every design doc must include context, options, decision, risks, and validation plan.
- Significant implementation changes require a linked design doc.
- Deprecated decisions must be explicitly marked and cross-linked to replacements.

## Verification

- Keep `docs/design-docs/index.md` updated.
- Ensure design docs link to related product specs and execution plans.
- Validate docs with `make check`.
