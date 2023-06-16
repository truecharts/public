{{/* Define the secret */}}
{{- define "mcrouter.secret" -}}
{{- $mcrouter := .Values.mcrouter -}}
{{- $mappings := list }}
{{- range $item := $mcrouter.host_minecraft }}
  {{- $mappings = mustAppend $mappings $item.host_minecraft_service}}
{{- end }}
enabled: true
data:
  PORT: {{ .Values.service.main.ports.main.port quote }}
  API_BINDING: {{ .Values.service.api.ports.api.port | quote }}
  MAPPING: {{ join "," $mappings | quote }}
{{- end -}}
