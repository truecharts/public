{{/* Define the secrets */}}
{{- define "vikunja.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: vikunja-secrets
{{- $vikunjaprevious := lookup "v1" "Secret" .Release.Namespace "vikunja-secrets" }}
{{- $jwt_secret := "" }}
data:
  {{- if $vikunjaprevious}}
  VIKUNJA_SERVICE_JWT_SECRET: {{ index $vikunjaprevious.data "VIKUNJA_SERVICE_JWT_SECRET" }}
  {{- else }}
  {{- $jwt_secret := randAlphaNum 32 }}
  VIKUNJA_SERVICE_JWT_SECRET: {{ $jwt_secret | b64enc }}
  {{- end }}

{{- end -}}
