# Project Setup Gate

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

This document defines the required setup steps before implementation starts in a new cloned repository.

## Why

Agent-driven implementation is only reliable when required external tooling and credentials are available.

Use preflight to ensure humans and agents share the same operational baseline.

## Run Preflight

In normal use, the agent should run this for you at startup and guide you through failures.

Startup/onboarding gate (default stage):

Manual command from repository root:

```bash
./scripts/preflight.sh --stage bootstrap
```

Full implementation gate (run before major coding milestones):

```bash
./scripts/preflight.sh --stage implementation
```

For local-only prototyping without GitHub requirements:

```bash
./scripts/preflight.sh --local-only
```

## Inputs Preflight Uses

- `setup/preflight.required-tools.txt`
- `setup/preflight.required-env.txt`
- `setup/preflight.required-human-checks.txt`
- `docs/setup/PREFLIGHT_STATUS.md`

## Rules

- Do not begin major implementation until preflight passes.
- If preflight fails, complete the listed human actions first (guided by the agent).
- Auto-verifiable checks (git initialized, origin configured, gh auth) are evaluated by preflight and are not blocked by unchecked status boxes.
- `PF-004`, `PF-005`, and `PF-006` are warnings in bootstrap stage but blocking in implementation stage.
- If a requirement is not relevant for a project, downgrade it from `required` to `optional` in setup config files and document rationale.
