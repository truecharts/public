#!/bin/bash

curr_chart=$1

if [ -z "$curr_chart" ]
then
    echo "No chart name provided"
    exit 1
fi

echo "Chart name: $curr_chart"

if [[ "$curr_chart" == "charts/enterprise/metallb-config" ]]; then
    echo "Installing metallb chart"
    helm install metallb oci://tccr.io/truecharts/metallb --namespace metallb --create-namespace --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install metallb chart"
        exit 1
    fi
    echo "Done installing metallb chart"
fi


if [[ "$curr_chart" == "charts/enterprise/clusterissuer" ]]; then
    echo "Installing cert-manager chart"
    helm install cert-manager oci://tccr.io/truecharts/cert-manager --namespace cert-manager --create-namespace --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install cert-manager chart"
        exit 1
    fi
    echo "Done installing cert-manager chart"
fi

if [[ "$curr_chart" != "charts/operators/cloudnative-pg" ]]; then
    echo "Installing cloudnative-pg chart"
    helm install cloudnative-pg oci://tccr.io/truecharts/cloudnative-pg --namespace cloudnative-pg --create-namespace --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install cloudnative-pg chart"
        exit 1
    fi
    echo "Done installing cloudnative-pg chart"
fi

if [[ "$curr_chart" != "charts/operators/grafana-agent-operator" ]]; then
    echo "Installing Grafana-Agent-Operator chart"
	TODO Enable later
    helm install prometheus-operator oci://tccr.io/truecharts/grafana-agent-operator --namespace grafana-agent-operator --create-namespace --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install grafana-agent-operator chart"
        exit 1
    fi
    echo "Done installing grafana-agent-operator chart"
fi

if [[ "$curr_chart" != "charts/enterprise/traefik" ]]; then
   echo "Installing traefik chart"
   helm install traefik oci://tccr.io/truecharts/traefik --namespace traefik --create-namespace --wait \
     --set "service.main.type=ClusterIP" --set "service.tcp.type=ClusterIP"
   if [[ "$?" != "0" ]]; then
       echo "Failed to install traefik chart"
       exit 1
   fi
   echo "Done installing traefik chart"
fi
