# Security Contract

Owner: @security
Last Reviewed: 2026-02-20
Status: active

## Purpose

Make secure defaults explicit and auditable by agents.

## Baseline Requirements

- Validate and sanitize all external inputs.
- Apply least-privilege access for services and credentials.
- Avoid hardcoded secrets and sensitive material in source control.
- Document authn/authz boundaries and data handling rules.
- Define dependency update and vulnerability response process.

## Validation

- Security checks are part of CI.
- Policy exceptions are time-bound and documented.
- Security-impacting changes require linked design notes.
