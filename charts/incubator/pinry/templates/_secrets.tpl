{{/* Define the secrets */}}
{{- define "pinry.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: pinry-secrets
{{- $pinryprevious := lookup "v1" "Secret" .Release.Namespace "pinry-secrets" }}
{{- $secret_key := "" }}
data:
  {{- if $pinryprevious}}
  SECRET_KEY: {{ index $pinryprevious.data "SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  SECRET_KEY: {{ $secret_key | b64enc }}
  {{- end }}

{{- end -}}
