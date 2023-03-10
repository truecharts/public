{{/* Define the secret */}}
{{- define "mealie.secret" -}}

{{- $apiSecretName := printf "%s-api-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}

data:
  POSTGRES_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}
  {{- with .Values.mealie_backend.smtp.user | b64enc }}
  SMTP_USER: {{ . }}
  {{- end }}
  {{- with .Values.mealie_backend.smtp.password | b64enc }}
  SMTP_PASSWORD: {{ . }}
  {{- end }}
{{- end }}
