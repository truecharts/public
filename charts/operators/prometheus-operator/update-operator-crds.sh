#!/usr/bin/env bash
#
# Description: Update CRDs from upstream.
#

set -u -o pipefail

if [[ $# -ne 1 ]] ; then
  echo "usage $(basename "$0") <version>"
  exit 1
fi
version="$1"

annotation_sed='/^  annotations:$/a {{- with .Values.crds.annotations }}\n{{- toYaml . | nindent 4 }}\n{{- end }}'

crds="alertmanagerconfigs alertmanagers podmonitors probes prometheusagents prometheuses prometheusrules scrapeconfigs servicemonitors thanosrulers"

upstream="https://raw.githubusercontent.com/prometheus-operator/prometheus-operator"

for crd in ${crds} ; do
  echo "Updating ${crd}"
  url="${upstream}/${version}/example/prometheus-operator-crd/monitoring.coreos.com_${crd}.yaml"
  target="templates/crds/crd-${crd}.yaml"

  if [[ ! -f "${target}" ]] ; then
    echo "CRD target (${target}) file missing, this script should be run from the base of the chart"
    exit 1
  fi

  curl -sf "${url}" \
   | sed "1i # ${url}" \
   | sed "${annotation_sed}" \
   > "${target}"
done
