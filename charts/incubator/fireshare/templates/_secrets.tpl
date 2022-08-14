{{/* Define the secrets */}}
{{- define "fireshare.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: fireshare-secrets
{{- $fireshareprevious := lookup "v1" "Secret" .Release.Namespace "fireshare-secrets" }}
{{- $secret_key := "" }}
data:
  {{- if $fireshareprevious}}
  SECRET_KEY: {{ index $fireshareprevious.data "SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  SECRET_KEY: {{ $secret_key | b64enc }}
  {{- end }}

{{- end -}}
