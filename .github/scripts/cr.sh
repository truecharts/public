#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

DEFAULT_CHART_RELEASER_VERSION=v1.6.1
DEFAULT_CHARTS_DIR=charts
MAX_CONCURRENT_JOBS=10

main() {
  local version="$DEFAULT_CHART_RELEASER_VERSION"
  local quay_token=
  local config="cr.yaml"
  local charts_dir="$DEFAULT_CHARTS_DIR"

  parse_command_line "$@"

  : "${quay_token:?Quay token must be provided}"

  echo "Packaging and uploading charts..."
  job_count=0
  for train in "$charts_dir"/*; do
    local train_name=$(basename "$train")

    echo "Processing train: ${train_name}"
    if [[ -d "$train" ]]; then
      for chart in "$train"/*; do
        if [[ -d "$chart" ]]; then
          process_chart "$chart" &
          job_count=$((job_count + 1))

          # Control concurrency: wait if we hit the max concurrent job limit
          if (( job_count >= MAX_CONCURRENT_JOBS )); then
            wait -n  # Wait for at least one job to finish
            job_count=$((job_count - 1))
          fi
        fi
      done
    fi
  done

  # Wait for any remaining background jobs to finish
  wait
}

process_chart() {
  local chart="$1"
  local chart_name=$(basename "$chart")
  local chart_version=$(grep '^version:' "$chart/Chart.yaml" | awk '{print $2}')
  echo "Processing: ${chart_name}, version ${chart_version}"

  # Check if the OCI tag exists
  if check_existing_tag "$chart_name" "$chart_version"; then
    echo "Skipping packaging of $chart because the version $chart_version already exists in OCI."
  else
    package_chart "$chart"
    upload_chart "$chart" &
  fi
}

parse_command_line() {
  while :; do
    case "${1:-}" in
    --quay-token)
      if [[ -n "${2:-}" ]]; then
        quay_token="$2"
        shift
      else
        echo "ERROR: '--quay-token' cannot be empty." >&2
        exit 1
      fi
      ;;
    *)
      break
      ;;
    esac
    shift
  done
}

check_existing_tag() {
    local chart_name="$1"
    local tag="$2"

    echo "Checking if tag '$tag' exists for chart '$chart_name' on OCI..."

    # Query the OCI registry for existing tags
    local response
    response=$(curl -s -H "Authorization: Bearer ${quay_token}" \
        "https://quay.io/api/v1/repository/truecharts/${chart_name}/tag/?specificTag=${tag}")

    if ! echo "$response" | jq . > /dev/null 2>&1; then
        echo "Error: Invalid JSON response from the server."
        return 2
    fi

    local tag_exists
    tag_exists=$(echo "$response" | jq -r --arg tag "$tag" '.tags[]? | select(.name == $tag) | .name')

    if [[ "$tag_exists" == "$tag" ]]; then
        echo "Tag '$tag' already exists for chart '$chart_name'."
        return 0
    else
        echo "Tag '$tag' does not exist for chart '$chart_name'."
        return 1
    fi
}

package_chart() {
  local chart="$1"
  local args=("$chart" --package-path .cr-release-packages)
  if [[ -n "$config" ]]; then
    args+=(--config "$config")
  fi

  echo "Packaging chart '$chart'..."
  cr package "${args[@]}"
}

upload_chart() {
  local chart="$1"
  local chart_name=$(basename "$chart")
  local chart_version=$(grep '^version:' "$chart/Chart.yaml" | awk '{print $2}')
  local pkg=".cr-release-packages/${chart_name}-${chart_version}.tgz"

  if [[ -f "$pkg" ]]; then
    echo "Uploading $chart_name version $chart_version to OCI..."
    helm push "$pkg" oci://quay.io/truecharts || echo "Failed to upload $pkg to OCI"
    curl -X POST -H "Content-Type: application/json" -d '{"visibility": "public"}' -H "Authorization: Bearer ${quay_token}" "https://quay.io/api/v1/repository/truecharts/$chart_name/changevisibility" || echo "Failed to set $pkg to public on OCI"
  else
    echo "Package $pkg not found, skipping upload."
  fi
}

main "$@"
