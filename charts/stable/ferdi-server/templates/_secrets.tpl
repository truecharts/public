{{/* Define the secrets */}}
{{- define "ferdi-server.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: ferdi-server-secrets
{{- $ferdiprevious := lookup "v1" "Secret" .Release.Namespace "ferdi-server-secrets" }}
{{- $app_key := "" }}
data:
  {{- if $ferdiprevious}}
  APP_KEY: {{ index $ferdiprevious.data "APP_KEY" }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key | b64enc }}
  {{- end }}

{{- end -}}
