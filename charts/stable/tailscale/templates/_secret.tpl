{{/* Define the secret */}}
{{- define "tailscale.secret" -}}

{{- $secretName := printf "%s-tailscale-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}

data:
  {{- with .Values.tailscale.authkey }}
  {{/* Name of the authkey is crucial, don't change it */}}
  authkey: {{ . | b64enc }}
  {{- end }}
{{- end }}
