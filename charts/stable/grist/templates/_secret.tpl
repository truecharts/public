{{/* Define the secret */}}
{{- define "grist.secret" -}}

enabled: true
data:
  {{/* Secret Key */}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  GRIST_SESSION_SECRET: {{ index .data "GRIST_SESSION_SECRET" | b64dec }}
  {{- else }}
  GRIST_SESSION_SECRET: {{ randAlphaNum 32 }}
  {{- end }}
  {{/* Dependencies */}}
  TYPEORM_PASSWORD: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
  REDIS_URL: {{ printf "redis://:%v@%v-redis:6379/%v" ( .Values.redis.redisPassword | trimAll "\"" ) .Release.Name "0" }}
  {{/* Google */}}
  {{- with .Values.grist.google.client_id }}
  GOOGLE_CLIENT_ID: {{ . }}
  {{- end }}
  {{- with .Values.grist.google.client_secret }}
  GOOGLE_CLIENT_SECRET: {{ . }}
  {{- end }}
  {{- with .Values.grist.google.api_key }}
  GOOGLE_API_KEY: {{ . }}
  {{- end }}
{{- end }}
