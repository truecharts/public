{{/* Define the secret */}}
{{- define "zabbix.secret" -}}

{{- $serverSecretName := printf "%s-server-secret" (include "tc.common.names.fullname" .) }}
{{- $commonSecretName := printf "%s-common-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $commonSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  POSTGRES_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}
{{- end }}
