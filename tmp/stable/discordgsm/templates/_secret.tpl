{{/* Define the secret */}}
{{- define "gsm.secret" -}}

enabled: true
data:
  DATABASE_URL: {{ .Values.cnpg.main.creds.std | trimAll "\""  }}
  DB_CONNECTION: {{ print "postgres" }}
  APP_TOKEN: {{ .Values.gsm.app_token | quote }}
  {{- with .Values.gsm.whitelist_guilds }}
  WHITELIST_GUILDS: {{ join ";" . | quote }}
  {{- end }}
  APP_ACTIVITY_TYPE: {{ .Values.gsm.app_activity_type | quote }}
  {{- with .Values.gsm.app_activity_name }}
  APP_ACTIVITY_NAME: {{ . | quote }}
  {{- end }}
  APP_PRESENCE_ADVERTISE: {{ .Values.gsm.app_presence_advertise | quote }}
  POSTGRES_SSL_MODE: {{ .Values.gsm.postgres_ssl_mode | quote }}
  TASK_QUERY_SERVER: {{ .Values.gsm.task_query_server | quote }}
  COMMAND_QUERY_PUBLIC: {{ .Values.gsm.command_query_public | quote }}
  COMMAND_QUERY_COOLDOWN: {{ .Values.gsm.command_query_cooldown | quote }}
  WEB_API_ENABLE: {{ .Values.gsm.web_api_enable | quote }}
{{- end }}
