#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHARTS_DIR="$ROOT_DIR/charts"
OUTPUT_DIR="$ROOT_DIR"
INDEX_FILE="$OUTPUT_DIR/index.yaml"

usage() {
  echo "Usage: $0 <chart-name> [base-url]" >&2
  echo "  <chart-name>  Required. Name of the chart directory under charts/." >&2
  echo "  [base-url]    Optional. Repo base URL for index entries (defaults to https://woco-io.github.io/helm-charts)." >&2
  exit 1
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
  usage
fi

CHART_NAME="$1"
CHART_DIR="$CHARTS_DIR/$CHART_NAME"

BASE_URL="${2:-https://woco-io.github.io/helm-charts}"
BASE_URL="${BASE_URL%/}"

if ! command -v helm >/dev/null 2>&1; then
  echo "helm is required but not installed or not in PATH." >&2
  exit 1
fi

if [[ ! -d "$CHART_DIR" || ! -f "$CHART_DIR/Chart.yaml" ]]; then
  echo "Chart not found or missing Chart.yaml: $CHART_NAME" >&2
  exit 1
fi

LINT_VALUES_FILE=""
if [[ -f "$CHART_DIR/values.lint.yaml" ]]; then
  LINT_VALUES_FILE="$CHART_DIR/values.lint.yaml"
elif [[ -f "$CHART_DIR/ci/values.lint.yaml" ]]; then
  LINT_VALUES_FILE="$CHART_DIR/ci/values.lint.yaml"
fi

echo "Using BASE_URL=${BASE_URL}"
echo "Processing chart ${CHART_NAME}..."

echo "Linting chart ${CHART_NAME}..."
if [[ -n "$LINT_VALUES_FILE" ]]; then
  echo "Using lint values file: $LINT_VALUES_FILE"
  helm lint "$CHART_DIR" --values "$LINT_VALUES_FILE"
else
  helm lint "$CHART_DIR"
fi

echo "Packaging chart ${CHART_NAME}..."
helm package "$CHART_DIR" --destination "$OUTPUT_DIR"

MERGE_ARGS=()
TMP_INDEX=""
if [[ -f "$INDEX_FILE" ]]; then
  TMP_INDEX="$(mktemp)"
  cp "$INDEX_FILE" "$TMP_INDEX"
  MERGE_ARGS=(--merge "$TMP_INDEX")
fi

echo "Updating index.yaml..."
helm repo index "$OUTPUT_DIR" --url "$BASE_URL" "${MERGE_ARGS[@]}"

if [[ -n "$TMP_INDEX" && -f "$TMP_INDEX" ]]; then
  rm -f "$TMP_INDEX"
fi

echo "Done. Generated artifacts and updated index.yaml in ${OUTPUT_DIR}"

