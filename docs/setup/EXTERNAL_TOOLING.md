# External Tooling Notes

Owner: @platform
Last Reviewed: 2026-03-04
Status: active

This file documents SOS Budgeting external integrations and setup expectations.

## MCP Servers

No MCP servers are mandatory for the foundation milestone.

Optional MCP servers:

- Name: GitHub MCP
- Purpose: PR/review automation from Codex when implementation starts
- Auth method: GitHub app/token configured in Codex
- Endpoint/socket: Managed by Codex MCP settings
- Verification command or action: list repositories through MCP tool call from Codex

## Credentials

Required credentials for integration milestones:

- Local untracked file: `.env.local` in repository root for local development secrets.
- Local environment variable: `GOOGLE_SERVICE_ACCOUNT_EMAIL`
- Local environment variable: `GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY`
- Local environment variable: `GOOGLE_DRIVE_ROOT_FOLDER_ID`
- Local environment variable: `FIREBASE_PROJECT_ID`
- Local environment variable: `FIRESTORE_DATABASE_ID`
- Local environment variable: `FIRESTORE_RAW_DOWNLOADS_COLLECTION`
- Local environment variable: `QUICKBOOKS_CLIENT_ID`
- Local environment variable: `QUICKBOOKS_CLIENT_SECRET`
- Local environment variable: `QUICKBOOKS_REALM_ID`
- Local environment variable: `QUICKBOOKS_REFRESH_TOKEN`
- Local environment variable: `MERCURY_API_TOKEN`
- Shopify credentials deferred until Shopify integration milestone.

GitHub Actions secrets/variables:

- Secret: `GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY`
- Secret: `QUICKBOOKS_CLIENT_SECRET`
- Secret: `QUICKBOOKS_REFRESH_TOKEN`
- Secret: `MERCURY_API_TOKEN`
- Variable: `GOOGLE_SERVICE_ACCOUNT_EMAIL`
- Variable: `GOOGLE_DRIVE_ROOT_FOLDER_ID`
- Variable: `FIREBASE_PROJECT_ID`
- Variable: `FIRESTORE_DATABASE_ID`
- Variable: `FIRESTORE_RAW_DOWNLOADS_COLLECTION`
- Variable: `QUICKBOOKS_CLIENT_ID`
- Variable: `QUICKBOOKS_REALM_ID`

Do not store secret values in this repository.
Do store local-only secrets in `.env.local` (ignored by git) and load from shell profile.

## External Services

Service access checks:

- Google Cloud project with Sheets/Drive APIs enabled
  - Verify: run `gcloud auth list` and read/write a test sheet via service account.
- Firebase Firestore database for raw-download persistence
  - Resource: `projects/sos-budgeting/databases/(default)` (location: `nam5`)
  - Write path: collection `raw_downloads` (configurable via env var)
  - Verify: write/read/delete a test document in `raw_downloads`.
- QuickBooks Online app with OAuth credentials
  - Verify: call company info endpoint with active token and confirm `realmId` matches config.
- Mercury API token with account read scopes
  - Verify: call accounts endpoint and confirm account list returns.
- Shopify integration (deferred)
  - Verify later: configure Admin API app and call shop endpoint when Shopify milestone starts.

Primary data location policy:

- Referenceable budgeting data is kept in Google Sheets workbooks in the project Drive folder.
- Workbooks are selected or created by runtime logic; no static spreadsheet ID is required at setup time.
- Raw connector downloads and replay manifests are kept in Firebase Firestore (`raw_downloads`).
- Source systems remain systems of record; sheet tabs store synced snapshots and derived budget views.
