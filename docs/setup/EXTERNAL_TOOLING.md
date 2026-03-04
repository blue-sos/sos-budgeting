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

- Local environment variable: `GOOGLE_SERVICE_ACCOUNT_EMAIL`
- Local environment variable: `GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY`
- Local environment variable: `GOOGLE_DRIVE_ROOT_FOLDER_ID`
- Local environment variable: `QUICKBOOKS_CLIENT_ID`
- Local environment variable: `QUICKBOOKS_CLIENT_SECRET`
- Local environment variable: `QUICKBOOKS_REALM_ID`
- Local environment variable: `QUICKBOOKS_REFRESH_TOKEN`
- Local environment variable: `MERCURY_API_TOKEN`
- Local environment variable: `SHOPIFY_STORE_DOMAIN`
- Local environment variable: `SHOPIFY_ADMIN_ACCESS_TOKEN`

GitHub Actions secrets/variables:

- Secret: `GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY`
- Secret: `QUICKBOOKS_CLIENT_SECRET`
- Secret: `QUICKBOOKS_REFRESH_TOKEN`
- Secret: `MERCURY_API_TOKEN`
- Secret: `SHOPIFY_ADMIN_ACCESS_TOKEN`
- Variable: `GOOGLE_SERVICE_ACCOUNT_EMAIL`
- Variable: `GOOGLE_DRIVE_ROOT_FOLDER_ID`
- Variable: `QUICKBOOKS_CLIENT_ID`
- Variable: `QUICKBOOKS_REALM_ID`
- Variable: `SHOPIFY_STORE_DOMAIN`

Do not store secret values in this repository.

## External Services

Service access checks:

- Google Cloud project with Sheets/Drive APIs enabled
  - Verify: run `gcloud auth list` and read/write a test sheet via service account.
- QuickBooks Online app with OAuth credentials
  - Verify: call company info endpoint with active token and confirm `realmId` matches config.
- Mercury API token with account read scopes
  - Verify: call accounts endpoint and confirm account list returns.
- Shopify Admin API app installed on School of Song store
  - Verify: call shop endpoint and confirm store metadata returns.

Primary data location policy:

- Persistent operational data is kept in Google Sheets workbooks in the project Drive folder.
- Workbooks are selected or created by runtime logic; no static spreadsheet ID is required at setup time.
- Source systems remain systems of record; sheet tabs store synced snapshots and derived budget views.
