{{/* Define the secret */}}
{{- define "grist.secret" -}}

{{- $secretName := printf "%s-grist-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Secret Key */}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  GRIST_SESSION_SECRET: {{ index .data "GRIST_SESSION_SECRET" }}
  {{- else }}
  GRIST_SESSION_SECRET: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{/* Dependencies */}}
  TYPEORM_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}
  REDIS_URL: {{ printf "redis://:%v@%v-redis:6379/%v" ( .Values.redis.redisPassword | trimAll "\"" ) .Release.Name "0" | b64enc }}
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
