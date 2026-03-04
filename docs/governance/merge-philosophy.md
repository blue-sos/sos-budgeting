# Merge Philosophy

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

## Throughput-Oriented Defaults

- Prefer short-lived pull requests.
- Avoid excessive blocking on non-critical flakes.
- Land safe increments and follow up quickly on regressions.

## Safeguards

- Keep core reliability/security checks mandatory.
- Require documented acceptance criteria for significant changes.
- Require updated plans/docs for non-trivial work.

## Why

In high-throughput agent workflows, waiting costs more than iteration when safeguards are strong.
