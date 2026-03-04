# Quality Scorecard

Owner: @platform
Last Reviewed: 2026-03-04
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
| Budget Data Ingestion & Sheets Persistence | 2 | 1 | 1 | 1 | 1 | Project direction and acceptance criteria are defined; implementation and tests are pending. |

## Layer Scores

| Layer | Structure | Boundary Safety | Policy Compliance | Notes |
| --- | --- | --- | --- | --- |
| types | 1 | 1 | 1 | Source and normalized schema contracts are planned in design docs; code not implemented yet. |
| config | 1 | 1 | 1 | Required integration settings are documented; typed runtime config is pending. |
| repo | 1 | 1 | 1 | Connector boundaries are defined for QuickBooks/Mercury/Shopify/Google APIs; clients pending. |
| service | 1 | 1 | 1 | Sync orchestration and idempotency rules are documented; implementation pending. |
| runtime | 1 | 1 | 1 | Runtime milestones and validation gates exist in active execution plan. |
| ui | 0 | 0 | 1 | No UI scope in this foundation phase; policy compliance documented. |

## Update Rule

Update this file for every non-trivial PR that changes architecture, reliability, or user-facing behavior.
