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
  {{- $salt := randAlphaNum 30 }}
  HASH_SALT: {{ $salt | b64enc }}
  {{- end }}
{{- end -}}
