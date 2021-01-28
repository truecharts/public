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
{{- if and (hasKey $values "hostPathEnabled") (hasKey $values "pathField") -}}
{{- end -}}
{{- if $values.hostPathEnabled -}}
{{- if hasKey $values "pathField" -}}
{{- $values.pathField -}}
{{- else -}}
{{- fail "Path must be specified when host path is enabled" -}}
{{- end -}}
{{- else if and (hasKey $values "datasetName") (hasKey $values "ixVolumes") -}}
{{- $volDict := dict "datasetName" $values.datasetName "ixVolumes" $values.ixVolumes -}}
{{- include "common.retrieveHostPathFromiXVolume" $volDict -}}
{{- else -}}
{{- fail "Dataset name and ix volumes must be specified" -}}
{{- end -}}
{{- end -}}

