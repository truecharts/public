{{- define "tc.v1.common.lib.cnpg.secret.superuser" -}}
{{- $pgPass := .pgPass }}
enabled: true
data:
  username: {{ "postgres" | b64enc | quote  }}
  password: {{ $pgPass | b64enc | quote }}
type: kubernetes.io/basic-auth
{{- end -}}
