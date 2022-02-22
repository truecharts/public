{{/* Define the secrets */}}
{{- define "leantime.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: leantime-secrets
{{- $leantimeprevious := lookup "v1" "Secret" .Release.Namespace "leantime-secrets" }}
{{- $session_password := "" }}
data:
  {{- if $leantimeprevious}}
  LEAN_SESSION_PASSWORD: {{ index $leantimeprevious.data "LEAN_SESSION_PASSWORD" }}
  {{- else }}
  {{- $session_password := randAlphaNum 32 }}
  LEAN_SESSION_PASSWORD: {{ $session_password | b64enc }}
  {{- end }}

{{- end -}}
