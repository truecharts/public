{{/* Define the secrets */}}
{{- define "hedgedoc.secrets" -}}
{{- $hedgedocprevious := lookup "v1" "Secret" .Release.Namespace "hedgedoc-secrets" }}
{{- $session_secret := "" }}
enabled: true
data:
  {{- if $hedgedocprevious}}
  CMD_SESSION_SECRET: {{ index $hedgedocprevious.data "CMD_SESSION_SECRET" }}
  {{- else }}
  {{- $session_secret := randAlphaNum 32 }}
  CMD_SESSION_SECRET: {{ $session_secret | b64enc }}
  {{- end }}

{{- end -}}
