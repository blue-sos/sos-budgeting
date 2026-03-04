# Quality Scorecard

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

## Scoring Model

Score each domain and architecture layer from 0 to 5:

- 0: missing / unknown
- 1: fragile
- 2: partial
- 3: acceptable
- 4: strong
- 5: exemplary

## Domain Scores

| Domain | Product Correctness | Test Coverage | Reliability | Observability | Security | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| Core Domain A | 0 | 0 | 0 | 0 | 0 | Initialize during bootstrap |

## Layer Scores

| Layer | Structure | Boundary Safety | Policy Compliance | Notes |
| --- | --- | --- | --- | --- |
| types | 0 | 0 | 0 | Initialize during bootstrap |
| config | 0 | 0 | 0 | Initialize during bootstrap |
| repo | 0 | 0 | 0 | Initialize during bootstrap |
| service | 0 | 0 | 0 | Initialize during bootstrap |
| runtime | 0 | 0 | 0 | Initialize during bootstrap |
| ui | 0 | 0 | 0 | Initialize during bootstrap |

## Update Rule

Update this file for every non-trivial PR that changes architecture, reliability, or user-facing behavior.
