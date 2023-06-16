{{/* Define the secret */}}
{{- define "mcrouter.secret" -}}
{{- $mcrouter := .Values.mcrouter -}}
{{- $mappings := list }}
{{- range $item := $mcrouter.mapping }}
  {{- $mappings = mustAppend $mappings $item.domain_ip_port}}
{{- end }}
enabled: true
data:
  PORT: {{ .Values.service.main.ports.main.port }}
  API_BINDING: {{ .Values.service.api.ports.api.port }}
  MAPPING: {{ join "," $mappings | quote }}
{{- end -}}
