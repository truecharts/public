{{/* Define the secrets */}}
{{- define "umami.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: umami-salt
{{- $salt := "" }}
data:
  {{- $salt = randAlphaNum 30 }}
  salt: {{ $salt | b64enc }}

{{- end -}}
