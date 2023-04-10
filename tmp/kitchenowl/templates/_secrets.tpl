{{/* Define the secrets */}}
{{- define "kitchenowl.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: kitchenowl-secrets
{{- $kitchenowlprevious := lookup "v1" "Secret" .Release.Namespace "kitchenowl-secrets" }}
{{- $jwt_secret := "" }}
data:
  {{- if $kitchenowlprevious}}
  JWT_SECRET_KEY: {{ index $kitchenowlprevious.data "JWT_SECRET_KEY" }}
  {{- else }}
  {{- $jwt_secret := randAlphaNum 32 }}
  JWT_SECRET_KEY: {{ $jwt_secret | b64enc }}
  {{- end }}

{{- end -}}
