{{/* Define the secret */}}
{{- define "plexanisync.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}
{{- $pas := .Values.plexanisync -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  {{/* PLEX */}}
  PLEX_URL: {{ $pas.plex_url | quote }}
  PLEX_TOKEN: {{ $pas.plex_token | quote }}
  PLEX_EPISODE_COUNT_PRIORITY: {{ ternary "True" "False" $pas.plex_ep_count_priority | quote }}
  PLEX_SECTION: {{ join "|" $pas.plex_section | quote }}

  {{/* ANIList */}}
  ANI_USERNAME: {{ $pas.ani_username | quote }}
  ANI_TOKEN: {{ $pas.ani_token | quote }}

  SKIP_LIST_UPDATE: {{ ternary "True" "False" $pas.skip_list_update | quote }}
  LOG_FAILED_MATCHES: {{ ternary "True" "False" $pas.log_failed_matches | quote }}
  INTERVAL: {{ $pas.interval | quote }}


{{- end -}}
