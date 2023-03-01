{{- define "tc.v1.common.lib.cnpg.secret.user" -}}
{{- $dbPass := .dbPass }}
{{- $values := .values -}}
enabled: true
type: kubernetes.io/basic-auth
data:
  username: {{ $values.user }}
  password: {{ $dbPass }}
{{- end -}}
