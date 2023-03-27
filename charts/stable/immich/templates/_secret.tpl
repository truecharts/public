{{/* Define the secret */}}
{{- define "immich.secret" -}}
enabled: true
{{- $secretName := printf "%s-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}
data:
  {{/* Secret Key */}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  JWT_SECRET: {{ index .data "JWT_SECRET" }}
  {{- else }}
  JWT_SECRET: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- with .Values.immich.mapbox_key }}
  MAPBOX_KEY: {{ . | b64enc}}
  {{- end }}

{{- end }}
