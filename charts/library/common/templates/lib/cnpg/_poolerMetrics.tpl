{{- define "tc.v1.common.lib.cnpg.metrics.pooler" -}}
{{- $poolerName := .poolerName }}
enabled: true
type: podmonitor
selector:
  matchLabels:
    cnpg.io/poolerName: {{ $poolerName }}
endpoints:
  - port: metrics
{{- end -}}
