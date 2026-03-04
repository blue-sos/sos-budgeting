# Reliability Contract

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

## Purpose

Define non-functional reliability expectations as enforceable constraints.

## Baseline Requirements

- Each critical journey has an explicit latency and error budget.
- Startup and shutdown paths are measured and bounded.
- Timeouts, retries, and circuit-breaker behavior are documented.
- Incident-prone areas have targeted regression checks.

## Observability Requirements

- Structured logs with stable field names.
- Metrics for latency, errors, and saturation.
- Traces for critical cross-service and UI journeys.

## Validation

- Reliability checks run in CI for critical paths.
- Regressions produce actionable failure messages.
- Any temporary exceptions include expiry dates.
