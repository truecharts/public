{{/* Define the secret */}}
{{- define "immich.secret" -}}

{{- $secretName := printf "%s-immich-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}
{{- $immichprevious := lookup "v1" "Secret" .Release.Namespace "immich-secret" }}
data:
  {{/* Secret Key */}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  JWT_SECRET: {{ index .data "JWT_SECRET" }}
  {{- else }}
  JWT_SECRET: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  DB_PASSWORD: {{ .Values.cnpg.main.creds.password | trimAll "\"" | b64enc }}
  REDIS_PASSWORD: {{ .Values.redis.redisPassword | trimAll "\"" | b64enc }}
  {{- with .Values.immich.mapbox_key }}
  MAPBOX_KEY: {{ . | b64enc}}
  {{- end }}
{{- end }}
