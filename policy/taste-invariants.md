# Taste Invariants

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

## Code Shape

- Keep files focused and below locally defined size limits.
- Use explicit names for schemas and boundary types.
- Prefer deterministic helpers over implicit magic.

## Data Safety

- Validate or parse data at boundaries.
- Avoid unchecked probing of unknown structures.

## Observability

- Use structured logs.
- Emit telemetry for critical transitions.

## Testing

- Add targeted tests for new behavior.
- Prefer tests that demonstrate user-visible outcomes.
