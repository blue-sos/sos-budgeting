#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

fail_on_stale=0
if [[ "${1:-}" == "--fail-on-stale" ]]; then
  fail_on_stale=1
fi

cutoff_date() {
  if date -u -d '-90 day' +%Y-%m-%d >/dev/null 2>&1; then
    date -u -d '-90 day' +%Y-%m-%d
  else
    date -u -v-90d +%Y-%m-%d
  fi
}

cutoff="$(cutoff_date)"
stale_count=0
draft_count=0

echo "Doc garden report"
echo "Cutoff date for staleness: $cutoff"
echo

echo "Draft/deprecated documents:"
while IFS= read -r -d '' file; do
  status="$(rg '^Status:' "$file" | head -n 1 | awk '{print $2}')"
  if [[ "$status" == "draft" || "$status" == "deprecated" ]]; then
    echo "- $file (status: $status)"
    draft_count=$((draft_count + 1))
  fi
done < <(find docs policy -type f -name '*.md' -print0)

echo
echo "Stale review dates:"
while IFS= read -r -d '' file; do
  reviewed="$(rg '^Last Reviewed:' "$file" | head -n 1 | awk '{print $3}')"
  if [[ -n "$reviewed" && "$reviewed" < "$cutoff" ]]; then
    echo "- $file (last reviewed: $reviewed)"
    stale_count=$((stale_count + 1))
  fi
done < <(find docs policy -type f -name '*.md' -print0)

echo
echo "Summary: $draft_count draft/deprecated, $stale_count stale review date(s)."

if (( fail_on_stale == 1 )) && (( stale_count > 0 )); then
  exit 1
fi
