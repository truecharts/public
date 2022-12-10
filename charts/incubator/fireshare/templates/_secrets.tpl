{{/* Define the secrets */}}
{{- define "fireshare.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: fireshare-secrets
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace "fireshare-secrets") }}
  SECRET_KEY: {{ index .data "SECRET_KEY" }}
  {{- else }}
  SECRET_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}

{{- end -}}
