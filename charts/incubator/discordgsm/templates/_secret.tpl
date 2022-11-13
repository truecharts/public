{{/* Define the secret */}}
{{- define "gsm.secret" -}}

{{- $secretName := printf "%s-gsm-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  DATABASE_URL: {{ .Values.postgresql.url.complete | trimAll "\"" }}
  DB_CONNECTION {{ print "postgres" }}
  APP_TOKEN: {{ .Values.gsm.app_token }}
  {{- with .Values.gsm.whitelist_guilds }}
  WHITELIST_GUILDS: {{ join ";" . }}
  {{- end }}
  APP_ACTIVITY_TYPE: {{ .Values.gsm.app_activity_type | quote }}
  {{- with .Values.gsm.app_activity_name }}
  APP_ACTIVITY_NAME: {{ . | quote }}
  {{- end }}
  APP_PRESENCE_ADVERTISE: {{ .Values.gsm.app_presense_advertise | quote }}
  TASK_QUERY_SERVER: {{ .Values.gsm.task_query_server | quote }}
  COMMAND_QUERY_PUBLIC: {{ .Values.gsm.command_query_public | quote }}
  COMMAND_QUERY_COOLDOWN: {{ .Values.gsm.command_query_cooldown | quote }}
  WEB_API_ENABLE: {{ .Values.gsm.web_api_enable | quote }}

{{- end }}
