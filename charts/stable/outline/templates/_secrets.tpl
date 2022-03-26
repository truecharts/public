{{/* Define the secrets */}}
{{- define "outline.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: outline-secrets
{{- $outlineprevious := lookup "v1" "Secret" .Release.Namespace "outline-secrets" }}
{{- $secret_key := "" }}
{{- $utils_secret := "" }}
data:
  {{- if $outlineprevious}}
  SECRET_KEY: {{ index $outlineprevious.data "SECRET_KEY" }}
  UTILS_SECRET: {{ index $outlineprevious.data "UTILS_SECRET" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  {{- $utils_secret := randAlphaNum 32 }}
  SECRET_KEY: {{ $secret_key | b64enc }}
  UTILS_SECRET: {{ $utils_secret | b64enc }}
  {{- end }}

{{- end -}}
