# Product Spec: SOS Budgeting Data Hub

Owner: @blue-sos
Last Reviewed: 2026-03-04
Status: draft

## Problem

School of Song needs a reliable budgeting workflow that consolidates financial data from QuickBooks and Mercury into Google Sheets, with Shopify support planned for a later milestone. Today, finance reporting is fragmented across tools and manual exports, which makes monthly budget tracking slow and error-prone.

## Users

- Finance owner at School of Song maintaining budgets and reporting.
- Operations stakeholders who need current spend and cash visibility.
- Leadership reviewing budget variance and runway signals.

## Jobs To Be Done

- Maintain budget workbooks in Google Sheets with auditable source data.
- Automatically pull recent transactions and balances from QuickBooks and Mercury.
- Reconcile source records into budget categories and reporting periods.
- Share finance outputs without requiring database or BI tooling.

## Requirements

1. The system must ingest source data from QuickBooks and Mercury via authenticated API connectors.
2. Persistent data must live in Google Sheets (and supporting files in Google Drive) rather than an internal database.
3. Each sync run must be idempotent for a defined time window, avoiding duplicate records on rerun.
4. Source records must be written to raw tabs before transformation, preserving traceability to original system IDs.
5. Budget model tabs must derive from raw tabs with deterministic transformations and documented formulas/mappings.
6. Sync jobs must emit run logs (start/end time, source, row counts, error summary) for operational visibility.

## Non-Goals

- Replacing QuickBooks as accounting source of truth.
- Building a custom ledger or long-term warehouse outside Google Sheets.
- Designing final budget taxonomy and approval workflows in this phase.
- Delivering Shopify integration in the foundation milestone.

## Acceptance Criteria

1. A single command can run an end-to-end sync for a date window and populate raw tabs for QuickBooks and Mercury in a runtime-selected or runtime-created Google Sheet.
2. Re-running the same window does not create duplicate rows when keyed by source system record IDs.
3. Each sync run writes structured run metadata (run ID, source, status, counts, duration) to a dedicated sheet tab.
4. Generated workbooks include budget-ready derived tabs with documented input dependencies from raw tabs.
5. Setup docs list required credentials, environment variables, and verification steps for all integrations.

## Risks

- API rate limits and pagination drift across providers may cause incomplete windows.
- OAuth token lifecycle complexity can create brittle manual setup.
- Google Sheets size/performance limits may require archival strategy as data grows.
- Schema changes in source APIs can silently break transformations if not validated.

## Linked Artifacts

- Design doc: [001-sos-budgeting-architecture](../design-docs/001-sos-budgeting-architecture.md)
- Execution plan: [001-sos-budgeting-foundation](../exec-plans/active/001-sos-budgeting-foundation.md)
