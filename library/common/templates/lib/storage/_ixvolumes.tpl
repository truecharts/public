{{/*
Retrieve host path from ix volumes based on dataset name
*/}}
{{- define "common.storage.retrieveHostPathFromiXVolume" -}}
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
{{- define "common.storage.configuredHostPath" -}}
{{- $values := . -}}
{{- if $values.hostPathEnabled -}}
{{- include "common.schema.validateKeys" (dict "values" $values "checkKeys" (list "pathField")) -}}
{{- $values.pathField -}}
{{- else -}}
{{- include "common.schema.validateKeys" (dict "values" $values "checkKeys" (list "datasetName" "ixVolumes")) -}}
{{- include "common.storage.retrieveHostPathFromiXVolume" (dict "datasetName" $values.datasetName "ixVolumes" $values.ixVolumes) -}}
{{- end -}}
{{- end -}}
