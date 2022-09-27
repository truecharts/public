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

prep_helm() {
    if [[ -z "$standalone" ]]; then
    helm repo add truecharts-old https://truecharts.org
    helm repo add truecharts https://charts.truecharts.org
    helm repo add truecharts-library https://library-charts.truecharts.org
    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm repo add metallb https://metallb.github.io/metallb
    helm repo add grafana https://grafana.github.io/helm-charts
    helm repo add prometheus https://prometheus-community.github.io/helm-charts
    helm repo add amd-gpu-helm https://radeonopencompute.github.io/k8s-device-plugin/
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
    cp -rf ${target}/SCALE/migrations/* ${target}/migrations 2>/dev/null || :
    rm -rf ${target}/SCALE 2>/dev/null || :
    touch ${target}/values.yaml
    # Remove documentation that is not required for the App to install
    rm -rf ${target}/security.md
    rm -rf ${target}/helm-values.md
    rm -rf ${target}/CONFIG.md
    rm -rf ${target}/docs
    rm -rf ${target}/icon.png
    # Generate item.yaml
    cat ${target}/Chart.yaml | grep "icon" >> catalog/${train}/${chartname}/item.yaml
    sed -i "s|^icon:|icon_url:|g" catalog/${train}/${chartname}/item.yaml
    echo "categories:" >> catalog/${train}/${chartname}/item.yaml
    cat ${target}/Chart.yaml | yq '.annotations."truecharts.org/catagories"' -r >> catalog/${train}/${chartname}/item.yaml
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

if [[ -d "charts/${1}" ]]; then
    echo "Start processing charts/${1} ..."
    chartversion=$(cat charts/${1}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
    chartname=$(basename charts/${1})
    train=$(basename $(dirname "charts/${1}"))
    SCALESUPPORT=$(cat charts/${1}/Chart.yaml | yq '.annotations."truecharts.org/SCALE-support"' -r)
    helm dependency update "charts/${1}" --skip-refresh || (sleep 10 && helm dependency update "charts/${1}" --skip-refresh) || (sleep 10 && helm dependency update "charts/${1}" --skip-refresh)
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
