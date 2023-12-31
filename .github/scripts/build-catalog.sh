#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

include_questions() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"

    local source="charts/${train}/${chartname}/questions.yaml"
    local target="catalog/${train}/${chartname}/${chartversion}/questions.yaml"

    echo "Making copy of $source to $target"
    cp ${source} ${target}

    echo "Including standardised questions.yaml includes for: ${chartname}"
    sed -i -E 's:^.*# Include\{(.*)\}.*$:cat templates/questions/**/\1.yaml:e' ${target}
}
export -f include_questions

clean_catalog() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    cd catalog/${train}/${chartname}
    local majorversions=$( (find . -mindepth 1 -maxdepth 1 -type d  \( ! -iname ".*" \) | sed 's|^\./||g') | sort -Vr | cut -c1 | uniq)
    echo "Removing old versions for: ${chartname}"
    for majorversion in ${majorversions}; do
        local maxofmajor=$( (find . -mindepth 1 -maxdepth 1 -type d  \( -iname "${majorversion}.*" \) | sed 's|^\./||g') | sort -Vr | head -n1 )
        local rmversions=$( (find . -mindepth 1 -maxdepth 1 -type d  \( -iname "${majorversion}.*" \) \( ! -iname "${maxofmajor}" \) | sed 's|^\./||g') | sort -Vr )
        rm -Rf ${rmversions}
    done
    cd -
}
export -f clean_catalog

clean_apps() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    echo "Cleaning SCALE catalog for Chart: ${chartname}"
    rm -Rf catalog/${train}/${chartname}/${chartversion} 2>/dev/null || :
    rm -Rf catalog/${train}/${chartname}/item.yaml 2>/dev/null || :
}
export -f clean_apps

patch_apps() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    local target="catalog/${train}/${chartname}/${chartversion}"
    echo "Applying SCALE patches for Chart: ${chartname}"
    # Temporary fix to prevent the UI from bugging out on 21.08
    mv ${target}/values.yaml ${target}/ix_values.yaml 2>/dev/null || :
    touch ${target}/values.yaml
    # mv ${target}/SCALE/ix_values.yaml ${target}/ 2>/dev/null || :
    cp -rf ${target}/SCALE/templates/* ${target}/templates 2>/dev/null || :
    cp -rf ${target}/SCALE/migrations/* ${target}/migrations 2>/dev/null || :
    rm -rf ${target}/SCALE 2>/dev/null || :
    touch ${target}/values.yaml
    # Remove content that is not required for the App to install
    rm -rf ${target}/security.md
    rm -rf ${target}/helm-values.md
    rm -rf ${target}/CONFIG.md
    rm -rf ${target}/docs
    rm -rf ${target}/icon.png
    rm -rf ${target}/ci
    # Generate item.yaml
    cat ${target}/Chart.yaml | grep "icon" >> catalog/${train}/${chartname}/item.yaml
    sed -i "s|^icon:|icon_url:|g" catalog/${train}/${chartname}/item.yaml
    echo "categories:" >> catalog/${train}/${chartname}/item.yaml
    category=$(cat ${target}/Chart.yaml | yq '.annotations."truecharts.org/category"' -r)
    echo "- $category" >> catalog/${train}/${chartname}/item.yaml

    # Generate screenshots
    screenshots=""
    if [[ -d "${target}/screenshots" ]]; then
        screenshots=$(ls ${target}/screenshots)
    fi
    if [[ -n $screenshots ]]; then
        echo "screenshots:" >> catalog/${train}/${chartname}/item.yaml
        for screenshot in $screenshots; do
            echo "  - https://truecharts.org/img/hotlink-ok/chart-screenshots/${chartname}/${screenshot}" >> catalog/${train}/${chartname}/item.yaml
        done
    else
        echo "screenshots: []" >> catalog/${train}/${chartname}/item.yaml
    fi
    rm -rf ${target}/screenshots
    # Copy changelog from website
    if [[ ! -f "website/docs/charts/${train}/${chartname}/CHANGELOG.md" ]]; then
        touch "website/docs/charts/${train}/${chartname}/CHANGELOG.md"
    fi
    cp -rf "website/docs/charts/${train}/${chartname}/CHANGELOG.md" "${target}/CHANGELOG.md" 2>/dev/null || :
    if grep -q "for the complete changelog, please refer to the website" "${target}/CHANGELOG.md"; then
        echo "Adding changelog notice for: ${chartname}"
        # Count the frontmatter lines
        line_count=$(sed -n '/^---$/,/^---$/p' "${target}/CHANGELOG.md" | wc -l)
        # Increase the line count by 1
        line_count=$((line_count + 1))
        # Add a line to the changelog
        sed -i "${line_count + 1}s/^/*for the complete changelog, please refer to the website*\n\n/" "${target}/CHANGELOG.md"
        sed -i "${line_count + 1}s/^/**Important:**\n/" "${target}/CHANGELOG.md"
    fi
    echo "Truncating changelog for: ${chartname}"
    # Truncate changelog to only contain the last 100 lines
    sed -i '100,$ d' "${target}/CHANGELOG.md" || :
    # Generate SCALE App description file
    cat ${target}/Chart.yaml | yq .description -r >> ${target}/app-readme.md
    echo "" >> ${target}/app-readme.md
    echo "This App is supplied by TrueCharts, for more information visit the manual: [https://truecharts.org/charts/${train}/${chartname}](https://truecharts.org/charts/${train}/${chartname})" >> ${target}/app-readme.md
    echo "" >> ${target}/app-readme.md
    echo "---" >> ${target}/app-readme.md
    echo "" >> ${target}/app-readme.md
    echo "TrueCharts can only exist due to the incredible effort of our staff." >> ${target}/app-readme.md
    echo "Please consider making a [donation](https://truecharts.org/sponsor) or contributing back to the project any way you can!" >> ${target}/app-readme.md
    echo "app-readme generated"
}
export -f patch_apps

copy_apps() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    echo "Copying App to Catalog: ${2}"
    mkdir -p catalog/${train}/${chartname}/${chartversion}
    cp -Rf ${chart}/* catalog/${train}/${chartname}/${chartversion}/

}
export -f copy_apps

rm -rf charts/unstable
if [[ -d "charts/${1}" ]]; then
    echo "Start processing charts/${1} ..."
    chartversion=$(cat charts/${1}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
    chartname=$(basename charts/${1})
    train=$(basename $(dirname "charts/${1}"))
    SCALESUPPORT=$(cat charts/${1}/Chart.yaml | yq '.annotations."truecharts.org/SCALE-support"' -r)
    if [[ "${SCALESUPPORT}" == "true" ]]; then
        clean_apps "charts/${1}" "${chartname}" "$train" "${chartversion}"
        copy_apps "charts/${1}" "${chartname}" "$train" "${chartversion}"
        patch_apps "charts/${1}" "${chartname}" "$train" "${chartversion}"
        include_questions "charts/${1}" "${chartname}" "$train" "${chartversion}"
        clean_catalog "charts/${1}" "${chartname}" "$train" "${chartversion}"
    else
        echo "Skipping chart charts/${1}, no correct SCALE compatibility layer detected"
    fi
else
    echo "Chart 'charts/${1}' no longer exists in repo. Skipping it..."
fi
echo "Done processing charts/${1} ..."
