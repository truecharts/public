{{/* Define the secrets */}}
{{- define "recipes.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: recipes-secrets
{{- $recipesprevious := lookup "v1" "Secret" .Release.Namespace "recipes-secrets" }}
{{- $secret_key := "" }}
data:
  {{- if $recipesprevious}}
  SECRET_KEY: {{ index $recipesprevious.data "SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 50 }}
  SECRET_KEY: {{ $secret_key | b64enc | quote }}
  {{- end }}

{{- end -}}
