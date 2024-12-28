#!/bin/bash

curr_chart=$1

if [ -z "$curr_chart" ]; then
    echo "No chart name provided"
    exit 1
fi

echo "Chart name: $curr_chart"
values_yaml=$(cat "$curr_chart/values.yaml")
cnpg_enabled=$(go-yq '.cnpg | map(.enabled) | any' <<<"$values_yaml")
ingress_required=$(go-yq '.ingress | map(.required) | any' <<<"$values_yaml")
ingress_enabled=$(go-yq '.ingress | map(.enabled) | any' <<<"$values_yaml")
traefik_needed="false"
if [[ "$ingress_required" == "true" ]] || [[ "$ingress_enabled" == "true" ]]; then
    traefik_needed="true"
else
    for ci_values in "$curr_chart"/ci/*values.yaml; do
        ci_values_yaml=$(cat "$ci_values")
        ingress_enabled=$(go-yq '.ingress | map(.enabled) | any' <<<"$ci_values_yaml")
        if [[ "$ingress_enabled" == "true" ]]; then
            traefik_needed="true"
            break
        fi
    done
fi

if [[ "$curr_chart" != "charts/system/prometheus-operator" ]]; then
    echo "Installing prometheus-operator chart"
    helm install prometheus-operator oci://tccr.io/truecharts/prometheus-operator --namespace prometheus-operator --create-namespace --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install prometheus-operator chart"
        exit 1
    fi
    echo "Done installing prometheus-operator chart"
fi

if [[ "$curr_chart" == "charts/premium/traefik" ]]; then
    helm install traefik oci://tccr.io/truecharts/traefik-crds --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install traefik-crds chart"
    fi
    echo "Done installing traefik-crds chart"
fi

if [[ "$curr_chart" != "charts/premium/traefik" ]] && [[ $traefik_needed == "true" ]]; then
    echo "Installing traefik chart"
    helm install traefik oci://tccr.io/truecharts/traefik --namespace traefik --create-namespace \
        --set service.tcp.ports.web.port=9080 --set service.tcp.ports.websecure.port=9443 --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install traefik chart"
        exit 1
    fi
    echo "Done installing traefik chart"
fi

if [[ "$curr_chart" == "charts/premium/volsync" ]]; then
    echo "Installing volumesnapshots chart"
    helm install volumesnapshots oci://tccr.io/truecharts/volumesnapshots --namespace volumesnapshots --create-namespace --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install volumesnapshots chart"
        exit 1
    fi
    echo "Done installing volumesnapshots chart"
fi

if [[ "$curr_chart" == "charts/premium/metallb-config" ]]; then
    echo "Installing metallb chart"
    helm install metallb oci://tccr.io/truecharts/metallb --namespace metallb --create-namespace --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install metallb chart"
        exit 1
    fi
    echo "Done installing metallb chart"
fi

if [[ "$curr_chart" == "charts/premium/clusterissuer" ]]; then
    echo "Installing cert-manager chart"
    helm install cert-manager oci://tccr.io/truecharts/cert-manager --namespace cert-manager --create-namespace --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install cert-manager chart"
        exit 1
    fi
    echo "Done installing cert-manager chart"
fi

if [[ "$cnpg_enabled" == "true" ]]; then
    echo "Installing cloudnative-pg chart"
    helm install cloudnative-pg oci://tccr.io/truecharts/cloudnative-pg --namespace cloudnative-pg --create-namespace --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install cloudnative-pg chart"
        exit 1
    fi
    echo "Done installing cloudnative-pg chart"
fi

if [[ "$curr_chart" == "charts/system/intel-device-plugins-operator" ]]; then
    echo "Installing cert-manager chart"
    helm install cert-manager oci://tccr.io/truecharts/cert-manager --namespace cert-manager --create-namespace --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install cert-manager chart"
        exit 1
    fi
    echo "Done installing cert-manager chart"
fi

if [[ "$curr_chart" == "charts/premium/kubernetes-dashboard" ]]; then
    echo "Installing metrics-server chart"
    helm install metrics-server oci://tccr.io/truecharts/metrics-server --namespace metrics-server --create-namespace --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install metrics-server chart"
        exit 1
    fi
    echo "Done installing metrics-server chart"
fi
