{{/* Define the secrets */}}
{{- define "mcrouter.secrets" -}}
{{- $secretName := (printf "%s-mcrouter-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $mcrouter := .Values.mcrouter }}
{{- $mainPort := .Values.service.main.ports.main.port }}
{{- $apiPort := .Values.service.api.ports.api.port }}

{{- $mappings := list -}}
{{- range $id, $value := $mcrouter.mappings -}}
  {{- if $value -}}
    {{ $mappings = mustAppend $mappings (printf "%s=%s" $value.domain $value.service) }}
  {{- end -}}
{{- end -}}

enabled: true
data:
  MAPPING: {{ join "," $mappings }}
  PORT: {{ $mainPort }}
  API_BINDING: {{ printf ":%v" $apiPort }}
  {{- with $mcrouter.default }}
  DEFAULT: {{ . | quote }}
  {{- end }}
  {{- with $mcrouter.ngrok }}
  NGROK_TOKEN: {{ . | quote }}
  {{- end }}
{{- end -}}
