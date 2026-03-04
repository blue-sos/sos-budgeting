#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

# Load untracked local env file when present so preflight reflects real local setup.
if [[ -f ".env.local" ]]; then
  set -a
  # shellcheck disable=SC1091
  source ".env.local"
  set +a
fi

mode="strict"
stage="bootstrap"

usage() {
  cat <<'USAGE'
Usage: ./scripts/preflight.sh [--strict] [--local-only] [--stage <bootstrap|implementation>]

Modes:
  --strict      Require GitHub remote/auth checks (default)
  --local-only  Downgrade GitHub remote/auth checks to optional warnings

Stages:
  bootstrap       Startup/onboarding checks for repo wiring and collaboration setup (default)
  implementation  Full readiness checks before major implementation milestones
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --strict)
      mode="strict"
      shift
      ;;
    --local-only)
      mode="local-only"
      shift
      ;;
    --stage)
      if [[ $# -lt 2 ]]; then
        echo "--stage requires a value: bootstrap or implementation" >&2
        usage
        exit 1
      fi
      stage="$2"
      shift 2
      ;;
    --bootstrap)
      stage="bootstrap"
      shift
      ;;
    --implementation)
      stage="implementation"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ "$stage" != "bootstrap" && "$stage" != "implementation" ]]; then
  echo "Invalid stage '$stage'. Use bootstrap or implementation." >&2
  usage
  exit 1
fi

tools_file="setup/preflight.required-tools.txt"
env_file="setup/preflight.required-env.txt"
human_checks_file="setup/preflight.required-human-checks.txt"
status_file="docs/setup/PREFLIGHT_STATUS.md"

passes=()
warnings=()
failures=()

pf001_status="unknown"
pf002_status="unknown"
pf003_status="unknown"

add_pass() {
  passes+=("$1")
}

add_warn() {
  warnings+=("$1")
}

add_fail() {
  failures+=("$1")
}

check_cmd() {
  local cmd="$1"
  local required="$2"
  local desc="$3"
  local remediation="$4"

  if command -v "$cmd" >/dev/null 2>&1; then
    add_pass "$desc ($cmd)"
    return
  fi

  if [[ "$required" == "required" ]]; then
    add_fail "$desc missing: $cmd. $remediation"
  else
    add_warn "$desc missing: $cmd. $remediation"
  fi
}

check_env_var() {
  local var_name="$1"
  local required="$2"
  local desc="$3"
  local remediation="$4"

  if [[ -n "${!var_name:-}" ]]; then
    add_pass "$desc ($var_name)"
    return
  fi

  if [[ "$required" == "required" ]]; then
    add_fail "$desc not set: $var_name. $remediation"
  else
    add_warn "$desc not set: $var_name. $remediation"
  fi
}

load_tool_checks() {
  if [[ ! -f "$tools_file" ]]; then
    add_fail "Missing tools requirements file: $tools_file"
    return
  fi

  while IFS='|' read -r cmd required desc remediation; do
    [[ -z "${cmd// }" ]] && continue
    [[ "$cmd" =~ ^# ]] && continue

    check_cmd "$cmd" "$required" "$desc" "$remediation"
  done < "$tools_file"
}

load_env_checks() {
  if [[ ! -f "$env_file" ]]; then
    add_fail "Missing environment requirements file: $env_file"
    return
  fi

  while IFS='|' read -r var_name required desc remediation; do
    [[ -z "${var_name// }" ]] && continue
    [[ "$var_name" =~ ^# ]] && continue

    check_env_var "$var_name" "$required" "$desc" "$remediation"
  done < "$env_file"
}

check_git_state() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    add_pass "Repository is inside a git worktree"
  else
    pf001_status="fail"
    pf002_status="fail"
    add_fail "Not inside a git repository. Run: git init"
    return
  fi

  if git rev-parse --verify HEAD >/dev/null 2>&1; then
    pf001_status="pass"
    add_pass "Repository has at least one commit"
  else
    pf001_status="fail"
    add_fail "Repository has no commits yet. Create an initial commit before implementation."
  fi

  if git remote get-url origin >/dev/null 2>&1; then
    pf002_status="pass"
    add_pass "Git remote 'origin' is configured"
  else
    pf002_status="fail"
    if [[ "$mode" == "strict" ]]; then
      add_fail "Git remote 'origin' is not configured. Create/connect a GitHub repo and set origin."
    else
      add_warn "Git remote 'origin' is not configured. Configure it when ready for collaboration/CI."
    fi
  fi
}

check_gh_auth() {
  if ! command -v gh >/dev/null 2>&1; then
    pf003_status="fail"
    return
  fi

  if gh auth status >/dev/null 2>&1; then
    pf003_status="pass"
    add_pass "GitHub CLI authentication is valid"
    return
  fi

  pf003_status="fail"
  if [[ "$mode" == "strict" ]]; then
    add_fail "GitHub CLI is not authenticated. Run: gh auth login"
  else
    add_warn "GitHub CLI is not authenticated. Run: gh auth login before GitHub operations."
  fi
}

check_human_status() {
  if [[ ! -f "$human_checks_file" ]]; then
    add_fail "Missing human-check requirements file: $human_checks_file"
    return
  fi

  if [[ ! -f "$status_file" ]]; then
    add_fail "Missing status checklist: $status_file"
    return
  fi

  effective_required_for_check() {
    local check_id="$1"
    local base_required="$2"
    local effective_required="$base_required"

    if [[ "$stage" == "bootstrap" ]]; then
      case "$check_id" in
        PF-004|PF-005|PF-006)
          effective_required="optional"
          ;;
      esac
    fi

    if [[ "$mode" == "local-only" ]]; then
      case "$check_id" in
        PF-002|PF-003|PF-005)
          effective_required="optional"
          ;;
      esac
    fi

    printf '%s' "$effective_required"
  }

  while IFS='|' read -r check_id required desc remediation; do
    [[ -z "${check_id// }" ]] && continue
    [[ "$check_id" =~ ^# ]] && continue

    required="$(effective_required_for_check "$check_id" "$required")"

    case "$check_id" in
      PF-001)
        if [[ "$pf001_status" == "pass" ]]; then
          add_pass "Human check auto-verified: ${check_id} (${desc})"
        fi
        continue
        ;;
      PF-002)
        if [[ "$pf002_status" == "pass" ]]; then
          add_pass "Human check auto-verified: ${check_id} (${desc})"
        fi
        continue
        ;;
      PF-003)
        if [[ "$pf003_status" == "pass" ]]; then
          add_pass "Human check auto-verified: ${check_id} (${desc})"
        fi
        continue
        ;;
    esac

    if rg -q "^- \[x\] ${check_id}\\b" "$status_file"; then
      add_pass "Human check complete: ${check_id} (${desc})"
      continue
    fi

    if [[ "$required" == "required" ]]; then
      add_fail "Human check incomplete: ${check_id} (${desc}). ${remediation} Then mark [x] in $status_file"
    else
      add_warn "Human check incomplete: ${check_id} (${desc}). ${remediation}"
    fi
  done < "$human_checks_file"
}

print_section() {
  local title="$1"
  local array_name="$2"
  local count=0

  echo "$title"
  eval "count=\${#${array_name}[@]}"
  if (( count == 0 )); then
    echo "- none"
  else
    eval "for item in \"\${${array_name}[@]}\"; do echo \"- \$item\"; done"
  fi
  echo
}

main() {
  echo "Preflight mode: $mode"
  echo "Preflight stage: $stage"
  echo

  load_tool_checks
  load_env_checks
  check_git_state
  check_gh_auth
  check_human_status

  print_section "Passed" passes
  print_section "Warnings" warnings
  print_section "Blocking Failures" failures

  if (( ${#failures[@]} > 0 )); then
    echo "Preflight result: FAIL"
    echo "Complete the blocking items, then rerun ./scripts/preflight.sh"
    exit 1
  fi

  echo "Preflight result: PASS"
  if [[ "$stage" == "bootstrap" ]]; then
    echo "Next gate: run ./scripts/preflight.sh --stage implementation before major coding milestones."
  fi
}

main
