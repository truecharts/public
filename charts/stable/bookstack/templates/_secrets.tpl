{{/* Define the secrets */}}
{{- define "bookstack.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: bookstack-secrets
{{- $bookstackprevious := lookup "v1" "Secret" .Release.Namespace "bookstack-secrets" }}
{{- $app_key := "" }}
data:
  {{- if $bookstackprevious}}
  APP_KEY: {{ index $bookstackprevious.data "APP_KEY" }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key | b64enc }}
  {{- end }}

{{- end -}}
