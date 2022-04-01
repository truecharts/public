#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

DEFAULT_CHART_RELEASER_VERSION=v1.2.1

show_help() {
cat << EOF
Usage: $(basename "$0") <options>
    -h, --help               Display help
    -d, --charts-dir         The charts directory (default: charts)
EOF
}

main() {
    local charts_dir=charts/**
    local token=${CR_TOKEN:-false}
    local parthreads=$(($(nproc) * 2))

    parse_command_line "$@"

    local repo_root
    repo_root=$(git rev-parse --show-toplevel)
    pushd "$repo_root" > /dev/null

    echo 'Looking up latest tag...'
    local latest_tag
    latest_tag=$(lookup_latest_tag)

    echo "Discovering changed charts since '$latest_tag'..."
    local changed_charts=()
    readarray -t changed_charts <<< "$(lookup_changed_charts "$latest_tag")"
    if [[ -n "${changed_charts[*]}" ]]; then
        prep_helm
        parallel -j ${parthreads} chart_runner '2>&1' ::: ${changed_charts[@]}
        echo "Starting post-processing"
        pre_commit
    else
        echo "Nothing to do. No chart changes detected."
    fi

    popd > /dev/null
}

chart_runner(){
  if [[ -d "${1}" ]]; then
      echo "Start processing ${1} ..."
      chartversion=$(cat ${1}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
      chartname=$(basename ${1})
      train=$(basename $(dirname "${1}"))
      SCALESUPPORT=$(cat ${1}/Chart.yaml | yq '.annotations."truecharts.org/SCALE-support"' -r)
      helm dependency update "${1}" --skip-refresh || (sleep 10 && helm dependency update "${1}" --skip-refresh) || (sleep 10 && helm dependency update "${1}" --skip-refresh)
      helm_sec_scan "${1}" "${chartname}" "$train" "${chartversion}" || echo "helm-chart security-scan failed..."
      container_sec_scan "${1}" "${chartname}" "$train" "${chartversion}" || echo "container security-scan failed..."
      sec_scan_cleanup "${1}" "${chartname}" "$train" "${chartversion}" || echo "security-scan cleanup failed..."
      sync_tag "${1}" "${chartname}" "$train" "${chartversion}" || echo "Tag sync failed..."
      create_changelog "${1}" "${chartname}" "$train" "${chartversion}" || echo "changelog generation failed..."
      generate_docs "${1}" "${chartname}" "$train" "${chartversion}" || echo "Docs generation failed..."
  else
      echo "Chart '${1}' no longer exists in repo. Skipping it..."
  fi
  echo "Done processing ${1} ..."
}
export -f chart_runner

prep_helm() {
    helm repo add truecharts-old https://truecharts.org
    helm repo add truecharts https://charts.truecharts.org
    helm repo add truecharts-library https://library-charts.truecharts.org
    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm repo add metallb https://metallb.github.io/metallb
    helm repo add grafana https://grafana.github.io/helm-charts
    helm repo add prometheus https://prometheus-community.github.io/helm-charts
    helm repo add amd-gpu-helm https://radeonopencompute.github.io/k8s-device-plugin/
    helm repo update
    }
export -f prep_helm

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
    trivy config -f template --template "@./templates/trivy-config.tpl" -o ${chart}/render/tmpsec${chartname}.md ${chart}/render
    cat ${chart}/render/tmpsec${chartname}.md >> ${chart}/security.md
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
      echo "" >> ${chart}/security.md
      trivy image -f template --template "@./templates/trivy-container.tpl" -o ${chart}/render/tmpsec${chartname}.md "${container}"
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

pre_commit() {
      echo "Running pre-commit test-and-cleanup..."
       pre-commit run --all ||:
      # Fix sh files to always be executable
      find . -name '*.sh' | xargs chmod +x
    }
    export -f pre_commit

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
        helm-docs \
            --ignore-file=".helmdocsignore" \
            --output-file="CONFIG.md" \
            --template-files="/__w/apps/apps/templates/docs/CONFIG.md.gotmpl" \
            --chart-search-root="${chart}"
        helm-docs \
            --ignore-file=".helmdocsignore" \
            --output-file="helm-values.md" \
            --template-files="/__w/apps/apps/templates/docs/helm-values.md.gotmpl" \
            --chart-search-root="${chart}"
    }
    export -f generate_docs

parse_command_line() {
    while :; do
        case "${1:-}" in
            -h|--help)
                show_help
                exit
                ;;
            -d|--charts-dir)
                if [[ -n "${2:-}" ]]; then
                    charts_dir="$2"
                    shift
                else
                    echo "ERROR: '-d|--charts-dir' cannot be empty." >&2
                    show_help
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
export -f parse_command_line

lookup_latest_tag() {
    git fetch --tags > /dev/null 2>&1

    if ! git describe --tags --abbrev=0 2> /dev/null; then
        git rev-list --max-parents=0 --first-parent HEAD
    fi
}
export -f lookup_latest_tag

filter_charts() {
    while read -r chart; do
        [[ ! -d "$chart" ]] && continue
        if [[ $(git diff $latest_tag $chart/Chart.yaml | grep "+version") ]]; then
            echo "$chart"
        else
           echo "Version not bumped. Skipping." 1>&2
        fi
    done
}
export -f filter_charts

lookup_changed_charts() {
    local commit="$1"

    local changed_files
    changed_files=$(git diff --find-renames --name-only "$commit" -- "$charts_dir" | grep "Chart.yaml")

    local depth=$(( $(tr "/" "\n" <<< "$charts_dir" | sed '/^\(\.\)*$/d' | wc -l) + 1 ))
    local fields="1-${depth}"

    cut -d '/' -f "$fields" <<< "$changed_files" | uniq | filter_charts
}
export -f lookup_changed_charts

main "$@"
