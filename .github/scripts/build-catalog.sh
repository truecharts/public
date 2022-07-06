#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

include_questions(){
    local chart="$1"
    local chartname="$2"
    local train="$3"
    local chartversion="$4"
    local target="catalog/${train}/${chartname}/${chartversion}"
    echo "Including standardised questions.yaml includes for: ${chartname}"

    # Replace # Include{global} with the standard global codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{global}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/global.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{groups} with the standard groups codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{groups}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/groups.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{fixedEnv} with the standard fixedEnv codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{fixedEnv}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/fixedEnv.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{controllerExpert} with the standard controllerExpert codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{controllerExpert}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/controllerExpert.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{controllerExpertCommand} with the standard controllerExpertCommand codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{controllerExpertCommand}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/controllerExpertCommand.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{containerConfig} with the standard containerConfig codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{containerConfig}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/containerConfig.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{serviceSelector} with the standard serviceSelector codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{serviceSelector}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/serviceSelector.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{serviceExpert} with the standard serviceExpert codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{serviceExpert}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/serviceExpert.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{serviceList} with the standard serviceList codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{serviceList}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/serviceList.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{persistenceBasic} with the standard persistenceBasic codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{persistenceBasic}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/persistenceBasic.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{persistenceAdvanced} with the standard persistenceAdvanced codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{persistenceAdvanced}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/persistenceAdvanced.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{persistenceList} with the standard persistenceList codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{persistenceList}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/persistenceList.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{security} with the standard security codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{security}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/security.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{securityContextAdvanced} with the standard securityContextAdvanced codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{securityContextAdvanced}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/securityContextAdvanced.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{podSecurityContextAdvanced} with the standard podSecurityContextAdvanced codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{podSecurityContextAdvanced}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/podSecurityContextAdvanced.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{ingressDefault} with the standard ingressDefault codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{ingressDefault}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/ingressDefault.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{ingressTLS} with the standard ingressTLS codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{ingressTLS}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/ingressTLS.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{ingressTraefik} with the standard ingressTraefik codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{ingressTraefik}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/ingressTraefik.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{ingressExpert} with the standard ingressExpert codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{ingressExpert}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/ingressExpert.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{ingressList} with the standard ingressList codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{ingressList}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/ingressList.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{addons} with the standard addons codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{addons}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/addons.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{metrics} with the standard metrics codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{metrics}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/metrics.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{metrics3m} with the standard metrics3m codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{metrics3m}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/metrics3m.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{metrics60m} with the standard metrics60m codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{metrics60m}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/metrics60m.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{prometheusRule} with the standard prometheusRule codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{prometheusRule}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/prometheusRule.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{advanced} with the standard advanced codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{advanced}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/advanced.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{resources} with the standard resources codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{resources}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/resources.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

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
    echo "Cleaning SCALE catalog for App: ${chartname}"
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
    echo "Applying SCALE patches for App: ${chartname}"
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
    # Generate item.yaml
    cat ${target}/Chart.yaml | grep "icon" >> catalog/${train}/${chartname}/item.yaml
    sed -i "s|^icon:|icon_url:|g" catalog/${train}/${chartname}/item.yaml
    echo "categories:" >> catalog/${train}/${chartname}/item.yaml
    cat ${target}/Chart.yaml | yq '.annotations."truecharts.org/catagories"' -r >> catalog/${train}/${chartname}/item.yaml
    # Generate SCALE App description file
    cat ${target}/Chart.yaml | yq .description -r >> ${target}/app-readme.md
    echo "" >> ${target}/app-readme.md
    echo "This App is supplied by TrueCharts, for more information please visit https://truecharts.org" >> ${target}/app-readme.md
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
