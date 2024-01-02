#!/bin/bash

helm repo add truecharts-deps https://deps.truecharts.org
helm repo add jetstack https://charts.jetstack.io
helm repo add vmwaretanzu https://vmware-tanzu.github.io/helm-charts
helm repo add cnpg https://cloudnative-pg.github.io/charts
helm repo add metallb https://metallb.github.io/metallb
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add openebs https://openebs.github.io/charts
helm repo add csi-driver-smb https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/charts
helm repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
helm repo update
