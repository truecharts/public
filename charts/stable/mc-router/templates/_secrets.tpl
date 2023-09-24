{{/* Define the secrets */}}
{{- define "mcrouter.secrets" -}}

{{- $mcrouter := .Values.mcrouter }}

{{- $mappings := list -}}
{{- range $id, $value := $mcrouter.mappings -}}
  {{- if $value -}}
    {{ $mappings = mustAppend $mappings (printf "%s=%s" $value.domain $value.service) }}
  {{- end -}}
{{- end -}}

enabled: true
data:
  MAPPING: {{ $mappings }}
  PORT: {{ .Values.service.main.ports.main.port }}
  API_BINDING: {{ printf ":%v" .Values.service.api.ports.api.port }}
  {{- with $mcrouter.default }}
  DEFAULT: {{ . | quote }}
  {{- end }}
  {{- with $mcrouter.ngrok }}
  NGROK_TOKEN: {{ . | quote }}
  {{- end }}
{{- end -}}
