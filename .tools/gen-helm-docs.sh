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
readme_template="${repository}/hack/templates/README.md.gotmpl"
readme_config_template="${repository}/hack/templates/README_CONFIG.md.gotmpl"
readme_changelog_template="${repository}/hack/templates/README_CHANGELOG.md.gotmpl"

# Gather all charts using the common library, excluding common-test
charts=$(find "${repository}" -name "Chart.yaml" -exec grep --exclude="*common-test*"  -l "\- name\: common" {} \;)
root="${repository}"

for chart in charts/*; do
  if [ -d "${chart}" ]; then
      maxfolderversion=$(ls -l ${chart} | grep ^d | awk '{print $9}' | tail -n 1)
      maxchartversion=$(cat ${chart}/${maxfolderversion}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
      chartname=$(basename ${chart})
      echo "-] Copying templates to ${chart}"
      # Copy README template into each Chart directory, overwrite if exists
      cp "${readme_template}" "${chart}"
      # Copy CONFIG template to each Chart directory, do not overwrite if exists
      cp -n "${readme_config_template}" "${chart}" || true
      # Copy CHANGELOG template to each Chart directory, do not overwrite if exists
      cp -n "${readme_changelog_template}" "${chart}" || true
      helm-docs \
          --ignore-file="${repository}/.helmdocsignore" \
          --template-files="$(basename "${readme_template}")" \
          --template-files="$(basename "${readme_config_template}")" \
          --template-files="$(basename "${readme_changelog_template}")" \
  fi
done
