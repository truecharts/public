#!/bin/bash

curr_chart=$1

if [ -z "$curr_chart" ]
then
    echo "No chart name provided"
    exit 1
fi

echo "Chart name: $curr_chart"


if [[ "$curr_chart" != "charts/system/prometheus-operator" ]]; then
    echo "Installing prometheus-operator chart"
    helm install prometheus-operator oci://tccr.io/truecharts/prometheus-operator --namespace prometheus-operator --create-namespace --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install prometheus-operator chart"
        exit 1
    fi
    echo "Done installing prometheus-operator chart"
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


if [[ "$curr_chart" != "charts/system/cloudnative-pg" ]]; then
    echo "Installing cloudnative-pg chart"
    helm install cloudnative-pg oci://tccr.io/truecharts/cloudnative-pg --namespace cloudnative-pg --create-namespace --wait
    if [[ "$?" != "0" ]]; then
        echo "Failed to install cloudnative-pg chart"
        exit 1
    fi
    echo "Done installing cloudnative-pg chart"
fi

if [[ "$curr_chart" != "charts/premium/traefik" ]]; then
   echo "Installing traefik chart"
   helm install traefik oci://tccr.io/truecharts/traefik --namespace traefik --create-namespace --wait \
     --set "service.main.type=ClusterIP" --set "service.tcp.type=ClusterIP"
   if [[ "$?" != "0" ]]; then
       echo "Failed to install traefik chart"
       exit 1
   fi
   echo "Done installing traefik chart"
fi
