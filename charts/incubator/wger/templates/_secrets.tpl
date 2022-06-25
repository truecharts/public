{{/* Define the secrets */}}
{{- define "wger.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: wger-secrets
{{- $wgerprevious := lookup "v1" "Secret" .Release.Namespace "wger-secrets" }}
{{- $secret_key := "" }}
data:
  {{- if $wgerprevious}}
  SECRET_KEY: {{ index $wgerprevious.data "SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  SECRET_KEY: {{ $secret_key | b64enc }}
  {{- end }}

{{- end -}}
