{{- define "tc.v1.common.lib.cnpg.configmap.pgVersion" -}}
{{- $version := .version }}
enabled: true
data:
  version: {{ $version | quote }}
{{- end -}}
