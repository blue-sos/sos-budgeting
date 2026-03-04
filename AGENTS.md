# AGENTS

This repository is designed for agent-first development.

Use this file as a map. Do not treat it as the full source of truth.

## Operating Rules

- Humans provide intent, constraints, and acceptance criteria.
- Agents implement code, tests, docs, and tooling.
- Repository-local artifacts are the source of truth.
- Prefer mechanical enforcement over subjective review.
- Keep pull requests small and fast; follow up quickly when needed.

## Template Instantiation Mode

This repository is a default starter template.

When this template is cloned for a new project, treat existing docs and policies as baseline scaffolding that must be adapted to the new app.

- Keep architectural and governance invariants unless explicitly changed.
- Replace placeholders and generic examples with project-specific content early.
- Use normal conversational prompts; do not require an interview-style flow.
- Ask questions only when blocked by missing critical requirements.

## Conversation-First Preflight

In a newly cloned repository, start by running preflight in the first working response:

```bash
./scripts/preflight.sh --stage bootstrap
```

Use `./scripts/preflight.sh --local-only` only if the human explicitly requests local-only startup.

If preflight reports blocking failures:

- Pause implementation work.
- Guide the human through blockers one at a time with exact actions.
- Re-run preflight after each completed step.
- Update `docs/setup/PREFLIGHT_STATUS.md` when checks are verified.
- Resume implementation only after preflight passes or the human explicitly waives a blocker.

Before major implementation milestones, run:

```bash
./scripts/preflight.sh --stage implementation
```

## Read This In Order

1. `README.md` for workflow and commands.
2. `ARCHITECTURE.md` for system boundaries and dependency rules.
3. `docs/SETUP.md` and `docs/setup/PREFLIGHT_STATUS.md` for setup readiness.
4. `docs/PRODUCT_SENSE.md` for product goals and tradeoffs.
5. `docs/QUALITY_SCORE.md` for current quality baselines and gaps.
6. `docs/PLANS.md` for planning and execution process.
7. `docs/governance/template-instantiation.md` for clone-and-chat startup behavior.

## Knowledge Base

The knowledge base lives under `docs/` and is partitioned by concern.

- `docs/product-specs/`: user problems, requirements, and acceptance criteria.
- `docs/design-docs/`: architecture/design decisions and tradeoffs.
- `docs/exec-plans/`: active plans, completed plans, and tech debt.
- `docs/references/`: stack/tool references optimized for agent retrieval.
- `docs/generated/`: generated artifacts (schemas, API snapshots, etc).
- `docs/governance/`: operating model, merge philosophy, and golden principles.

## Planning Requirements

Before major implementation:

1. Create or update a product spec.
2. Create or update a design doc.
3. Create an execution plan in `docs/exec-plans/active/`.
4. Define measurable acceptance criteria.
5. Add or update quality scores for touched areas.

For a newly cloned repo, first complete preflight-guided setup, then instantiate:

1. `docs/product-specs/001-<project>-spec.md`
2. `docs/design-docs/001-<project>-architecture.md`
3. `docs/exec-plans/active/001-<project>-foundation.md`

Then continue implementation in iterative milestones.

## ExecPlans

When writing complex features or significant refactors, use an ExecPlan from design through implementation.

- Canonical standard: `docs/PLANS.md`
- Alias path for tooling compatibility: `.agent/PLANS.md`

## Architecture Invariants

- Enforce dependency direction by layer.
- Validate data at system boundaries.
- Keep cross-cutting concerns behind explicit provider interfaces.
- Keep modules legible: small files, clear names, predictable structure.
- Encode reliability, security, and observability requirements as checks.

When a cloned project starts adding real source modules, convert architecture policy into mechanical checks using the roadmap in `docs/governance/architecture-enforcement-roadmap.md`.

See `ARCHITECTURE.md` and `policy/` for details.

## Definition Of Done

A change is complete when all are true:

- Acceptance criteria are met.
- Tests and lints pass.
- Docs and plans are updated.
- Quality score impact is recorded.
- Observability and reliability implications are addressed.

## Review Loop

Use iterative self-review and agent-to-agent review before human escalation:

1. Implement.
2. Run local checks.
3. Run targeted review prompts.
4. Address feedback.
5. Repeat until stable.

Escalate only when judgment or policy decisions are required.

## Documentation Hygiene

- Every durable decision belongs in repo docs.
- Do not rely on chat logs or external docs as canonical.
- Update `Last Reviewed` and `Status` fields when touching docs.
- Run `make check` before opening a pull request.

## Anti-Patterns

- Large, monolithic instruction files.
- Undocumented architecture exceptions.
- Unvalidated boundary data.
- One-off helpers when shared utilities should exist.
- Silent drift between docs and code.
