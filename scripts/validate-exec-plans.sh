#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

errors=0

fail() {
  echo "ERROR: $*" >&2
  errors=$((errors + 1))
}

required_sections_active=(
  "## Objective"
  "## Scope"
  "## Acceptance Criteria"
  "## Progress Log"
  "## Decision Log"
)

required_sections_completed=(
  "## Objective"
  "## Acceptance Criteria"
  "## Decision Log"
  "## Outcome"
  "## Follow-Up"
)

check_metadata() {
  local file="$1"

  rg -q '^Owner:' "$file" || fail "Missing Owner metadata in $file"
  rg -q '^Last Reviewed:' "$file" || fail "Missing Last Reviewed metadata in $file"
  rg -q '^Status:' "$file" || fail "Missing Status metadata in $file"
}

check_sections() {
  local file="$1"
  shift
  local missing=0

  for section in "$@"; do
    if ! rg -q "^${section}$" "$file"; then
      fail "Missing section '${section}' in $file"
      missing=1
    fi
  done

  return "$missing"
}

check_plan_filename() {
  local file="$1"
  local base
  base="$(basename "$file")"

  if [[ ! "$base" =~ ^[0-9]{3}-[a-z0-9-]+\.md$ ]]; then
    fail "Invalid plan filename '$base'. Expected NNN-kebab-title.md"
  fi
}

while IFS= read -r -d '' file; do
  [[ "$(basename "$file")" == "README.md" ]] && continue

  check_plan_filename "$file"
  check_metadata "$file"
  check_sections "$file" "${required_sections_active[@]}" || true
done < <(find docs/exec-plans/active -maxdepth 1 -type f -name '*.md' -print0)

while IFS= read -r -d '' file; do
  [[ "$(basename "$file")" == "README.md" ]] && continue

  check_plan_filename "$file"
  check_metadata "$file"
  check_sections "$file" "${required_sections_completed[@]}" || true
done < <(find docs/exec-plans/completed -maxdepth 1 -type f -name '*.md' -print0)

if (( errors > 0 )); then
  echo "validate-exec-plans: failed with $errors error(s)." >&2
  exit 1
fi

echo "validate-exec-plans: ok"
