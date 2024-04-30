{{/* Define the secret */}}
{{- define "kometa.secret" -}}

{{- $kometa := .Values.kometa }}
enabled: true
data:
  {{/* KOMETA */}}
  KOMETA_CONFIG: "/config/config.yml"
  {{- if not $kometa.run }}
  KOMETA_TIMES: {{ join "," $kometa.times | quote }}
  KOMETA_NO_COUNTDOWN: {{ $kometa.no_countdown | quote }}
  {{- end }}
  KOMETA_RUN: {{ $kometa.run | quote }}
  {{/* plex */}}
  KOMETA_PLEX_URL: {{ $kometa.plex_url | quote }}
  KOMETA_PLEX_TOKEN: {{ $kometa.plex_token | quote }}
{{- end -}}
