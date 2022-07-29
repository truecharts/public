#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# Designed to ensure the appversion in Chart.yaml is in sync with the primary App tag if found
# Also makes sure that home link is pointing to the correct url
sync_tag() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    echo "Attempting to sync primary tag with appversion for: ${chartname}"
    local tag="$(cat ${chart}/values.yaml | grep '^  tag: ' | awk -F" " '{ print $2 }' | head -1)"
    tag="${tag%%@*}"
    tag="${tag:-auto}"
    tag=$(echo $tag | sed "s/release-//g")
    tag=$(echo $tag | sed "s/release_//g")
    tag=$(echo $tag | sed "s/version-//g")
    tag=$(echo $tag | sed "s/version_//g")
    tag="${tag#*V.}"
    tag="${tag#*v-}"
    tag="${tag#*v}"
    tag="${tag%-*}"
    tag="${tag:0:10}"
    tag="${tag%-}"
    tag="${tag%_}"
    tag="${tag%.}"
    echo "Updating tag of ${chartname} to ${tag}..."
    sed -i -e "s|appVersion: .*|appVersion: \"${tag}\"|" "${chart}/Chart.yaml"
    echo "Updating icon of ${chartname}..."
    sed -i -e "s|icon: .*|icon: https:\/\/truecharts.org\/img\/chart-icons\/${chartname}.png|" "${chart}/Chart.yaml"
    echo "Updating home of ${chartname}..."
    sed -i -e "s|home: .*|home: https:\/\/truecharts.org\/docs\/charts\/${train}\/${chartname}|" "${chart}/Chart.yaml"
    echo "Updating sources of ${chartname}..."    # Get all sources (except truecharts)
    # Get all sources (except truecharts)
    curr_sources=$(yq '.sources[] | select(. != "https://github.com/truecharts*")' "${chart}/Chart.yaml")
    # Empty sources list in-place
    yq -i 'del(.sources.[])' "${chart}/Chart.yaml"
    # Add truechart source
    tcsource="https://github.com/truecharts/charts/tree/master/charts/$train/$chartname" yq -i '.sources += env(tcsource)' "${chart}/Chart.yaml"
    # Add the rest of the sources
    while IFS= read -r line; do
        src="$line" yq -i '.sources += env(src)' "${chart}/Chart.yaml"
    done <<< "$curr_sources"
    }
export -f sync_tag

sync_helmignore() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    echo "Attempting to sync HelmIgnore file for: ${chartname}"
    rm -rf ${chart}/.helmignore
    cp templates/chart/.helmignore ${chart}/
    }
export -f sync_helmignore

create_changelog() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    local prevversion="$(git tag -l "${chartname}-*" --sort=-v:refname  | head -n 1)"
    echo "Generating changelogs for: ${chartname}"
    # SCALE "Changelog" containing only last change
    git-chglog --next-tag ${chartname}-${chartversion} --tag-filter-pattern ${chartname} --path ${chart} -o ${chart}/app-changelog.md ${chartname}-${chartversion}
    # Append SCALE changelog to actual changelog

    if [[ -f "${chart}/CHANGELOG.md" ]]; then
       true
    else
       touch ${chart}/CHANGELOG.md
    fi
    sed -i '1d' ${chart}/CHANGELOG.md
    cat ${chart}/app-changelog.md | cat - ${chart}/CHANGELOG.md > temp && mv temp ${chart}/CHANGELOG.md
    sed -i '1s/^/# Changelog\n\n/' ${chart}/CHANGELOG.md
    rm ${chart}/app-changelog.md || echo "changelog not found..."
    }
    export -f create_changelog

generate_docs() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    echo "Generating Docs"
        helm-docs \
            --ignore-file=".helmdocsignore" \
            --output-file="README.md" \
            --template-files="/__w/charts/charts/templates/docs/README.md.gotmpl" \
            --chart-search-root="${chart}"
    }
    export -f generate_docs


if [[ -d "charts/${1}" ]]; then
    echo "Start processing charts/${1} ..."
    chartversion=$(cat charts/${1}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
    chartname=$(basename charts/${1})
    train=$(basename $(dirname "charts/${1}"))
    SCALESUPPORT=$(cat charts/${1}/Chart.yaml | yq '.annotations."truecharts.org/SCALE-support"' -r)
    sync_helmignore "charts/${1}" "${chartname}" "$train" "${chartversion}" || echo "Syncing HelmIgnore file failed..."
    helm dependency update "charts/${1}" --skip-refresh || (sleep 10 && helm dependency update "charts/${1}" --skip-refresh) || (sleep 10 && helm dependency update "charts/${1}" --skip-refresh)
    sync_tag "charts/${1}" "${chartname}" "$train" "${chartversion}" || echo "Tag sync failed..."
    create_changelog "charts/${1}" "${chartname}" "$train" "${chartversion}" || echo "changelog generation failed..."
    generate_docs "charts/${1}" "${chartname}" "$train" "${chartversion}" || echo "Docs generation failed..."
else
    echo "Chart 'charts/${1}' no longer exists in repo. Skipping it..."
fi
echo "Done processing charts/${1} ..."
