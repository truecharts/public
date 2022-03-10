{{/* Define the secrets */}}
{{- define "redmine.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: redmine-secrets
{{- $redmineprevious := lookup "v1" "Secret" .Release.Namespace "redmine-secrets" }}
{{- $secret_key_base := "" }}
data:
  {{- if $redmineprevious}}
  REDMINE_SECRET_KEY_BASE: {{ index $redmineprevious.data "REDMINE_SECRET_KEY_BASE" }}
  {{- else }}
  {{- $secret_key_base := randAlphaNum 80 }}
  REDMINE_SECRET_KEY_BASE: {{ $secret_key_base | b64enc }}
  {{- end }}

{{- end -}}
