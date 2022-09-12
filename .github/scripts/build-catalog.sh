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

    # Replace # Include{portalLink} with the standard portalLink codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{portalLink}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/portalLink.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

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

     # Replace # Include{controller} with the standard controller codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{controller}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/controller/controller.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{controllerDeployment} with the standard controllerDeployment codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{controllerDeployment}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/controller/controllerDeployment.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{controllerStatefullset} with the standard controllerStatefullset codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{controllerStatefullset}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/controller/controllerStatefullset.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{controllerDaemonset} with the standard controllerDaemonset codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{controllerDaemonset}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/controller/controllerDaemonset.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{replicas} with the standard replicas codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{replicas}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/replicas/replicas.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{replica1} with the standard replica1 codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{replica1}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/replicas/replica1.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{replica2} with the standard replica2 codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{replica2}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/replicas/replica2.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{replica3} with the standard replica3 codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{replica3}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/replicas/replica3.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{strategy} with the standard strategy codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{strategy}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/strategy/strategy.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{recreate} with the standard recreate codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{recreate}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/strategy/recreate.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{rollingupdate} with the standard rollingupdate codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{rollingupdate}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/strategy/rollingupdate.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{controllerTypes} with the standard controllerTypes codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{controllerTypes}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/controllerTypes.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{controllerExpert} with the standard controllerExpert codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{controllerExpert}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/controller/controllerExpert.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{controllerExpertExtraArgs} with the standard controllerExpertExtraArgs codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{controllerExpertExtraArgs}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/controller/controllerExpertExtraArgs.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

     # Replace # Include{controllerExpertCommand} with the standard controllerExpertCommand codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{controllerExpertCommand}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/controller/controllerExpertCommand.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{containerConfig} with the standard containerConfig codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{containerConfig}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/containerConfig.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{serviceRoot} with the standard serviceRoot codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{serviceRoot}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/service/serviceRoot.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{serviceSelectorExtras} with the standard serviceSelectorExtras codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{serviceSelectorExtras}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/service/serviceSelectorExtras.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{serviceSelectorSimple} with the standard serviceSelectorSimple codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{serviceSelectorSimple}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/service/serviceSelectorSimple.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{serviceSelectorClusterIP} with the standard serviceSelectorClusterIP codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{serviceSelectorClusterIP}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/service/serviceSelectorClusterIP.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{serviceSelectorLoadBalancer} with the standard serviceSelectorLoadBalancer codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{serviceSelectorLoadBalancer}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/service/serviceSelectorLoadBalancer.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{serviceSelectorNodePort} with the standard serviceSelectorNodePort codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{serviceSelectorNodePort}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/service/serviceSelectorNodePort.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{advancedPortHTTP} with the standard advancedPortHTTP codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{advancedPortHTTP}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/advancedPortHTTP.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{advancedPortHTTPS} with the standard advancedPortHTTPS codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{advancedPortHTTPS}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/advancedPortHTTPS.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{advancedPortTCP} with the standard advancedPortTCP codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{advancedPortTCP}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/advancedPortTCP.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{advancedPortUDP} with the standard advancedPortUDP codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{advancedPortUDP}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/advancedPortUDP.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{serviceExpertRoot} with the standard serviceExpertRoot codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{serviceExpertRoot}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/service/serviceExpertRoot.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{serviceExpert} with the standard serviceExpert codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{serviceExpert}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/service/serviceExpert.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{serviceList} with the standard serviceList codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{serviceList}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/service/serviceList.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{vctRoot} with the standard vctRoot codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{vctRoot}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/vctRoot.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{persistenceRoot} with the standard persistenceRoot codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{persistenceRoot}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/persistence/persistenceRoot.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{persistenceBasic} with the standard persistenceBasic codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{persistenceBasic}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/persistence/persistenceBasic.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{persistenceAdvanced} with the standard persistenceAdvanced codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{persistenceAdvanced}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/persistence/persistenceAdvanced.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{persistenceList} with the standard persistenceList codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{persistenceList}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/persistence/persistenceList.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{security} with the standard security codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{security}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/security.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{securityContextAdvancedRoot} with the standard securityContextAdvancedRoot codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{securityContextAdvancedRoot}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/securityContextAdvancedRoot.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{securityContextAdvanced} with the standard securityContextAdvanced codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{securityContextAdvanced}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/securityContextAdvanced.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{podSecurityContextRoot} with the standard podSecurityContextRoot codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{podSecurityContextRoot}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/podSecurityContextRoot.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{podSecurityContextAdvanced} with the standard podSecurityContextAdvanced codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{podSecurityContextAdvanced}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/podSecurityContextAdvanced.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{ingressRoot} with the standard ingressRoot codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{ingressRoot}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/ingress/ingressRoot.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{ingressDefault} with the standard ingressDefault codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{ingressDefault}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/ingress/ingressDefault.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{ingressTLS} with the standard ingressTLS codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{ingressTLS}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/ingress/ingressTLS.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{ingressTraefik} with the standard ingressTraefik codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{ingressTraefik}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/ingress/ingressTraefik.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{ingressExpert} with the standard ingressExpert codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{ingressExpert}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/ingress/ingressExpert.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{ingressList} with the standard ingressList codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{ingressList}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/ingress/ingressList.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{addons} with the standard addons codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{addons}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/addons.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{metrics} with the standard metrics codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{metrics}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/metrics/metrics.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{metrics3m} with the standard metrics3m codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{metrics3m}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/metrics/metrics3m.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{metrics60m} with the standard metrics60m codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{metrics60m}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/metrics/metrics60m.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

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

    # Replace # Include{documentation} with the standard documentation codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{documentation}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/documentation.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{[forwardedHeaders]} with the standard forwardedHeaders codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{forwardedHeaders}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/traefik/forwardedHeaders.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

    # Replace # Include{proxyProtocol} with the standard proxyProtocol codesnippet
    awk 'NR==FNR { a[n++]=$0; next }
    /# Include{proxyProtocol}/ { for (i=0;i<n;++i) print a[i]; next }
    1' templates/questions/traefik/proxyProtocol.yaml ${target}/questions.yaml > "tmp${chartname}" && mv "tmp${chartname}" ${target}/questions.yaml

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
