{{/* Define the secret */}}
{{- define "serpbear.secret" -}}

{{- $secretName := (printf "%s-serpbear-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

enabled: true
data:
  {{/* Secret Key */}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  SECRET: {{ index .data "SECRET" }}
  {{- else }}
  SECRET: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- with .Values.serpbear.api_key | b64enc }}
  APIKEY: {{ . }}
  {{- end }}
  USER: {{ .Values.serpbear.user | b64enc }}
  PASSWORD: {{ .Values.serpbear.password | b64enc }}
  SESSION_DURATION: {{ .Values.serpbear.session_duration | quote | b64enc }}
  NEXT_PUBLIC_APP_URL: {{ .Values.serpbear.app_url | b64enc }}
{{- end }}
