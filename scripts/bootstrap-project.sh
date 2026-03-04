#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

name=""
owner="@platform"
slug=""

usage() {
  echo "Usage: $0 --name \"Project Name\" [--owner \"@team\"] [--slug project-name]"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --name)
      name="$2"
      shift 2
      ;;
    --owner)
      owner="$2"
      shift 2
      ;;
    --slug)
      slug="$2"
      shift 2
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

if [[ -z "$name" ]]; then
  echo "--name is required" >&2
  usage
  exit 1
fi

if [[ -z "$slug" ]]; then
  slug="$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-' | sed 's/^-//; s/-$//')"
fi

date_utc="$(date -u +%Y-%m-%d)"

render_template() {
  local source_file="$1"
  local target_file="$2"

  sed \
    -e "s|{{PROJECT_NAME}}|$name|g" \
    -e "s|{{TITLE}}|$name|g" \
    -e "s|{{PROJECT_SLUG}}|$slug|g" \
    -e "s|{{OWNER}}|$owner|g" \
    -e "s|{{DATE}}|$date_utc|g" \
    "$source_file" > "$target_file"
}

spec_file="docs/product-specs/001-${slug}-spec.md"
design_file="docs/design-docs/001-${slug}-architecture.md"
plan_file="docs/exec-plans/active/001-${slug}-foundation.md"

render_template "docs/product-specs/template-product-spec.md" "$spec_file"
render_template "docs/design-docs/template-design-doc.md" "$design_file"
render_template "docs/exec-plans/templates/execution-plan-template.md" "$plan_file"

if ! rg -q "001-${slug}-spec.md" docs/product-specs/index.md; then
  echo "| [001-${slug}-spec](./001-${slug}-spec.md) | draft | ${owner} | n/a | ${plan_file#docs/} | ${date_utc} |" >> docs/product-specs/index.md
fi

if ! rg -q "001-${slug}-architecture.md" docs/design-docs/index.md; then
  echo "| [001-${slug}-architecture](./001-${slug}-architecture.md) | draft | ${owner} | ${spec_file#docs/} | ${plan_file#docs/} | ${date_utc} |" >> docs/design-docs/index.md
fi

echo "Created:"
echo "- $spec_file"
echo "- $design_file"
echo "- $plan_file"
echo
echo "Next steps:"
echo "1. Run: ./scripts/preflight.sh --stage bootstrap"
echo "2. Fill product requirements and acceptance criteria in $spec_file"
echo "3. Map concrete module/package names in $design_file"
echo "4. Flesh out milestones and validation in $plan_file"
echo "5. Before major coding milestones, run: ./scripts/preflight.sh --stage implementation"
echo "6. Run: make check"
