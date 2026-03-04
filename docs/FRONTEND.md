# Frontend Guide

Owner: @frontend
Last Reviewed: 2026-02-20
Status: active

## Purpose

Provide baseline frontend requirements that agents can execute consistently.

## Requirements

- Define critical user journeys in product specs before implementation.
- Require deterministic selectors for automated UI validation.
- Add UI state snapshots/screenshots for regression-sensitive flows.
- Track performance budgets for key interactions.
- Capture accessibility expectations per view and component class.

## Agent Legibility

- Keep component boundaries explicit and predictable.
- Co-locate tests with UI modules where possible.
- Prefer clear naming over clever abstractions.

## Validation

- Add journey-level checks for critical flows.
- Include frontend reliability constraints in `docs/RELIABILITY.md`.
