{{/* Define the secrets */}}
{{- define "wg.config-secret" -}}

{{- $secretName := printf "%s-wg-config-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}

data:
  wg0.conf: |
{{ .Values.wg.config.data | b64enc | indent 4 }}
{{- end -}}
