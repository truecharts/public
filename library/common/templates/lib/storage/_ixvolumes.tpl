{{/*
Retrieve host path from ix volumes based on dataset name
*/}}
{{- define "common.retrieveHostPathFromiXVolume" -}}
{{- range $index, $hostPathConfiguration := $.ixVolumes }}
{{- $dsName := base $hostPathConfiguration.hostPath -}}
{{- if eq $.datasetName $dsName -}}
{{- $hostPathConfiguration.hostPath -}}
{{- end -}}
{{- end }}
{{- end -}}

{{/*
Retrieve host path from ix volumes based on a key
*/}}
{{- define "common.configuredHostPath" -}}
{{- $values := . -}}
{{- if $values.hostPathEnabled -}}
{{- include "common.validateKeys" (dict "values" $values "checkKeys" (list "pathField")) -}}
{{- $values.pathField -}}
{{- else -}}
{{- include "common.validateKeys" (dict "values" $values "checkKeys" (list "datasetName" "ixVolumes")) -}}
{{- include "common.retrieveHostPathFromiXVolume" (dict "datasetName" $values.datasetName "ixVolumes" $values.ixVolumes) -}}
{{- end -}}
{{- end -}}
