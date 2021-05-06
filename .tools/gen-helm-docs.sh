#!/usr/bin/env bash
set -eu

# Generate helm-docs for Helm charts
# Usage ./gen-helm-docs.sh [chart]

# require helm-docs
command -v helm-docs >/dev/null 2>&1 || {
    echo >&2 "helm-docs is not installed. Aborting."
    exit 1
}

# Absolute path of repository
repository=$(git rev-parse --show-toplevel)

# Templates to copy into each chart directory
readme_template="${repository}/.tools/templates/docs/README.md.gotmpl"
config_template="${repository}/.tools/templates/docs/CONFIG.md.gotmpl"
root="${repository}"

for chart in stable/*; do
  if [ -d "${chart}" ]; then
      maxchartversion=$(cat ${chart}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
      chartname=$(basename ${chart})
      echo "-] Copying templates to ${repository}/${chart}"
      helm-docs \
          --ignore-file=".helmdocsignore" \
          --output-file="README.md" \
          --template-files="${repository}/.tools/templates/docs/README.md.gotmpl" \
          --chart-search-root="${chart}"
      helm-docs \
          --ignore-file=".helmdocsignore" \
          --output-file="CONFIG.md" \
          --template-files="${repository}/.tools/templates/docs/CONFIG.md.gotmpl" \
          --chart-search-root="${chart}"

  fi
done

for chart in incubator/*; do
  if [ -d "${chart}" ]; then
      maxchartversion=$(cat ${chart}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
      chartname=$(basename ${chart})
      echo "-] Copying templates to ${repository}/${chart}"
      helm-docs \
          --ignore-file=".helmdocsignore" \
		  --output-file="README.md" \
          --template-files="${repository}/.tools/templates/docs/README.md.gotmpl" \
          --chart-search-root="${chart}"
      helm-docs \
          --ignore-file=".helmdocsignore" \
          --output-file="CONFIG.md" \
          --template-files="${repository}/.tools/templates/docs/CONFIG.md.gotmpl" \
          --chart-search-root="${chart}"
  fi
done
