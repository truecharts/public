{{/* Define the secret */}}
{{- define "checkmk.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.v1.common.names.fullname" .) }}
enabled: true
data:
  CMK_PASSWORD: {{ .Values.cmk.password | quote }}
  CMK_SITE_ID: {{ .Values.cmk.site_id | quote }}
  CMK_LIVESTATUS_TCP: {{ ternary "on" "off" .Values.cmk.livestatus_tcp | quote }}
  {{- with .Values.cmk.mail_relay_host }}
  MAIL_RELAY_HOST: {{ . | quote }}
  {{- end }}
{{- end }}
