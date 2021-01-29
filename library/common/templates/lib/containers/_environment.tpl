{{/*
Render environment variables
*/}}
{{- define "common.containers.environmentVariables" -}}
{{- $values := . -}}
{{- include "common.schema.validateKeys" (dict "values" $values "checkKeys" (list "environmentVariables")) -}}
{{- range $envVariable := $values.environmentVariables -}}
{{- include "common.schema.validateKeys" (dict "values" $envVariable "checkKeys" (list "name")) -}}
- name: {{ $envVariable.name }}
{{- if $envVariable.valueFromSecret -}}
{{- include "common.schema.validateKeys" (dict "values" $envVariable "checkKeys" (list "secretName" "secretKey")) -}}
  valueFrom:
    secretKeyRef:
      name: {{ $envVariable.secretName }}
      key: {{ $envVariable.secretKey }}
{{- else -}}
{{- include "common.schema.validateKeys" (dict "values" $envVariable "checkKeys" (list "value")) -}}
  value: {{ $envVariable.value }}
{{- end -}}
{{- end -}}
{{- end -}}
