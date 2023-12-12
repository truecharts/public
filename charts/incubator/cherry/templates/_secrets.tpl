{{/* Define the secrets */}}
{{- define "cherry.secrets" -}}

{{- $secretName := printf "%s-cherry-secret" (include "tc.v1.common.names.fullname" .) }}

enabled: true
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  JWT_SECRET: {{ index .data "JWT_SECRET" }}
  {{- else }}
  JWT_SECRET: {{ randAlphaNum 32 }}
  {{- end }}
  {{- with .Values.cherry.google_oauth_id }}
  GOOGLE_OAUTH_CLIENT_ID: {{ . }}
  {{- end }}
  {{- with .Values.cherry.google_oauth_secret }}
  GOOGLE_OAUTH_CLIENT_SECRET: {{ . }}
  {{- end }}
{{- end -}}
