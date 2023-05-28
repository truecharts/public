{{/* Define the secret */}}
{{- define "wbo.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

---

{{/* This secrets are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with .Values.wbo.auth_secret_key }}
  AUTH_SECRET_KEY: {{ . | b64enc }}
  {{- end }}

{{- end }}
