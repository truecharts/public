{{/*
Retrieve ports configuration for container
*/}}
{{- define "common.containers.configurePorts" -}}
{{- if .ports -}}
ports:
{{- range $index, $port := .ports -}}
{{- include "common.schema.validateKeys" (dict "values" $port "checkKeys" (list "protocol" "containerPort")) }}
- protocol: {{ $port.protocol }}
  containerPort: {{ $port.containerPort }}
  {{ if hasKey $port "hostPort" }}hostPort: {{ $port.hostPort }}{{ end }}
  {{ if hasKey $port "name" }}name: {{ $port.name }}{{ end }}
{{- end -}}
{{- end -}}
{{- end -}}
