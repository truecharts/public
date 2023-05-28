{{/* Define the secret */}}
{{- define "mealie.secret" -}}

{{- $apiSecretName := printf "%s-api-secret" (include "tc.common.names.fullname" .) }}

---

{{/* This secrets are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $apiSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  POSTGRES_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}
  {{- with .Values.mealie_backend.smtp.user | b64enc }}
  SMTP_USER: {{ . }}
  {{- end }}
  {{- with .Values.mealie_backend.smtp.password | b64enc }}
  SMTP_PASSWORD: {{ . }}
  {{- end }}
{{- end }}
