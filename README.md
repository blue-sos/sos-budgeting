# Agent-First Repository Template

This template is designed for high-throughput, agent-driven software development.

The goal is to keep humans focused on intent, constraints, and feedback loops while agents implement, test, document, and iterate.

## Core Principles

- Keep repository knowledge as the system of record.
- Keep `AGENTS.md` short; use it as a map, not a manual.
- Enforce architecture and quality through mechanical checks.
- Treat plans and decision logs as first-class, versioned artifacts.
- Continuously run doc and code gardening to prevent drift.

## Repository Layout

```text
.
├── AGENTS.md
├── ARCHITECTURE.md
├── docs/
│   ├── design-docs/
│   ├── exec-plans/
│   ├── generated/
│   ├── governance/
│   ├── product-specs/
│   ├── references/
│   ├── DESIGN.md
│   ├── FRONTEND.md
│   ├── PLANS.md
│   ├── PRODUCT_SENSE.md
│   ├── QUALITY_SCORE.md
│   ├── RELIABILITY.md
│   ├── SECURITY.md
│   └── setup/
├── policy/
├── setup/
├── scripts/
└── .github/workflows/
```

## Quick Start

1. Clone this template into a new repository.

2. Start Codex in the cloned repo and give a kickoff prompt like:

```text
This repo is a starter template. First run preflight bootstrap and guide me through blockers step-by-step.
Once bootstrap passes, instantiate it for "<PROJECT_NAME>", create the first product spec/design doc/foundation ExecPlan.
Before Milestone 1 implementation, run preflight implementation and then start coding.
Follow AGENTS.md, ARCHITECTURE.md, docs/SETUP.md, and docs/PLANS.md.
```

3. If you prefer direct scaffolding, optionally initialize project docs via script:

```bash
./scripts/bootstrap-project.sh --name "Your Project Name" --owner "@your-team"
```

4. Validate template health:

```bash
make check
```

5. Start work through plans:

- Create a plan in `docs/exec-plans/active/` from `docs/exec-plans/templates/execution-plan-template.md`.
- Move completed plans to `docs/exec-plans/completed/` with outcomes and decision logs.

## Enforcement

- `scripts/preflight.sh`: validates toolchain, Git/GitHub baseline, human setup checklist, and readiness gates.
- `scripts/preflight.sh --stage bootstrap`: onboarding gate for repo wiring and collaboration setup.
- `scripts/preflight.sh --stage implementation`: full gate before major implementation milestones.
- `scripts/validate-knowledge-base.sh`: validates structure, metadata, and cross-links.
- `scripts/validate-exec-plans.sh`: validates active/completed plan requirements.
- `scripts/doc-garden-report.sh`: finds maintenance opportunities for recurring cleanup.

These are wired into CI in `.github/workflows/`.

## How To Adapt For Any Stack

- Keep this structure and governance model.
- Add stack-specific references in `docs/references/`.
- Add stack-specific mechanical checks in `scripts/` and CI.
- Keep constraints in `policy/` and enforce them with tests/lints.

## License

Choose the license that matches your use case and add it in `LICENSE`.
