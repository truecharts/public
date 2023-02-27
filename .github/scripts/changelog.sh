#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

if [[ -d "charts/${1}" ]]; then
    echo "Start processing charts/${1} ..."
    chart="charts/${1}"
    chartversion=$(cat charts/${1}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
    chartname=$(basename charts/${1})
    train=$(basename $(dirname "charts/${1}"))
    SCALESUPPORT=$(cat charts/${1}/Chart.yaml | yq '.annotations."truecharts.org/SCALE-support"' -r)
    # Ensure to start with a clean slate
    rm -rf ${chart}/app-changelog.md || echo "changelog not found..."
    echo "Generating changelogs for: ${chartname}"
    # SCALE "Changelog" containing only last change
    git-chglog --next-tag ${chartname}-${chartversion} --tag-filter-pattern "^${chartname}-\d+\.\d+\.\d+\$" --path ${chart} -o ${chart}/app-changelog.md ${chartname}-${chartversion} || echo "changelog generation failed..."
else
    echo "Chart 'charts/${1}' no longer exists in repo. Skipping it..."
fi
echo "Done processing charts/${1} ..."
