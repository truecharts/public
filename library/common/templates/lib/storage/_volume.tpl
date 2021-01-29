{{/*
Retrieve volume configuration

This expects a dictionary in the following format:
{
    "name": string,
    "emptyDirVolumes": boolean,
    "ixVolumes": list,
    "hostPathEnabled": boolean,
    "pathField": string,
    "datasetName": string,
}
*/}}
{{- define "common.volumeConfig" -}}
{{- $values := . -}}
{{- include "common.validateKeys" (dict "values" $values "checkKeys" (list "name")) -}}
- name: {{ $values.name }}
{{- if $values.emptyDirVolumes -}}
  emptyDir: {}
{{- else -}}
  hostPath:
    path: {{ template "common.configuredHostPath" $values }}
{{- end -}}
{{- end -}}


{{/*
Retrieve configuration for volumes

This expects a dictionary to be provided in the following format:
{
    "ixVolumes": list,
    "volumes": [
        {
            "name": string,
            "emptyDirVolumes": boolean,
            "hostPathEnabled": boolean,
            "pathField": string,
            "datasetName": string,
        }
    ] ( list of dicts )
}
*/}}
{{- define "common.volumesConfiguration" -}}
{{- $values := . -}}
{{- include "common.validateKeys" (dict "values" $values "checkKeys" (list "ixVolumes" "volumes")) -}}
{{- range $vol := $values.volumes -}}
{{- $_ := set $vol "ixVolumes" $values.ixVolumes -}}
{{- include "common.volumeConfig" $vol -}}
{{- end -}}
{{- end -}}
