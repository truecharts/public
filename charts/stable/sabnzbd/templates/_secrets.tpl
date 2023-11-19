{{/* Define the secrets */}}
{{- define "sabnzbd.secrets" -}}

{{- $apiKey := "" }}
{{- if eq .Values.sabnzbd.api_key.enabled true }}
{{- $apiKey = required "API Key is required" .Values.sabnzbd.api_key.secret | quote }}
{{- end -}}

enabled: true
data:
  placeholder: placeholdervalue
  {{- if ne $apiKey "" }}
  SABNZBD__API_KEY: {{ $apiKey }}
  {{- end }}
{{- end -}}
