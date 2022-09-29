{{/* Define the secret */}}
{{- define "immich.secret" -}}

{{- $secretName := printf "%s-immich-secret" (include "tc.common.names.fullname" .) }}

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
  JWT_SECRET: {{ index .data "JWT_SECRET" }}
  {{- else }}
  JWT_SECRET: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  DB_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}
  REDIS_PASSWORD: {{ .Values.redis.redisPassword | trimAll "\"" | b64enc }}
  {{- with .Values.immich.mapbox_key }}
  MAPBOX_KEY: {{ . }}
  {{- end }}
{{- end }}
