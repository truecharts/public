{{/* Define the secret */}}
{{- define "pmm.secret" -}}

{{- $pmm := .Values.pmm }}
enabled: true
data:
  {{/* PMM */}}
  PMM_CONFIG: "/config/config.yml"
  {{- if not $pmm.run }}
  PMM_TIME: {{ join "," $pmm.times | quote }}
  PMM_NO_COUNTDOWN: {{ $pmm.no_countdown | quote }}
  {{- end }}
  PMM_RUN: {{ $pmm.run | quote }}
  {{/* plex */}}
  PMM_PLEX_URL: {{ $pmm.plex_url | quote }}
  PMM_PLEX_TOKEN: {{ $pmm.plex_token | quote }}
{{- end -}}
