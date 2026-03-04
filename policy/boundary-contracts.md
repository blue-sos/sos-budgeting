# Boundary Contracts

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

## Input Boundaries

- Request handlers
- Queue consumers
- File import paths
- External API clients

Each boundary must parse and validate incoming data before domain logic uses it.

## Output Boundaries

- External API responses
- Stored events
- Inter-service messages

Each boundary must emit data in explicit, versioned shapes.

## Failure Handling

- Handle parse failures deterministically.
- Emit actionable error messages and telemetry.
