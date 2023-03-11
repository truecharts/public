{{/* Define the secrets */}}
{{- define "redmine.secrets" -}}

data:
  {{- if $redmineprevious}}
  REDMINE_SECRET_KEY_BASE: {{ index $redmineprevious.data "REDMINE_SECRET_KEY_BASE" }}
  {{- else }}
  {{- $secret_key_base := randAlphaNum 80 }}
  REDMINE_SECRET_KEY_BASE: {{ $secret_key_base | b64enc }}
  {{- end }}

{{- end -}}
