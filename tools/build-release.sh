#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

DEFAULT_CHART_RELEASER_VERSION=v1.2.1

show_help() {
cat << EOF
Usage: $(basename "$0") <options>
    -h, --help               Display help
    -v, --version            The chart-releaser version to use (default: $DEFAULT_CHART_RELEASER_VERSION)"
        --config             The path to the chart-releaser config file
    -d, --charts-dir         The charts directory (default: charts)
    -u, --charts-repo-url    The GitHub Pages URL to the charts repo (default: https://<owner>.github.io/<repo>)
    -o, --owner              The repo owner
    -r, --repo               The repo name
    -p, --production         Enables uploading releases to github releases
    -s, --standalone         Disables Chart Releaser and Catalog Validation, for local generation
EOF
}

main() {
    local version="$DEFAULT_CHART_RELEASER_VERSION"
    local config=
    local standalone=
    local charts_dir=charts/**
    local owner=
    local repo=
    local production=
    local charts_repo_url=
    local token=${CR_TOKEN:-false}
    local parthreads=$(($(nproc) * 2))

    parse_command_line "$@"
    if [ "${token}" == "false" ]; then
        echo "env #CR_TOKEN not found, defaulting to production=false"
        production="false"
    fi

    local repo_root
    repo_root=$(git rev-parse --show-toplevel)
    pushd "$repo_root" > /dev/null

    echo 'Looking up latest tag...'
    local latest_tag
    latest_tag=$(lookup_latest_tag)

    echo "Discovering changed charts since '$latest_tag'..."
    local changed_charts=()
    readarray -t changed_charts <<< "$(lookup_changed_charts "$latest_tag")"
    # copy_general_docs
    if [[ -n "${changed_charts[*]}" ]]; then

        prep_helm

        parallel -j ${parthreads} chart_runner '2>&1' ::: ${changed_charts[@]}
        echo "Starting post-processing"
        # pre_commit
        validate_catalog
        if [ "${production}" == "true" ]; then
        gen_dh_cat
        upload_catalog
        upload_dhcatalog
        fi
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
      helm dependency build "${1}" --skip-refresh || (sleep 10 && helm dependency build "${1}" --skip-refresh) || (sleep 10 && helm dependency build "${1}" --skip-refresh)
      sync_tag "${1}" "${chartname}" "$train" "${chartversion}" || echo "Tag sync failed..."
      # create_changelog "${1}" "${chartname}" "$train" "${chartversion}" || echo "changelog generation failed..."
      # generate_docs "${1}" "${chartname}" "$train" "${chartversion}" || echo "Docs generation failed..."
      #copy_docs "${1}" "${chartname}" "$train" "${chartversion}" || echo "Docs Copy failed..."
      #package_chart "${1}"
      if [[ "${SCALESUPPORT}" == "true" ]]; then
        clean_apps "${1}" "${chartname}" "$train" "${chartversion}"
        copy_apps "${1}" "${chartname}" "$train" "${chartversion}"
        patch_apps "${1}" "${chartname}" "$train" "${chartversion}"
        include_questions "${1}" "${chartname}" "$train" "${chartversion}"
        clean_catalog "${1}" "${chartname}" "$train" "${chartversion}"
      else
        echo "Skipping chart ${1}, no correct SCALE compatibility layer detected"
      fi
  else
      echo "Chart '${1}' no longer exists in repo. Skipping it..."
  fi
  echo "Done processing ${1} ..."
}
export -f chart_runner

include_questions(){
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

gen_dh_cat() {
    rm -rf dh_catalog/*.*
    rm -rf dh_catalog/*
    cp -rf catalog/* dh_catalog
    cd dh_catalog
    find ./ -type f -name *.yaml -exec sed -i 's/tccr.io/dh.tccr.io/gI' {} \;
    cd -
   }
export -f gen_dh_cat

# Designed to ensure the appversion in Chart.yaml is in sync with the primary Chart tag if found
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
    sed -i -e "s|icon: .*|icon: https:\/\/truecharts.org\/img\/hotlink-ok\/chart-icons\/${chartname}.png|" "${chart}/Chart.yaml"
    echo "Updating home of ${chartname}..."
    sed -i -e "s|home: .*|home: https:\/\/truecharts.org\/docs\/charts\/${train}\/${chartname}|" "${chart}/Chart.yaml"
    echo "Attempting to update sources of ${chartname}..."
    echo "Using go-yq verion: <$(go-yq -V)>"
    # Get all sources (except truecharts)
    curr_sources=$(go-yq '.sources[] | select(. != "https://github.com/truecharts*")' "${chart}/Chart.yaml")
    # Empty sources list in-place
    go-yq -i 'del(.sources.[])' "${chart}/Chart.yaml"
    # Add truechart source
    tcsource="https://github.com/truecharts/charts/tree/master/charts/$train/$chartname" go-yq -i '.sources += env(tcsource)' "${chart}/Chart.yaml"
    # Add the rest of the sources
    while IFS= read -r line; do
        src="$line" go-yq -i '.sources += env(src)' "${chart}/Chart.yaml"
    done <<< "$curr_sources"
    echo "Sources of ${chartname} updated!"
    }
export -f sync_tag

pre_commit() {
    if [[ -z "$standalone" ]]; then
      echo "Running pre-commit test-and-cleanup..."
       pre-commit run --all ||:
      # Fix sh files to always be executable
      find . -name '*.sh' | xargs chmod +x
    fi
    }
    export -f pre_commit

create_changelog() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    local prevversion="$(git tag -l "${chartname}-*" --sort=-v:refname  | head -n 1)"
    if [[ -z "$standalone" ]]; then
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
    fi
    }
    export -f create_changelog

copy_general_docs() {
    yes | cp -rf index.yaml docs/index.yaml 2>/dev/null || :
    yes | cp -rf .github/README.md docs/index.md 2>/dev/null || :
    sed -i '1s/^/---\nhide:\n  - navigation\n  - toc\n---\n/' docs/index.md
    sed -i 's~<!-- INSERT-DISCORD-WIDGET -->~<iframe src="https://discord.com/widget?id=830763548678291466\&theme=dark" width="350" height="500" allowtransparency="true" frameborder="0" sandbox="allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts"></iframe>~g' docs/index.md
    yes | cp -rf .github/CODE_OF_CONDUCT docs/about/code_of_conduct.md 2>/dev/null || :
    yes | cp -rf .github/CONTRIBUTING docs/development/contributing.md 2>/dev/null || :
    yes | cp -rf .github/SUPPORT.md docs/manual/SUPPORT.md 2>/dev/null || :
    yes | cp -rf LICENSE docs/about/legal/LICENSE.md 2>/dev/null || :
    sed -i '1s/^/# License<br>\n\n/' docs/about/legal/LICENSE.md
    yes | cp -rf NOTICE docs/about/legal/NOTICE.md 2>/dev/null || :
    sed -i '1s/^/# NOTICE<br>\n\n/' docs/about/legal/NOTICE.md
    }
    export -f copy_general_docs

generate_docs() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    if [[ -z "$standalone" ]]; then
         echo "Generating Docs"
         if [ "${chartname}" == "common" ]; then
             helm-docs \
                 --ignore-file=".helmdocsignore" \
                 --output-file="README.md" \
                 --template-files="/__w/apps/apps/templates/docs/common-README.md.gotmpl" \
                 --chart-search-root="${chart}"
             helm-docs \
                 --ignore-file=".helmdocsignore" \
                 --output-file="helm-values.md" \
                 --template-files="/__w/apps/apps/templates/docs/common-helm-values.md.gotmpl" \
                 --chart-search-root="${chart}"
         else
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
         fi
         sed -i "s/TRAINPLACEHOLDER/${train}/" "${chart}/README.md"
    fi
    }
    export -f generate_docs


copy_docs() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    echo "Copying docs for: ${chart}"
    if [ "${chartname}" == "common" ]; then
        mkdir -p docs/charts/common || :
        yes | cp -rf charts/library/common/README.md  docs/charts/common/index.md 2>/dev/null || :
        yes | cp -rf charts/library/common/helm-values.md  docs/charts/common/helm-values.md 2>/dev/null || :
    else
        mkdir -p docs/charts/${train}/${chartname} || echo "chart path already exists, continuing..."
        yes | cp -rf ${chart}/README.md docs/charts/${train}/${chartname}/index.md 2>/dev/null || :
        yes | cp -rf ${chart}/CHANGELOG.md docs/charts/${train}/${chartname}/CHANGELOG.md 2>/dev/null || :
        yes | cp -rf ${chart}/security.md docs/charts/${train}/${chartname}/security.md 2>/dev/null || :
        yes | cp -rf ${chart}/CONFIG.md docs/charts/${train}/${chartname}/CONFIG.md 2>/dev/null || :
        yes | cp -rf ${chart}/helm-values.md docs/charts/${train}/${chartname}/helm-values.md 2>/dev/null || :
        rm docs/charts/${train}/${chartname}/LICENSE.md 2>/dev/null || :
        yes | cp -rf ${chart}/LICENSE docs/charts/${train}/${chartname}/LICENSE.md 2>/dev/null || :
        sed -i '1s/^/# License<br>\n\n/' docs/charts/${train}/${chartname}/LICENSE.md 2>/dev/null || :
    fi
    }
    export -f copy_docs

prep_helm() {
    if [[ -z "$standalone" ]]; then
    helm repo add truecharts https://charts.truecharts.org
    helm repo add truecharts-library https://library-charts.truecharts.org
    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm repo add metallb https://metallb.github.io/metallb
    helm repo add grafana https://grafana.github.io/helm-charts
    helm repo add prometheus https://prometheus-community.github.io/helm-charts
    helm repo update
    fi
    }
    export -f prep_helm

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
    sed -i '100,$ d' ${target}/CHANGELOG.md || :
    mv ${target}/app-changelog.md ${target}/CHANGELOG.md 2>/dev/null || :
    # Temporary fix to prevent the UI from bugging out on 21.08
    mv ${target}/values.yaml ${target}/ix_values.yaml 2>/dev/null || :
    touch ${target}/values.yaml
    # mv ${target}/SCALE/ix_values.yaml ${target}/ 2>/dev/null || :
    cp -rf ${target}/SCALE/templates/* ${target}/templates 2>/dev/null || :
    rm -rf ${target}/SCALE 2>/dev/null || :
    touch ${target}/values.yaml
    # Generate item.yaml
    cat ${target}/Chart.yaml | grep "icon" >> catalog/${train}/${chartname}/item.yaml
    sed -i "s|^icon:|icon_url:|g" catalog/${train}/${chartname}/item.yaml
    echo "categories:" >> catalog/${train}/${chartname}/item.yaml
    cat ${target}/Chart.yaml | yq '.annotations."truecharts.org/catagories"' -r >> catalog/${train}/${chartname}/item.yaml
    # Generate SCALE App description file
    cat ${target}/Chart.yaml | yq .description -r >> ${target}/app-readme.md
    echo "" >> ${target}/app-readme.md
    echo "This Chart is supplied by TrueCharts, for more information please visit https://truecharts.org" >> ${target}/app-readme.md
}
export -f patch_apps

copy_apps() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    echo "Copying Chart to Catalog: ${2}"
    mkdir -p catalog/${train}/${chartname}/${chartversion}
    cp -Rf ${chart}/* catalog/${train}/${chartname}/${chartversion}/

}
export -f copy_apps

validate_catalog() {
    if [[ -z "$standalone" ]]; then
    echo "Starting Catalog Validation"
    /usr/local/bin/catalog_validate validate --path "${PWD}/catalog"
    fi
}
export -f validate_catalog

upload_catalog() {
    echo "Uploading Catalog..."
    cd catalog
    git config user.name "TrueCharts-Bot"
    git config user.email "bot@truecharts.org"
    git add --all
    git commit -sm "Commit new Chart releases for TrueCharts" || exit 0
    git push
    cd -
    rm -rf catalog
}
export -f upload_catalog

upload_dhcatalog() {
    echo "Uploading DH-Catalog..."
    cd dh_catalog
    git config user.name "TrueCharts-Bot"
    git config user.email "bot@truecharts.org"
    git add --all
    git commit -sm "Commit new Chart releases for TrueCharts" || exit 0
    git push
    cd -
    rm -rf dh_catalog
}
export -f upload_dhcatalog



parse_command_line() {
    while :; do
        case "${1:-}" in
            -h|--help)
                show_help
                exit
                ;;
            --config)
                if [[ -n "${2:-}" ]]; then
                    config="$2"
                    shift
                else
                    config=".github/cr.yaml"
                    shift
                fi
                ;;
            -v|--version)
                if [[ -n "${2:-}" ]]; then
                    version="$2"
                    shift
                else
                    echo "ERROR: '-v|--version' cannot be empty." >&2
                    show_help
                    exit 1
                fi
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
            -u|--charts-repo-url)
                if [[ -n "${2:-}" ]]; then
                    charts_repo_url="$2"
                    shift
                else
                    echo "ERROR: '-u|--charts-repo-url' cannot be empty." >&2
                    show_help
                    exit 1
                fi
                ;;
            -o|--owner)
                if [[ -n "${2:-}" ]]; then
                    owner="$2"
                    shift
                else
                    echo "ERROR: '--owner' cannot be empty." >&2
                    show_help
                    exit 1
                fi
                ;;
            -r|--repo)
                if [[ -n "${2:-}" ]]; then
                    repo="$2"
                    shift
                else
                    echo "ERROR: '--repo' cannot be empty." >&2
                    show_help
                    exit 1
                fi
                ;;
            -p|--production)
                production="true"
                ;;
            -s|--standalone)
                standalone="true"
                ;;
            *)
                break
                ;;
        esac

        shift
    done

    if [[ -z "$owner" ]]; then
        echo "No owner configured, defaulting to truecharts" >&2
        owner="truecharts"
    fi

    if [[ -z "$repo" ]]; then
        echo "No repo configured, defaulting to charts" >&2
        repo="charts"
    fi

    if [[ -z "$charts_repo_url" ]]; then
        charts_repo_url="https://$owner.github.io/$repo"
    fi
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

package_chart() {
    local chart="$1"
    local args=("$chart" --package-path .cr-release-packages)
    if [[ -n "$config" ]]; then
        args+=(--config "$config")
    fi

    if [[ -z "$standalone" ]]; then
    echo "Packaging chart '$chart'..."
    cr package "${args[@]}"
    fi
}
export -f package_chart

release_charts() {
    local args=(-o "$owner" -r "$repo" -c "$(git rev-parse HEAD)")
    if [[ -n "$config" ]]; then
        args+=(--config "$config")
    fi

    if [[ -z "$standalone" ]]; then
    echo 'Releasing charts...'
    cr upload "${args[@]}"
    fi
}
export -f release_charts

update_index() {
    local args=(-o "$owner" -r "$repo" -c "$charts_repo_url")
    if [[ -n "$config" ]]; then
        args+=(--config "$config")
    fi

    if [[ -z "$standalone" ]]; then
    echo 'Updating charts repo index...'
    cr index "${args[@]}"
    fi
}
export -f update_index

upload_index() {
  cd .cr-index
  git config user.name "TrueCharts-Bot"
  git config user.email "bot@truecharts.org"
  git add --all
  git commit -sm "Commit released Helm Chart and docs for TrueCharts" || exit 0
  git push
  cd -
  rm -rf .cr-index
}
export -f upload_index

main "$@"
