{{/* Define the secret */}}
{{- define "gsm.secret" -}}
{{- $gsm := .Values.gsm -}}
enabled: true
data:
  DATABASE_URL: {{ .Values.cnpg.main.creds.std | trimAll "\""  }}
  DB_CONNECTION: {{ print "postgres" }}
  APP_TOKEN: {{ $gsm.app_token | quote }}
  {{- with $gsm.whitelist_guilds }}
  WHITELIST_GUILDS: {{ join ";" . | quote }}
  {{- end }}
  APP_ACTIVITY_TYPE: {{ $gsm.app_activity_type | quote }}
  {{- with $gsm.app_activity_name }}
  APP_ACTIVITY_NAME: {{ . | quote }}
  {{- end }}
  APP_PRESENCE_ADVERTISE: {{ $gsm.app_presence_advertise | quote }}
  POSTGRES_SSL_MODE: {{ $gsm.postgres_ssl_mode | quote }}
  TASK_QUERY_SERVER: {{ $gsm.task_query_server | quote }}
  COMMAND_QUERY_PUBLIC: {{ $gsm.command_query_public | quote }}
  COMMAND_QUERY_COOLDOWN: {{ $gsm.command_query_cooldown | quote }}
  WEB_API_ENABLE: {{ $gsm.web_api_enable | quote }}
  {{- with $gsm.factorio_username }}
  FACTORIO_USERNAME: {{ . | quote }}
  {{- end }}
  {{- with $gsm.factorio_auth_token }}
  FACTORIO_TOKEN: {{ . | quote }}
  {{- end }}
{{- end }}
