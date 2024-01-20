{{/* Define the secrets */}}
{{- define "librephotos.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: librephotos-secrets
{{- $librephotosprevious := lookup "v1" "Secret" .Release.Namespace "librephotos-secrets" }}
{{- $secret_key := "" }}
data:
  {{- if $librephotosprevious}}
  SECRET_KEY: {{ index $librephotosprevious.data "SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  SECRET_KEY: {{ $secret_key | b64enc }}
  {{- end }}

{{- end -}}
