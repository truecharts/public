{{/* Define the secret */}}
{{- define "mcrouter.secret" -}}
{{- $mcrouter := .Values.mcrouter -}}
{{- $mappings := list }}
{{- range $item := $mcrouter.mapping }}
  {{- $mappings = mustAppend $mappings $item.domain_ip_port}}
{{- end }}
enabled: true
data:
  MAPPING: {{ join "," $mappings | quote }}
{{- end -}}
