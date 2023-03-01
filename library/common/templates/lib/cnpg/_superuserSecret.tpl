{{- define "tc.v1.common.lib.cnpg.secret.superuser" -}}
{{- $pgPass := .pgPass }}
enabled: true
stringData:
  username: {{ "postgres"  }}
  password: {{ $pgPass }}
type: kubernetes.io/basic-auth
{{- end -}}
