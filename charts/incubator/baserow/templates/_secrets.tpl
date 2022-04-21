{{/* Define the secrets */}}
{{- define "baserow.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: baserow-secrets
{{- $baserowprevious := lookup "v1" "Secret" .Release.Namespace "baserow-secrets" }}
{{- $secret_key := "" }}
data:
  {{- if $baserowprevious}}
  SECRET_KEY: {{ index $baserowprevious.data "SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  SECRET_KEY: {{ $secret_key | b64enc }}
  {{- end }}

{{- end -}}
