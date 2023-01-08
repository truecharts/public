{{/* Define the secret */}}
{{- define "pmm.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}
{{- $pmm := .Values.pmm -}}
{{- $times := list }}
{{- with $pmm.time -}}
  {{- range . -}}
    {{- $times = append $times . -}}
  {{- end -}}
{{- end }}
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
  PMM_TIME: {{ join "," $times | quote }}
  {{- with $pmm.run }}
  PMM_RUN: {{ . | quote }}
  {{- end }}
  {{- with $pmm.no_countdown }}
  PMM_NO_COUNTDOWN: {{ . | quote }}
  {{- end }}

  {{/* plex */}}
  {{- with $pmm.plex_url }}
  PMM_PLEX_URL: {{ . | quote }}
  {{- end }}
  {{- with $pmm.plex_token }}
  PMM_PLEX_TOKEN: {{ . | quote }}
  {{- end }}


{{- end -}}
