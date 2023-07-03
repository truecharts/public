{{/* Define the secret */}}
{{- define "mealie.secret" -}}

{{- $apiSecretName := printf "%s-api-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}

---

{{/* This secrets are loaded on mealie */}}
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $apiSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  POSTGRES_PASSWORD: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
  {{- with .Values.mealie_backend.smtp.user | b64enc }}
  SMTP_USER: {{ . }}
  {{- end }}
  {{- with .Values.mealie_backend.smtp.password | b64enc }}
  SMTP_PASSWORD: {{ . }}
  {{- end }}
{{- end }}
