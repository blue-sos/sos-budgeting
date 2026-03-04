# Design Doc: SOS Budgeting Foundation Architecture

Owner: @blue-sos
Last Reviewed: 2026-03-04
Status: draft

## Context

We need a project foundation that integrates QuickBooks, Mercury, Google Drive, Google Sheets, and Firebase Firestore. Google Sheets is the referenceable budgeting surface, while Firestore stores raw-download persistence for replay and audit trails. Shopify is deferred to a later milestone.

## Scope

In scope:

- Connector interfaces and configuration model for QuickBooks, Mercury, Google APIs, and Firestore.
- A sync workflow that writes raw source data and run metadata into Google Sheets.
- A raw-download persistence path in Firestore for source payload durability and replay.
- Deterministic transformation boundaries from raw tabs to budget-facing tabs.
- Setup and governance docs for credentials, preflight checks, and implementation milestones.

Out of scope:

- Advanced forecasting models and scenario planning.
- Payroll-specific accounting logic.
- Full production deployment automation.
- Shopify connector implementation in the foundation milestone.

## Constraints

- Google Sheets remains the persistence layer for referenceable budgeting outputs.
- Firebase Firestore persists raw source downloads and sync manifests.
- Integrations must be auditable and idempotent by source record ID and sync window.
- Sensitive credentials cannot be stored in-repo; setup must rely on local env and GitHub secrets.
- Architecture must follow the template layer direction and boundary validation policy.

## Options Considered

1. Sheets-first architecture with connector-driven sync jobs.
2. Database-first architecture with Sheets as reporting/export layer.
3. Hybrid architecture with data warehouse staging and periodic Sheets publish.

## Decision

Choose option 1 (Sheets-first) with Firestore sidecar persistence for raw downloads.

Rationale:

- Matches product constraint that persistent operational data should live in Google Sheets.
- Adds reliable replay/audit storage for raw connector payloads without making Firestore the reporting surface.
- Minimizes infrastructure burden during early iteration.
- Keeps finance workflows transparent to non-engineering users.

## Architecture Impact

Planned module mapping to layer model:

- `types`: source schemas, normalized row contracts, run metadata contracts.
- `config`: environment schema, integration toggles, workbook naming/location rules, and Firestore collection paths.
- `repo`: provider clients for QuickBooks, Mercury, Google Drive, Google Sheets, and Firestore.
- `service`: orchestration for sync windows, deduplication, transforms, and reconciliation rules.
- `runtime`: scheduled/manual sync commands, backfill commands, status reporting.
- `ui`: optional future operator dashboard or CLI output formatting.

Boundary approach:

- Validate every API response against explicit schemas before writing to sheets.
- Persist raw source payloads to Firestore before sheet transformation steps.
- Preserve raw records in source-specific tabs and write transformed outputs separately.
- Track run checkpoints and error summaries in a run-log tab.

## Risks And Mitigations

- Risk: Sheets row limits/performance degradation.
- Mitigation: partition by period, archive historical tabs, and cap sync window size.

- Risk: OAuth token failures interrupt scheduled sync.
- Mitigation: add connection verification command and pre-run auth checks.

- Risk: Firestore document growth or unbounded payload size.
- Mitigation: define payload size limits, prune/archive policy, and normalized metadata fields.

- Risk: Source API shape changes create silent data corruption.
- Mitigation: schema validation with fail-fast logging and run status marking.

## Validation Plan

- Unit tests for schema validation, deduplication, and transform mapping.
- Integration smoke tests per connector with mocked API responses.
- Integration smoke tests for Firestore raw-download writes on each connector run.
- Manual acceptance check: run sync twice for same window and verify no duplicate source IDs.
- Preflight implementation gate must pass before major coding milestone.

## Linked Artifacts

- Product spec: [001-sos-budgeting-spec](../product-specs/001-sos-budgeting-spec.md)
- Execution plan: [001-sos-budgeting-foundation](../exec-plans/active/001-sos-budgeting-foundation.md)
- Pull requests: n/a
