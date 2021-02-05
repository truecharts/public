{{/*
Render environment variable
*/}}
{{- define "common.containers.environmentVariable" -}}
{{- $envVariable := . -}}
{{- include "common.schema.validateKeys" (dict "values" $envVariable "checkKeys" (list "name")) -}}
{{- if $envVariable.valueFromSecret -}}
{{- include "common.schema.validateKeys" (dict "values" $envVariable "checkKeys" (list "secretName" "secretKey")) -}}
- name: {{ $envVariable.name }}
  valueFrom:
    secretKeyRef:
      name: {{ $envVariable.secretName }}
      key: {{ $envVariable.secretKey }}
{{- else -}}
{{- include "common.schema.validateKeys" (dict "values" $envVariable "checkKeys" (list "value")) -}}
- name: {{ $envVariable.name }}
  value: {{ $envVariable.value }}
{{- end -}}
{{- end -}}

{{/*
Render environment variables
*/}}
{{- define "common.containers.environmentVariables" -}}
{{- $values := . -}}
{{- include "common.schema.validateKeys" (dict "values" $values "checkKeys" (list "environmentVariables")) -}}
{{- range $envVariable := $values.environmentVariables -}}
{{- include "common.containers.environmentVariable" $envVariable | nindent 0 -}}
{{- end -}}
{{- end -}}

{{/*
Render environment variables if present
*/}}
{{- define "common.containers.allEnvironmentVariables" -}}
{{- $values := . -}}
{{- include "common.schema.validateKeys" (dict "values" $values "checkKeys" (list "environmentVariables")) -}}
{{- if $values.environmentVariables -}}
env: {{- include "common.containers.environmentVariables" $values | nindent 2 -}}
{{- end -}}
{{- end -}}
