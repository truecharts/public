{{/* Define the secrets */}}
{{- define "leantime.secrets" -}}
enabled: true
{{- $leantimeprevious := lookup "v1" "Secret" .Release.Namespace "leantime-secrets" }}
{{- $session_password := "" }}
data:
  {{- if $leantimeprevious}}
  LEAN_SESSION_PASSWORD: {{ index $leantimeprevious.data "LEAN_SESSION_PASSWORD" }}
  {{- else }}
  {{- $session_password := randAlphaNum 32 }}
  LEAN_SESSION_PASSWORD: {{ $session_password }}
  {{- end }}

{{- end -}}
