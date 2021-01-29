{{/*
Render environment variables
*/}}
{{- define "common.containers.environmentVariables" -}}
{{- $values := . -}}
{{- include "common.schema.validateKeys" (dict "values" $values "checkKeys" (list "environmentVariables")) -}}
{{- range $envVariable := $values.environmentVariables -}}
{{- include "common.schema.validateKeys" (dict "values" $envVariable "checkKeys" (list "name" "value")) -}}
- name: {{ $envVariable.name }}
  value: {{ $envVariable.value }}
{{- end -}}
{{- end -}}
