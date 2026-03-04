# Template Instantiation

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

## Purpose

Define how this repository should be instantiated when cloned for a specific application.

## Operating Model

- Treat this repo as a default operating system for agent-driven development.
- Keep core governance and architecture constraints unless explicitly replaced.
- Convert placeholder docs into project-specific artifacts immediately.
- Continue work through execution plans and measurable acceptance criteria.

## First-Run Actions In A New Clone

1. On first interaction, run bootstrap preflight (`./scripts/preflight.sh --stage bootstrap`) automatically.
2. If blockers exist, guide the human through them one-by-one and update `docs/setup/PREFLIGHT_STATUS.md`.
3. Identify project intent from user prompts.
4. Create initial project artifacts:
   - `docs/product-specs/001-<project>-spec.md`
   - `docs/design-docs/001-<project>-architecture.md`
   - `docs/exec-plans/active/001-<project>-foundation.md`
5. Update indexes in `docs/product-specs/index.md` and `docs/design-docs/index.md`.
6. Update `docs/QUALITY_SCORE.md` with an initial domain/layer baseline for the project.
7. Before the first major coding milestone, run implementation preflight (`./scripts/preflight.sh --stage implementation`).
8. Start implementation against plan milestones.

## Interaction Expectations

- Normal chat-based prompting is sufficient.
- Do not force interview-style questionnaires.
- Ask clarifying questions only when needed to avoid incorrect assumptions.
- If setup is incomplete, provide precise setup actions and wait for confirmation.

## Non-Negotiables

- Keep repository-local docs as source of truth.
- Keep plans as living documents.
- Keep architecture boundaries and boundary validation enforced.
