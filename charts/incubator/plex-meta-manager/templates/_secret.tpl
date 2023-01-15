{{/* Define the secret */}}
{{- define "pmm.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}
{{- $pmm := .Values.pmm -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
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
