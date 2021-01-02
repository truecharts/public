{{/*
Retrieve host path from ix volumes based on dataset name
*/}}
{{- define "retrieveHostPathFromiXVolume" -}}
{{- range $index, $hostPathConfiguration := $.ixVolumes }}
{{- $dsName := base $hostPathConfiguration.hostPath -}}
{{- if eq $.datasetName $dsName -}}
{{- $hostPathConfiguration.hostPath -}}
{{- end -}}
{{- end }}
{{- end -}}

{{/*
Retrieve host path for downloads
Let's please remove the redundancy
*/}}
{{- define "configuredHostPathdownloads" -}}
{{- if .Values.downloadsHostPathEnabled -}}
{{- .Values.downloadsHostPath -}}
{{- else -}}
{{- $volDict := dict "datasetName" $.Values.downloadsVolume.datasetName "ixVolumes" $.Values.ixVolumes -}}
{{- include "retrieveHostPathFromiXVolume" $volDict -}}
{{- end -}}
{{- end -}}

{{/*
Retrieve host path for data
Let's please remove the redundancy
*/}}
{{- define "configuredHostPathData" -}}
{{- if .Values.dataHostPathEnabled -}}
{{- .Values.dataHostPath -}}
{{- else -}}
{{- $volDict := dict "datasetName" $.Values.dataVolume.datasetName "ixVolumes" $.Values.ixVolumes -}}
{{- include "retrieveHostPathFromiXVolume" $volDict -}}
{{- end -}}
{{- end -}}

{{/*
Retrieve host path for downloads
Let's please remove the redundancy
*/}}
{{- define "configuredHostPathConfig" -}}
{{- if .Values.configHostPathEnabled -}}
{{- .Values.configHostPath -}}
{{- else -}}
{{- $volDict := dict "datasetName" $.Values.configVolume.datasetName "ixVolumes" $.Values.ixVolumes -}}
{{- include "retrieveHostPathFromiXVolume" $volDict -}}
{{- end -}}
{{- end -}}
