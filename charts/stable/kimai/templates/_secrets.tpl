{{/* Define the secrets */}}
{{- define "kimai.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: kimai-secrets
{{- $kimaiprevious := lookup "v1" "Secret" .Release.Namespace "kimai-secrets" }}
{{- $app_secret := "" }}
data:
  {{- if $kimaiprevious}}
  APP_SECRET: {{ index $kimaiprevious.data "APP_SECRET" }}
  {{- else }}
  {{- $app_secret := randAlphaNum 32 }}
  APP_SECRET: {{ $app_secret | b64enc }}
  {{- end }}

{{- end -}}
