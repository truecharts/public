#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

patch_apps() {
# Copy changelog from website
if [[ ! -f "website/docs/charts/${train}/${chartname}/CHANGELOG.md" ]]; then
    touch "website/docs/charts/${train}/${chartname}/CHANGELOG.md"
fi
cp -rf "website/docs/charts/${train}/${chartname}/CHANGELOG.md" "${target}/CHANGELOG.md" 2>/dev/null || :
# If changelog is empty, add a notice
if ! grep -q "for the complete changelog, please refer to the website" "${target}/CHANGELOG.md"; then
    echo "Adding changelog notice for: ${chartname}"
    # Count the frontmatter lines
    line_count=$(sed -n '/^---$/,/^---$/p' "${target}/CHANGELOG.md" | wc -l)
    # Increase the line count by 2
    line_count=$((line_count + 2))
    # Add a line to the changelog
    sed -i "${line_count}s/^/*for the complete changelog, please refer to the website*\n\n/" "${target}/CHANGELOG.md"
    sed -i "${line_count}s/^/**Important:**\n/" "${target}/CHANGELOG.md"
fi
echo "Truncating changelog for: ${chartname}"
# Truncate changelog to only contain the last 100 lines
sed -i '100,$ d' "${target}/CHANGELOG.md" || :
}
export -f patch_apps

if [[ -d "charts/${1}" ]]; then
    echo "Start processing charts/${1} ..."
    chartversion=$(cat charts/${1}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
    chartname=$(basename charts/${1})
    train=$(basename $(dirname "charts/${1}"))
    SCALESUPPORT=$(cat charts/${1}/Chart.yaml | yq '.annotations."truecharts.org/SCALE-support"' -r)
    if [[ "${SCALESUPPORT}" == "true" ]]; then
        patch_apps "charts/${1}" "${chartname}" "$train" "${chartversion}"
    else
        echo "Skipping chart charts/${1}, no correct SCALE compatibility layer detected"
    fi
else
    echo "Chart 'charts/${1}' no longer exists in repo. Skipping it..."
fi
echo "Done processing charts/${1} ..."
	

	
