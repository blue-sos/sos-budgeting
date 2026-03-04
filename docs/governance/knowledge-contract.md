# Knowledge Contract

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

## Objective

Keep repository knowledge complete enough that an agent can continue work with only repository context.

## Rules

- Durable decisions must be checked into the repo.
- External discussions must be translated into markdown artifacts.
- Every major behavior change must update at least one of:
  - Product spec
  - Design doc
  - Execution plan
  - Quality score
- Docs must include owner, review date, and status.

## Mechanical Enforcement

- Validate required docs and metadata via CI.
- Validate link integrity and index coverage.
- Run recurring doc-gardening scans.
