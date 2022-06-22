{{/* Define the secrets */}}
{{- define "hedgedoc.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: hedgedoc-secrets
{{- $hedgedocprevious := lookup "v1" "Secret" .Release.Namespace "hedgedoc-secrets" }}
{{- $session_secret := "" }}
data:
  {{- if $hedgedocprevious}}
  CMD_SESSION_SECRET: {{ index $hedgedocprevious.data "CMD_SESSION_SECRET" }}
  {{- else }}
  {{- $session_secret := randAlphaNum 32 }}
  CMD_SESSION_SECRET: {{ $session_secret | b64enc }}
  {{- end }}

{{- end -}}
