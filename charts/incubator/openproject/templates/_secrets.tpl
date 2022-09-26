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
  DATABASE_URL: {{ index .Values.postgresql.url "complete-noql" | trimAll "\"" | b64enc }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $mainSecretName }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $openprojectSecretName) }}
  SECRET_KEY_BASE: {{ index $.data "SECRET_KEY_BASE" }}
  {{- else }}
  SECRET_KEY_BASE: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
{{- end -}}
