#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

errors=0

fail() {
  echo "ERROR: $*" >&2
  errors=$((errors + 1))
}

required_paths=(
  "README.md"
  "AGENTS.md"
  "ARCHITECTURE.md"
  "PLANS.md"
  "docs/DESIGN.md"
  "docs/FRONTEND.md"
  "docs/PLANS.md"
  "docs/SETUP.md"
  "docs/PRODUCT_SENSE.md"
  "docs/QUALITY_SCORE.md"
  "docs/RELIABILITY.md"
  "docs/SECURITY.md"
  "docs/setup/README.md"
  "docs/setup/PREFLIGHT_STATUS.md"
  "docs/setup/EXTERNAL_TOOLING.md"
  "docs/design-docs/index.md"
  "docs/design-docs/core-beliefs.md"
  "docs/exec-plans/active/README.md"
  "docs/exec-plans/completed/README.md"
  "docs/exec-plans/tech-debt-tracker.md"
  "docs/product-specs/index.md"
  "docs/references/README.md"
  "docs/governance/index.md"
  "docs/governance/template-instantiation.md"
  "docs/governance/architecture-enforcement-roadmap.md"
  "policy/architecture-layers.md"
  "policy/taste-invariants.md"
  "policy/boundary-contracts.md"
  "setup/preflight.required-tools.txt"
  "setup/preflight.required-env.txt"
  "setup/preflight.required-human-checks.txt"
)

for path in "${required_paths[@]}"; do
  [[ -e "$path" ]] || fail "Missing required path: $path"
done

agents_lines="$(wc -l < AGENTS.md | tr -d ' ')"
if (( agents_lines > 180 )); then
  fail "AGENTS.md has $agents_lines lines; keep it concise (<= 180)."
fi

check_metadata_file() {
  local file="$1"

  rg -q '^Owner:' "$file" || fail "Missing Owner metadata in $file"
  rg -q '^Last Reviewed:' "$file" || fail "Missing Last Reviewed metadata in $file"
  rg -q '^Status:' "$file" || fail "Missing Status metadata in $file"
}

while IFS= read -r -d '' file; do
  check_metadata_file "$file"
done < <(find docs policy -type f -name '*.md' -print0)

scan_files=(README.md AGENTS.md ARCHITECTURE.md PLANS.md)
while IFS= read -r -d '' file; do
  scan_files+=("$file")
done < <(find docs policy -type f \( -name '*.md' -o -name '*.txt' \) -print0)

while IFS= read -r line; do
  file="${line%%:*}"
  rest="${line#*:}"
  lineno="${rest%%:*}"
  text="${rest#*:}"

  while IFS= read -r link_expr; do
    target="$(printf '%s\n' "$link_expr" | sed -E 's/^\[[^]]+\]\(([^)]+)\)$/\1/')"
    target="${target%% *}"
    target="${target#<}"
    target="${target%>}"

    [[ -z "$target" ]] && continue
    [[ "$target" == http://* ]] && continue
    [[ "$target" == https://* ]] && continue
    [[ "$target" == mailto:* ]] && continue
    [[ "$target" == \#* ]] && continue

    target_no_anchor="${target%%#*}"
    [[ -z "$target_no_anchor" ]] && continue

    if [[ "$target_no_anchor" == /* ]]; then
      resolved=".$target_no_anchor"
    else
      resolved="$(dirname "$file")/$target_no_anchor"
    fi

    if [[ ! -e "$resolved" ]]; then
      fail "Broken local link in $file:$lineno -> $target"
    fi
  done < <(printf '%s\n' "$text" | grep -oE '\[[^]]+\]\(([^)]+)\)' || true)
done < <(rg -n '\[[^]]+\]\(([^)]+)\)' "${scan_files[@]}")

if (( errors > 0 )); then
  echo "validate-knowledge-base: failed with $errors error(s)." >&2
  exit 1
fi

echo "validate-knowledge-base: ok"
