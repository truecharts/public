{{- define "tc.v1.common.lib.cnpg.secret.user" -}}
{{- $dbPass := .dbPass }}
{{- $values := .values -}}
enabled: true
type: kubernetes.io/basic-auth
data:
  username: {{ $values.user | b64enc | quote }}
  password: {{ $dbPass | b64enc | quote }}
{{- end -}}
