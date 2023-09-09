{{/* Define the secrets */}}
{{- define "mcrouter.secrets" -}}
{{- $mcrouter := .Values.mcrouter }}

enabled: true
data:
  MAPPING: {{ join "," $mcrouter.host_minecraft }}
{{- end -}}
