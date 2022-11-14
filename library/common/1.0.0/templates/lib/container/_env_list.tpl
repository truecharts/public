{{/* Environment Variables List included by the container */}}
{{- define "ix.v1.common.container.envList" -}}
{{- $envList := .envList -}}
{{- $root := .root -}}
{{- with $envList -}}
  {{- range $envList -}}
  {{- if and .name .value -}}
      {{- if  or (kindIs "map" .name) (kindIs "slice" .name) -}}
        {{- fail "Name in envList cannot be a map or slice" -}}
      {{- end -}}
      {{- if  or (kindIs "map" .value) (kindIs "slice" .value) -}}
        {{- fail "Value in envList cannot be a map or slice" -}}
      {{- end }}
- name: {{ tpl .name $root }}
  value: {{ tpl .value $root | quote }}
  {{- else -}}
    {{- fail "Please specify both name and value for environment variable" -}}
  {{- end -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
A custom dict is expected with envList and root.
It's designed to work for mainContainer AND initContainers.
Calling this from an initContainer, wouldn't work, as it would have a different "root" context,
and "tpl" on "$" would cause erors.
That's why the custom dict is expected.
*/}}
