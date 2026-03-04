# Execution Plan: SOS Budgeting Foundation

Owner: @blue-sos
Last Reviewed: 2026-03-04
Status: active

## Objective

Stand up a production-ready project foundation for SOS Budgeting that can ingest QuickBooks and Mercury data into Google Sheets while persisting raw downloads in Firebase Firestore, with clear setup docs, enforcement checks, and milestone-based implementation scaffolding.

## Scope

- Instantiate template docs for SOS Budgeting.
- Define architecture and integration boundaries.
- Define credential/setup expectations for local and CI environments.
- Prepare initial implementation milestones and validation strategy.

## Non-Goals

- Building all connectors end-to-end in this plan.
- Finalizing budget taxonomy, forecasting models, or executive dashboard UX.
- Production deployment pipeline hardening.

## Acceptance Criteria

1. Required bootstrap artifacts exist and are linked in indexes: product spec, design doc, and active ExecPlan.
2. Repository passes `./scripts/preflight.sh --stage bootstrap` and `make check`.
3. Setup docs enumerate required integration credentials and verification flow for QuickBooks, Google Drive/Sheets, Mercury, and Firebase Firestore.
4. Implementation path is split into milestones with concrete validation gates.

## Purpose / Big Picture

This milestone creates the operating baseline for all subsequent budgeting tooling work. By standardizing docs, setup checks, and architectural boundaries now, we reduce rework when connector and transformation code begins.

## Context and Orientation

Current repository state started from a generic agent-first template. Project intent is now defined: financial ingestion and budgeting workflows centered on Google Sheets persistence and multi-system integrations.

## Plan of Work

1. Instantiate project-specific governance artifacts.
2. Define integration setup and dependency requirements.
3. Validate repository health and preflight gates.
4. Prepare Milestone 1 implementation plan for connector and sheet-write runtime modules.

## Work Breakdown

1. Bootstrap and repository wiring to `blue-sos/sos-budgeting`.
2. Product/design/plan instantiation and index updates.
3. External tooling and environment contract updates.
4. Validation run (`make check`, implementation preflight) and blocker triage.

## Concrete Steps

1. Run `./scripts/preflight.sh --stage bootstrap`; resolve blockers until pass.
2. Keep `docs/setup/PREFLIGHT_STATUS.md` accurate for verified checks.
3. Add `001-sos-budgeting` artifacts in product specs, design docs, and active execution plans.
4. Update `docs/QUALITY_SCORE.md` with initial SOS Budgeting baseline.
5. Update setup contracts (`docs/setup/EXTERNAL_TOOLING.md`, `setup/preflight.required-env.txt`) to list integration credentials.
6. Run `make check` and fix any doc/plan validation failures.
7. Run `./scripts/preflight.sh --stage implementation` and capture remaining manual blockers.
8. Before first runtime module, add architecture enforcement bootstrap step per `docs/governance/architecture-enforcement-roadmap.md`.

## Interfaces and Dependencies

- External APIs: QuickBooks Online API, Mercury API, Google Drive API, Google Sheets API, Firestore API.
- Auth dependencies: OAuth2 and API tokens as documented in setup artifacts.
- Tooling dependencies: `git`, `gh`, `make`, `rg`, optional `docker`.

## Validation and Acceptance

- `./scripts/preflight.sh --stage bootstrap` returns PASS.
- `make check` returns PASS.
- `./scripts/preflight.sh --stage implementation` is run and blockers are explicitly documented.
- Links among spec, design doc, and plan resolve correctly.

## Idempotence and Recovery

- Re-running setup commands should not duplicate docs or corrupt indexes.
- If check scripts fail, resolve one failure at a time and rerun commands to confirm.
- If integration setup details change, update setup docs and preflight env list before implementation.

## Risks And Mitigations

- Risk: Missing credentials delay implementation stage.
- Mitigation: Maintain a concrete credential checklist with local + GitHub Actions mapping.

- Risk: Template drift causes policy mismatch.
- Mitigation: Keep quality score and indexes updated on each non-trivial change.

## Progress

- [x] 2026-03-04: Bootstrap preflight passed and repository connected to target GitHub remote.
- [x] 2026-03-04: Implementation preflight blockers resolved.
- [ ] 2026-03-04: Milestone 1 connector runtime scaffolding started.

## Progress Log

- 2026-03-04: Initialized git repository, connected `origin`, created initial commit, and pushed to `main`.
- 2026-03-04: Bootstrap preflight rerun passed with no blocking failures.
- 2026-03-04: Instantiation artifacts created for SOS Budgeting.
- 2026-03-04: Added Firebase Firestore `(default)` database (`nam5`) and configured raw-download persistence environment variables.

## Surprises & Discoveries

- Template repo was copied without `.git` history, requiring manual `git init` and first commit before preflight could pass.

## Decision Log

- 2026-03-04: Use Google Sheets as persistent operational data store for initial implementation phase.
- 2026-03-04: Use Firebase Firestore as durable storage for raw connector downloads and replay metadata.
- 2026-03-04: Prioritize connectors for QuickBooks, Mercury, and Google APIs as first integration milestone; defer Shopify.

## Outcomes & Retrospective

In progress.

## Outcome

In progress.

## Follow-Up

- Define source-specific schemas and normalization contracts.
- Choose runtime entrypoint (CLI first vs scheduled worker first).
- Add architecture enforcement scripts when first real source modules are introduced.
