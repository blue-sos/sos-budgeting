# Architecture Map

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

This file defines the default architecture contract for new projects created from this template.

## Bird's-Eye View

Use this section to explain the core problem space in 3-6 sentences for new contributors and agents.

Describe what the system does, the primary data flow, and the highest-risk constraints.

Keep this section stable and high-level.

## Codemap

Treat this as a map, not an implementation atlas.

Answer two questions:

- Where is the thing that does X?
- What does the thing I am looking at do in the larger system?

When adapting to a concrete project, name important modules and types by symbol/path. Prefer stable names over deep links so this map stays useful over time.

## Layer Model

Default domain layers (from inner to outer):

1. `types`: core domain types and schema contracts.
2. `config`: deterministic configuration and feature gates.
3. `repo`: persistence and external state access.
4. `service`: business logic and orchestration.
5. `runtime`: runtime workflows/jobs/controllers.
6. `ui`: presentation interfaces.

Cross-cutting concerns must flow through explicit `providers` interfaces (auth, telemetry, connectors, flags).

## Dependency Direction

Allowed direction is forward only within a domain:

- `types -> config -> repo -> service -> runtime -> ui`
- `providers -> service`
- `utils -> providers`

Disallowed:

- Reverse dependencies (for example, `service -> repo` is allowed, `repo -> service` is not).
- Sideways imports between domains unless via public interfaces.
- Direct use of infra clients inside `ui`.

## Boundary Contracts

- Parse/validate all untrusted input at boundaries.
- Prefer typed SDKs or explicit schemas over inferred shapes.
- Emit structured logs and traces at domain boundaries.
- Capture reliability budgets per critical flow.

## Cross-Cutting Concerns

- Security and authn/authz: routed through provider interfaces.
- Telemetry and observability: standardized at boundary points.
- Feature flags and runtime configuration: isolated in config/providers.
- Performance constraints: codified as testable budgets.

## Enforcement Strategy

Enforce architecture via:

- Static dependency checks.
- Structural tests.
- Custom lint rules with remediation-oriented error text.
- CI gates for policy compliance.

Scaffold these checks in `scripts/` and encode invariant details in `policy/`.

## Project-Specific Adaptation

For each new project:

1. Map concrete package/module names to this layer model.
2. Document allowed edges in `policy/architecture-layers.md`.
3. Add stack-specific enforcement scripts.
4. Record exceptions in a design doc with expiry dates.
