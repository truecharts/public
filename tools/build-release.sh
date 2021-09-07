#!/usr/bin/env bash

# Copyright The Helm Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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

    parse_command_line "$@"
    if [ "${token}" == "false" ]; then
        echo "env #cr_TOKEN not found, defaulting to production=false"
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
    copy_general_docs
    if [[ -n "${changed_charts[*]}" ]]; then

        rm -rf .cr-release-packages
        mkdir -p .cr-release-packages

        rm -rf .cr-index
        mkdir -p .cr-index

		prep_helm
        for chart in "${changed_charts[@]}"; do
            if [[ -d "$chart" ]]; then
                chartversion=$(cat ${chart}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
                chartname=$(basename ${chart})
                train=$(basename $(dirname "$chart"))
				create_changelog "$chart" "$chartname" "$train" "$chartversion"
				generate_docs "$chart" "$chartname" "$train" "$chartversion"
				copy_docs "$chart" "$chartname" "$train" "$chartversion"
                helm dependency update "${chart}" --skip-refresh
                package_chart "$chart"
                if [[ -d "${chart}/SCALE" ]]; then
                  clean_apps "$chart" "$chartname" "$train" "$chartversion"
                  copy_apps "$chart" "$chartname" "$train" "$chartversion"
                  patch_apps "$chart" "$chartname" "$train" "$chartversion"
                else
                  echo "Skipping chart ${chart}, no correct SCALE compatibility layer detected"
                fi
            else
                echo "Chart '$chart' no longer exists in repo. Skipping it..."
            fi
        done
        validate_catalog
        if [ "${production}" == "true" ]; then
        release_charts
        update_index
        fi
		for chart in "${changed_charts[@]}"; do
            if [[ -d "$chart" ]]; then
			    chartversion=$(cat ${chart}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
                chartname=$(basename ${chart})
				train=$(basename $(dirname "$chart"))
			    edit_release "$chart" "$chartname" "$train" "$chartversion"
            fi
        done
    else
        echo "Nothing to do. No chart changes detected."
    fi

    popd > /dev/null
}

edit_release() {
	local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
	# In here we can in the future add code to edit the release notes of the github releases
	# For example: using the github API: https://docs.github.com/en/rest/reference/repos#update-a-release
	}

create_changelog() {
	local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
	local prevversion="$(git tag -l "${chartname}-*" --sort=-v:refname  | head -n 1)"
    if [[ -z "$standalone" ]]; then
	echo "Generating changelogs for: ${chartname}"
	# SCALE "Changelog" containing only last change
	git-chglog --next-tag ${chartversion} --tag-filter-pattern ${chartname} --path ${chart} ${chartversion} -o ${chart}/SCALE/CHANGELOG.md
	# Append SCALE changelog to actual changelog
	cat ${chart}/SCALE/CHANGELOG.md | cat - ${chart}/CHANGELOG.md > temp && mv temp ${chart}/CHANGELOG.md
	fi
	}

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
                 --template-files="/home/runner/work/apps/apps/templates/docs/common-README.md.gotmpl" \
                 --chart-search-root="/home/runner/work/apps/apps/charts/library/common"
             helm-docs \
                 --ignore-file=".helmdocsignore" \
                 --output-file="helm-values.md" \
                 --template-files="/home/runner/work/apps/apps/templates/docs/common-helm-values.md.gotmpl" \
                 --chart-search-root="/home/runner/work/apps/apps/charts/library/common"
	     else
             helm-docs \
                 --ignore-file=".helmdocsignore" \
                 --output-file="README.md" \
                 --template-files="/home/runner/work/apps/apps/templates/docs/README.md.gotmpl" \
                 --chart-search-root="${chart}"
             helm-docs \
                 --ignore-file=".helmdocsignore" \
                 --output-file="CONFIG.md" \
                 --template-files="/home/runner/work/apps/apps/templates/docs/CONFIG.md.gotmpl" \
                 --chart-search-root="${chart}"
             helm-docs \
                 --ignore-file=".helmdocsignore" \
                 --output-file="app-readme.md" \
                 --template-files="/home/runner/work/apps/apps/templates/docs/app-readme.md.gotmpl" \
                 --chart-search-root="${chart}"
             helm-docs \
                 --ignore-file=".helmdocsignore" \
                 --output-file="helm-values.md" \
                 --template-files="/home/runner/work/apps/apps/templates/docs/helm-values.md.gotmpl" \
                 --chart-search-root="${chart}"
         fi
	fi
	}


copy_docs() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
	echo "Copying docs for: ${chart}"
    if [ "${chartname}" == "common" ]; then
	    mkdir -p docs/apps/common || :
	    yes | cp -rf charts/library/common/README.md  docs/apps/common/index.md 2>/dev/null || :
        yes | cp -rf charts/library/common/helm-values.md  docs/apps/common/helm-values.md 2>/dev/null || :
	else
        mkdir -p docs/apps/${train}/${chartname} || echo "app path already exists, continuing..."
        yes | cp -rf ${chart}/README.md docs/apps/${train}/${chartname}/index.md 2>/dev/null || :
		yes | cp -rf ${chart}/CHANGELOG.md docs/apps/${train}/${chartname}/CHANGELOG.md 2>/dev/null || :
        yes | cp -rf ${chart}/CONFIG.md docs/apps/${train}/${chartname}/CONFIG.md 2>/dev/null || :
        yes | cp -rf ${chart}/helm-values.md docs/apps/${train}/${chartname}/helm-values.md 2>/dev/null || :
        sed -i '1s/^/# License<br>\n\n/' docs/apps/${train}/${chartname}/LICENSE.md 2>/dev/null || :
	fi
	}

prep_helm() {
	if [[ -z "$standalone" ]]; then
	helm repo add truecharts https://truecharts.org
    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm repo update
	fi
	}

clean_apps() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    echo "Cleaning SCALE catalog for App: ${chartname}"
    rm -Rf catalog/${train}/${chartname}/${chartversion} 2>/dev/null || :
    rm -Rf catalog/${train}/${chartname}/item.yaml 2>/dev/null || :
}

patch_apps() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    local target="catalog/${train}/${chartname}/${chartversion}"
    echo "Applying SCALE patches for App: ${chartname}"
	rm -rf ${target}/CHANGELOG.md 2>/dev/null || :
	mv ${target}/SCALE/CHANGELOG.md ${target}/CHANGELOG.md 2>/dev/null || :
    mv ${target}/SCALE/ix_values.yaml ${target}/ 2>/dev/null || :
    mv ${target}/SCALE/questions.yaml ${target}/ 2>/dev/null || :
    cp -rf ${target}/SCALE/templates/* ${target}/templates 2>/dev/null || :
    mv ${target}/SCALE/item.yaml catalog/${train}/${chartname}/item.yaml
    rm -rf ${target}/SCALE 2>/dev/null || :
    mv ${target}/values.yaml ${target}/test_values.yaml 2>/dev/null || :
    touch ${target}/values.yaml
}

copy_apps() {
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    echo "Copying App to Catalog: ${2}"
    mkdir -p catalog/${train}/${chartname}/${chartversion}
    cp -Rf ${chart}/* catalog/${train}/${chartname}/${chartversion}/

}

validate_catalog() {
    if [[ -z "$standalone" ]]; then
    echo "Starting Catalog Validation"
    /usr/local/bin/catalog_validate validate --path "${PWD}/catalog"
    fi
}


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
        echo "No repo configured, defaulting to apps" >&2
        repo="apps"
    fi

    if [[ -z "$charts_repo_url" ]]; then
        charts_repo_url="https://$owner.github.io/$repo"
    fi
}

lookup_latest_tag() {
    git fetch --tags > /dev/null 2>&1

    if ! git describe --tags --abbrev=0 2> /dev/null; then
        git rev-list --max-parents=0 --first-parent HEAD
    fi
}

filter_charts() {
    while read -r chart; do
        [[ ! -d "$chart" ]] && continue
        local file="$chart/Chart.yaml"
        if [[ -f "$file" ]]; then
            echo "$chart"
        else
           echo "WARNING: $file is missing, assuming that '$chart' is not a Helm chart. Skipping." 1>&2
        fi
    done
}

lookup_changed_charts() {
    local commit="$1"

    local changed_files
    changed_files=$(git diff --find-renames --name-only "$commit" -- "$charts_dir" | grep "Chart.yaml")

    local depth=$(( $(tr "/" "\n" <<< "$charts_dir" | sed '/^\(\.\)*$/d' | wc -l) + 1 ))
    local fields="1-${depth}"

    cut -d '/' -f "$fields" <<< "$changed_files" | uniq | filter_charts
}

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

main "$@"
