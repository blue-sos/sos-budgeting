# Architecture Enforcement Roadmap

Owner: @platform
Last Reviewed: 2026-02-20
Status: active

## Purpose

Define when and how architecture constraints move from policy text to mechanical enforcement.

## Current State

The template starts with policy-level architecture rules in `ARCHITECTURE.md` and `policy/architecture-layers.md`.

Mechanical code-level dependency checks are intentionally deferred until concrete project module paths exist.

## Trigger To Start Enforcement

Start implementation of architecture enforcement as soon as both are true:

1. Real source directories/modules for the project exist.
2. The first non-trivial feature implementation is about to begin.

## Required Enforcement Plan

Before or alongside the first major implementation milestone, create an ExecPlan milestone that covers:

1. Mapping concrete module/package paths to architecture layers in `policy/architecture-layers.md`.
2. Implementing a stack-specific architecture checker in `scripts/`.
3. Wiring the checker into `make check` and CI.
4. Defining exception handling and expiry policy in docs.

## Minimum Mechanical Bar

The first enforcement version must:

- Fail on disallowed dependency directions.
- Print remediation-oriented error messages.
- Be fast enough to run in CI on every pull request.

## Iteration Strategy

After initial rollout:

- Track false positives/negatives in plan decision logs.
- Tighten rules incrementally.
- Convert recurring exceptions into explicit policy with time bounds.
