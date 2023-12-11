{{/* Define the secrets */}}
{{- define "radicale.secrets" -}}
{{- $secretName := (printf "%s-radicale-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

enabled: true
data:
  users: |-
    {{- range .Values.radicale.auth.users }}
    {{ htpasswd .username .password }}
    {{- end }}
{{- end -}}
