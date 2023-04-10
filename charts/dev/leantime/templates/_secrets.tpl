{{/* Define the secrets */}}
{{- define "leantime.secrets" -}}
{{- $secretName := (printf "%s-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $leantimeprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
{{- $session_password := "" }}
enabled: true
data:
  {{- if $leantimeprevious}}
  LEAN_SESSION_PASSWORD: {{ index $leantimeprevious.data "LEAN_SESSION_PASSWORD" }}
  {{- else }}
  {{- $session_password := randAlphaNum 32 }}
  LEAN_SESSION_PASSWORD: {{ $session_password | b64enc }}
  {{- end }}

{{- end -}}
