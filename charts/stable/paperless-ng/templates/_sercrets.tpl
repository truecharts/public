{{/* Define the secrets */}}
{{- define "paperlessng.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: paperlessng-secrets
{{- $paperlessprevious := lookup "v1" "Secret" .Release.Namespace "paperlessng-secrets" }}
{{- $secret_key := "" }}
data:
  {{- if $paperlessprevious}}
  PAPERLESS_SECRET_KEY: {{ index $paperlessprevious.data "PAPERLESS_SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  PAPERLESS_SECRET_KEY: {{ $secret_key | b64enc  }}
  {{- end }}

{{- end -}}
