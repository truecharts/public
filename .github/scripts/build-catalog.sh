#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

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
    cat ${target}/Chart.yaml | yq '.annotations."truecharts.org/catagories"' -r >> catalog/${train}/${chartname}/item.yaml
    # Copy changelog from website
    cp -rf "website/docs/charts/${train}/${chart}/CHANGELOG.md" "${target}/CHANGELOG.md" 2>/dev/null || :
    sed -i '1d' "${target}/CHANGELOG.md"
    sed -i '1s/^/*for the complete changelog, please refer to the website*\n\n/' "${target}/CHANGELOG.md"
    sed -i '1s/^/**Important:**\n/' "${target}/CHANGELOG.md"
    sed -i '100,$ d' "${target}/CHANGELOG.md" || :
    # Generate SCALE App description file
    cat ${target}/Chart.yaml | yq .description -r >> ${target}/app-readme.md
    echo "" >> ${target}/app-readme.md
    echo "This App is supplied by TrueCharts, for more information visit the manual: [https://truecharts.org/docs/charts/${train}/${chartname}](https://truecharts.org/docs/charts/${train}/${chartname})" >> ${target}/app-readme.md
    echo "" >> ${target}/app-readme.md
    echo "---" >> ${target}/app-readme.md
    echo "" >> ${target}/app-readme.md
    echo "TrueCharts can only exist due to the incredible effort of our staff." >> ${target}/app-readme.md
    echo "Please consider making a [donation](https://truecharts.org/docs/about/sponsor) or contributing back to the project any way you can!" >> ${target}/app-readme.md
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

download_deps() {
local chart="$1"
local chartname="$2"
local train="$3"
local chartversion="$4"

deps=$(go-yq '.dependencies' "$chart/Chart.yaml")
length=$(echo "$deps" | go-yq '. | length')

echo "🔨 Processing <$chartname>... Dependencies: $length"
echo ""

for idx in $(eval echo "{0..$length}"); do
    curr_dep=$(echo "$deps" | pos="$idx" go-yq '.[env(pos)]')

    if [ ! "$curr_dep" == null ]; then
        name=$(echo "$curr_dep" | go-yq '.name')
        version=$(echo "$curr_dep" | go-yq '.version')
        repo=$(echo "$curr_dep" | go-yq '.repository')

        echo "**********"
        echo "🔗 Dependency: $name"
        echo "🆚 Version: $version"
        echo "🏠 Repository: $repo"
        echo ""

        if [ -f "$cache_path/$name-$version.tgz" ]; then
            echo "✅ Dependency exists in cache..."
        else
            echo "🤷‍♂️ Dependency does not exists in cache..."

            repo_url="$repo/index.yaml"
            echo "🤖 Calculating URL..."
            dep_url=$(curl -s "$repo_url" | v="$version" n="$name" go-yq '.entries.[env(n)].[] | select (.version == env(v)) | .urls.[0]')

            echo ""
            echo "⏬ Downloading dependency $name-$version from $dep_url..."
            wget --quiet "$dep_url" -P "$cache_path/"
            if [ ! $? ]; then
                echo "❌ wget encountered an error..."
                helm dependency build "$chart/Chart.yaml" || helm dependency update "$chart/Chart.yaml" || exit 1
            fi

            if [ -f "$cache_path/$name-$version.tgz" ]; then
                echo "✅ Dependency Downloaded!"
            else
                echo "❌ Failed to download dependency"
                # Try helm dependency build/update or otherwise fail fast if a dep fails to download...
                helm dependency build "$chart/Chart.yaml" || helm dependency update "$chart/Chart.yaml" || exit 1
            fi
        fi
        echo ""

        mkdir -p "$chart/charts"
        echo "📝 Copying dependency <$name-$version.tgz> to <$chart/charts>..."
        cp "$cache_path/$name-$version.tgz" "$chart/charts"

        if [ -f "$cache_path/$name-$version.tgz" ]; then
            echo "✅ Dependency copied!"
            echo ""
        else
            echo "❌ Failed to copy dependency"
            # Try helm dependency build/update or otherwise fail fast if a dep fails to copy...
            ehelm dependency build "$chart/Chart.yaml" || helm dependency update "$chart/Chart.yaml" || exit 1
        fi
    fi
done
}
export -f download_deps

if [[ -d "charts/${1}" ]]; then
    echo "Start processing charts/${1} ..."
    chartversion=$(cat charts/${1}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
    chartname=$(basename charts/${1})
    train=$(basename $(dirname "charts/${1}"))
    SCALESUPPORT=$(cat charts/${1}/Chart.yaml | yq '.annotations."truecharts.org/SCALE-support"' -r)
    download_deps "charts/${1}" "${chartname}" "$train" "${chartversion}"
    helm dependency build "charts/${1}" --skip-refresh || (sleep 10 && helm dependency build "charts/${1}" --skip-refresh) || (sleep 10 && helm dependency build "charts/${1}" --skip-refresh)
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
