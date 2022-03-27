{{/* Define the secrets */}}
{{- define "kutt.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: kutt-secrets
{{- $kuttprevious := lookup "v1" "Secret" .Release.Namespace "kutt-secrets" }}
{{- $jwt_secret := "" }}
data:
  {{- if $kuttprevious}}
  JWT_SECRET: {{ index $kuttprevious.data "JWT_SECRET" }}
  {{- else }}
  {{- $jwt_secret := randAlphaNum 32 }}
  JWT_SECRET: {{ $jwt_secret | b64enc }}
  {{- end }}

{{- end -}}
