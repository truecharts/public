{{/* Define the secrets */}}
{{- define "openproject.secrets" -}}

{{- $commonSecretName := printf "%s-common-secret" (include "tc.common.names.fullname" .) }}
{{- $mainSecretName := printf "%s-main-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $commonSecretName }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $commonSecretName) }}
  SECRET_KEY_BASE: {{ index $.data "SECRET_KEY_BASE" }}
  {{- else }}
  SECRET_KEY_BASE: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  DATABASE_URL: {{ index .Values.postgresql.url "complete-noql" | trimAll "\"" | b64enc }}
{{- end -}}
