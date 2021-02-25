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
readme_template="${repository}/.tools/templates/chart/README.md.gotmpl"
config_template="${repository}/.tools/templates/chart/docs/CONFIG.md.gotmpl"
app_readme_template="${repository}/.tools/templates/chart/app-readme.md.gotmpl"

# Gather all charts using the common library, excluding common-test
charts=$(find "${repository}" -name "Chart.yaml" -exec grep --exclude="*common-test*"  -l "\- name\: common" {} \;)
root="${repository}"

for chart in charts/*; do
  if [ -d "${chart}" ]; then
      maxfolderversion=$(ls -l ${chart} | grep ^d | awk '{print $9}' | tail -n 1)
      maxchartversion=$(cat ${chart}/${maxfolderversion}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
      chartname=$(basename ${chart})
	  mkdir -p ${chart}/${maxfolderversion}/docs || true
      echo "-] Copying templates to ${repository}/${chart}/${maxfolderversion}"
      # Copy CONFIG template to each Chart directory, do not overwrite if exists
      cp -n "${config_template}" "${chart}/${maxfolderversion}/docs/CONFIG.md.gotmpl" || true
      helm-docs \
          --ignore-file="${repository}/.helmdocsignore" \
		  --output-file="README.md" \
          --template-files="${repository}/.tools/templates/chart/README.md.gotmpl" \
          --chart-search-root="${chart}/${maxfolderversion}"
      helm-docs \
          --ignore-file="${repository}/.helmdocsignore" \
          --output-file="docs/CONFIG.md" \
          --template-files="${chart}/${maxfolderversion}/docs/CONFIG.md.gotmpl" \
          --chart-search-root="${chart}/${maxfolderversion}"
      helm-docs \
          --ignore-file="${repository}/.helmdocsignore" \
          --output-file="app-readme.md" \
          --template-files="${repository}/.tools/templates/chart/app-readme.md.gotmpl" \
          --chart-search-root="${chart}/${maxfolderversion}"


  fi
done
