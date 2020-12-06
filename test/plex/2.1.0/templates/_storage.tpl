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
Retrieve host path for transcode
Let's please remove the redundancy
*/}}
{{- define "configuredHostPathTranscode" -}}
{{- if .Values.persistence.transcode.hostPathEnabled -}}
{{- .Values.persistence.transcode.hostPath -}}
{{- else -}}
{{- $volDict := dict "datasetName" $.Values.persistence.transcode.volume.datasetName "ixVolumes" $.Values.ixVolumes -}}
{{- include "retrieveHostPathFromiXVolume" $volDict -}}
{{- end -}}
{{- end -}}

{{/*
Retrieve host path for data
Let's please remove the redundancy
*/}}
{{- define "configuredHostPathData" -}}
{{- if .Values.persistence.data.hostPathEnabled -}}
{{- .Values.persistence.data.hostPath -}}
{{- else -}}
{{- $volDict := dict "datasetName" $.Values.persistence.data.volume.datasetName "ixVolumes" $.Values.ixVolumes -}}
{{- include "retrieveHostPathFromiXVolume" $volDict -}}
{{- end -}}
{{- end -}}

{{/*
Retrieve host path for transcode
Let's please remove the redundancy
*/}}
{{- define "configuredHostPathConfig" -}}
{{- if .Values.persistence.config.hostPathEnabled -}}
{{- .Values.persistence.config.hostPath -}}
{{- else -}}
{{- $volDict := dict "datasetName" $.Values.persistence.config.volume.datasetName "ixVolumes" $.Values.ixVolumes -}}
{{- include "retrieveHostPathFromiXVolume" $volDict -}}
{{- end -}}
{{- end -}}
