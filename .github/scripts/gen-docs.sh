#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# Designed to ensure the appversion in Chart.yaml is in sync with the primary App tag if found
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
    sed -i -e "s|appVersion: .*|appVersion: \"${tag}\"|" "${chart}/Chart.yaml"
    }
export -f sync_tag

helm_sec_scan() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    echo "Scanning helm security for ${chartname}"
    mkdir -p ${chart}/render
    rm -rf ${chart}/security.md || echo "removing old security.md file failed..."
    cat templates/security.tpl >> ${chart}/security.md
    echo "" >> ${chart}/security.md
    helm template ${chart} --output-dir ${chart}/render > /dev/null
    #trivy config -f template --template "@./templates/trivy-config.tpl" -o ${chart}/render/tmpsec${chartname}.md ${chart}/render
    cat "SCANNING DISABLED DUE TO BUG" >> ${chart}/security.md
    rm -rf ${chart}/render/tmpsec${chartname}.md || true
    echo "" >> ${chart}/security.md
    }
    export -f helm_sec_scan

container_sec_scan() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    echo "Scanning container security for ${chartname}"
    echo "## Containers" >> ${chart}/security.md
    echo "" >> ${chart}/security.md
    echo "##### Detected Containers" >> ${chart}/security.md
    echo "" >> ${chart}/security.md
    find ./${chart}/render/ -name '*.yaml' -type f -exec cat {} \; | grep image: | sed "s/image: //g" | sed "s/\"//g" >> ${chart}/render/containers.tmp
    cat ${chart}/render/containers.tmp >> ${chart}/security.md
    echo "" >> ${chart}/security.md
    echo "##### Scan Results" >> ${chart}/security.md
    echo "" >> ${chart}/security.md
    for container in $(cat ${chart}/render/containers.tmp); do
      echo "processing container: ${container}"
      echo "SCANNING DISABLED DUE TO BUG" >> ${chart}/security.md
      #trivy image -f template --template "@./templates/trivy-container.tpl" -o ${chart}/render/tmpsec${chartname}.md "${container}"
      cat ${chart}/render/tmpsec${chartname}.md >> ${chart}/security.md
      rm -rf ${chart}/render/tmpsec${chartname}.md || true
      echo "" >> ${chart}/security.md
    done

    }
    export -f container_sec_scan

sec_scan_cleanup() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    rm -rf ${chart}/render
    sed -i 's/ghcr.io/tccr.io/g' ${chart}/security.md
    }
    export -f sec_scan_cleanup

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
    sed -i '1s/^/# Changelog<br>\n\n/' ${chart}/CHANGELOG.md
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
            --template-files="/__w/apps/apps/templates/docs/README.md.gotmpl" \
            --chart-search-root="${chart}"
    }
    export -f generate_docs


if [[ -d "charts/${1}" ]]; then
    echo "Start processing charts/${1} ..."
    chartversion=$(cat charts/${1}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
    chartname=$(basename charts/${1})
    train=$(basename $(dirname "charts/${1}"))
    SCALESUPPORT=$(cat charts/${1}/Chart.yaml | yq '.annotations."truecharts.org/SCALE-support"' -r)
    helm dependency update "charts/${1}" --skip-refresh || (sleep 10 && helm dependency update "charts/${1}" --skip-refresh) || (sleep 10 && helm dependency update "charts/${1}" --skip-refresh)
    helm_sec_scan "charts/${1}" "${chartname}" "$train" "${chartversion}" || echo "helm-chart security-scan failed..."
    container_sec_scan "charts/${1}" "${chartname}" "$train" "${chartversion}" || echo "container security-scan failed..."
    sec_scan_cleanup "charts/${1}" "${chartname}" "$train" "${chartversion}" || echo "security-scan cleanup failed..."
    sync_tag "charts/${1}" "${chartname}" "$train" "${chartversion}" || echo "Tag sync failed..."
    create_changelog "charts/${1}" "${chartname}" "$train" "${chartversion}" || echo "changelog generation failed..."
    generate_docs "charts/${1}" "${chartname}" "$train" "${chartversion}" || echo "Docs generation failed..."
else
    echo "Chart 'charts/${1}' no longer exists in repo. Skipping it..."
fi
echo "Done processing charts/${1} ..."
