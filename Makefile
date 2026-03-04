SHELL := /bin/bash

.PHONY: preflight preflight-bootstrap preflight-implementation check check-docs check-plans doc-garden bootstrap

preflight:
	./scripts/preflight.sh --stage bootstrap

preflight-bootstrap:
	./scripts/preflight.sh --stage bootstrap

preflight-implementation:
	./scripts/preflight.sh --stage implementation

check: check-docs check-plans

check-docs:
	./scripts/validate-knowledge-base.sh

check-plans:
	./scripts/validate-exec-plans.sh

doc-garden:
	./scripts/doc-garden-report.sh

bootstrap:
	@echo "Usage: ./scripts/bootstrap-project.sh --name \"Project Name\" --owner \"@team\""
