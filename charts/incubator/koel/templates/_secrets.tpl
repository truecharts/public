{{/* Define the secrets */}}
{{- define "koel.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: koel-secrets
{{- $koelprevious := lookup "v1" "Secret" .Release.Namespace "koel-secrets" }}
{{- $app_key := "" }}
data:
  {{- if $koelprevious}}
  APP_KEY: {{ index $koelprevious.data "APP_KEY" }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key | b64enc }}
  {{- end }}

{{- end -}}
