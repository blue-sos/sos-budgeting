# Execution Plans Standard (ExecPlans)

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

This document defines how to write and execute long-running implementation plans.

## When To Use An ExecPlan

Use an ExecPlan for:

- multi-hour implementation tasks
- cross-domain changes
- risky refactors
- changes with significant unknowns

For small, low-risk edits, a lightweight plan is acceptable.

## Non-Negotiable Requirements

Every ExecPlan must be:

- self-contained for a novice reader
- living and continuously updated while work progresses
- outcome-focused with demonstrable behavior
- explicit about assumptions, commands, and expected outputs

Do not rely on prior chat context or external docs.

Before starting milestone implementation in a new cloned repository, implementation preflight must pass (`./scripts/preflight.sh --stage implementation`) or blockers must be explicitly waived by a human.

## Required Sections

Every ExecPlan must include all sections below:

- `Purpose / Big Picture`
- `Progress` (checkboxes with timestamps)
- `Surprises & Discoveries`
- `Decision Log`
- `Outcomes & Retrospective`
- `Context and Orientation`
- `Plan of Work`
- `Concrete Steps`
- `Validation and Acceptance`
- `Idempotence and Recovery`
- `Artifacts and Notes`
- `Interfaces and Dependencies`

## Authoring Guidance

- Define jargon immediately in plain language.
- Name files by repository-relative paths.
- Name modules/functions/types precisely.
- Describe commands with working directory and expected outcomes.
- Resolve ambiguity in the plan instead of deferring decisions.
- Prefer additive, testable increments.

## Validation Standard

An ExecPlan is valid only if a novice can follow it to produce working behavior.

Acceptance language must describe observable outcomes (for example: endpoint response, UI behavior, test pass/fail transitions).

## Milestone Guidance

Milestones should read as a narrative: goal, work, result, proof.

Each milestone must be independently verifiable and incrementally advance the overall objective.

If a plan introduces the first real project source modules, include an explicit milestone for architecture enforcement bootstrap (layer mapping + checker + CI integration) per `docs/governance/architecture-enforcement-roadmap.md`.

## Plan Lifecycle

1. Create in `docs/exec-plans/active/` from template.
2. Keep all required sections current.
3. Record decisions and discoveries as they happen.
4. On completion, move plan to `docs/exec-plans/completed/`.
5. Add unresolved follow-up items to `docs/exec-plans/tech-debt-tracker.md`.

## Template

Start from `docs/exec-plans/templates/execution-plan-template.md`.
