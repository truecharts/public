{{/* Plausible SECRET_KEY_BASE */}}
{{- define "plausible.secret" -}}
---
{{- $secretName := "plausible-secret" }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  SECRET_KEY_BASE: {{ index .stringData "SECRET_KEY_BASE" }}
  {{- else }}
  {{- /* The plain value of SECRET_KEY_BASE is also base64 encoded */}}
  SECRET_KEY_BASE: {{ randAlphaNum 65 | b64enc }}
  {{- end }}

{{- end }}
