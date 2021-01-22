{{/*
Retrieve host path from ix volumes based on dataset name
*/}}
{{- define "retrieveDataPathFromiXVolume" -}}
{{- range $index, $hostPathConfiguration := $.ixVolumes }}
{{- $dsName := base $hostPathConfiguration.hostPath -}}
{{- if eq $.datasetName $dsName -}}
{{- $hostPathConfiguration.hostPath -}}
{{- end -}}
{{- end }}
{{- end -}}

{{/*
Retrieve host path for ipfs
*/}}
{{- define "configuredDataHostPath" -}}
{{- if .Values.ipfsDataHostPathEnabled -}}
{{- .Values.ipfsDataHostPath -}}
{{- else -}}
{{- $volDict := dict "datasetName" $.Values.ipfsDataVolume.datasetName "ixVolumes" $.Values.ixVolumes -}}
{{- include "retrieveHostPathFromiXVolume" $volDict -}}
{{- end -}}
{{- end -}}

{{/*
Retrieve host path for ipfs
*/}}
{{- define "configuredStagingHostPath" -}}
{{- if .Values.ipfsStagingHostPathEnabled -}}
{{- .Values.ipfsStagingHostPath -}}
{{- else -}}
{{- $volDict := dict "datasetName" $.Values.ipfsStagingVolume.datasetName "ixVolumes" $.Values.ixVolumes -}}
{{- include "retrieveHostPathFromiXVolume" $volDict -}}
{{- end -}}
{{- end -}}
