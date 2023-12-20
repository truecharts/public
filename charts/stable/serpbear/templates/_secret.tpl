{{/* Define the secret */}}
{{- define "serpbear.secret" -}}

{{- $secretName := (printf "%s-serpbear-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

enabled: true
data:
  {{/* Secret Key */}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  SECRET: {{ index .data "SECRET" }}
  {{- else }}
  SECRET: {{ randAlphaNum 32 }}
  {{- end }}
  {{- with .Values.serpbear.api_key }}
  APIKEY: {{ . }}
  {{- end }}
  USER: {{ .Values.serpbear.user }}
  PASSWORD: {{ .Values.serpbear.password }}
  SESSION_DURATION: {{ .Values.serpbear.session_duration | quote }}
  NEXT_PUBLIC_APP_URL: {{ .Values.serpbear.app_url }}
{{- end }}
