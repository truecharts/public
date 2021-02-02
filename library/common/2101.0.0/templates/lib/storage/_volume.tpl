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
{{- define "common.storage.volumeConfig" -}}
{{- $values := . -}}
{{- include "common.schema.validateKeys" (dict "values" $values "checkKeys" (list "name")) -}}
{{- if $values.emptyDirVolumes -}}
- name: {{ $values.name }}
  emptyDir: {}
{{- else -}}
- name: {{ $values.name }}
  hostPath:
    path: {{ template "common.storage.configuredHostPath" $values }}
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
{{- define "common.storage.volumesConfiguration" -}}
{{- $values := . -}}
{{- include "common.schema.validateKeys" (dict "values" $values "checkKeys" (list "ixVolumes" "volumes")) -}}
{{- range $vol := $values.volumes -}}
{{- $_ := set $vol "ixVolumes" $values.ixVolumes -}}
{{- include "common.storage.volumeConfig" $vol | nindent 0 -}}
{{- end -}}
{{- end -}}
