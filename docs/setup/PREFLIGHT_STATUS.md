# Preflight Status

Owner: @platform
Last Reviewed: 2026-03-04
Status: active

Mark each item as complete (`[x]`) when done.

`PF-001` through `PF-003` are auto-verified by `./scripts/preflight.sh` and do not require manual checkbox updates to pass.

`PF-004` and `PF-005` are advisory during `--stage bootstrap` and blocking during `--stage implementation`.

- [x] PF-001 Repository is initialized with git and has at least one commit. [required]
- [x] PF-002 GitHub repository is created and configured as `origin`. [required]
- [x] PF-003 GitHub CLI auth (`gh auth status`) works for this machine/user. [required]
- [ ] PF-004 Required local secrets/credentials are available for development commands. [required]
- [ ] PF-005 Required GitHub Actions secrets/variables are configured. [required]
- [ ] PF-006 MCP servers required by this project are configured and reachable in Codex. [optional]
- [ ] PF-007 Local observability/dev stack dependencies are installed (if used). [optional]
