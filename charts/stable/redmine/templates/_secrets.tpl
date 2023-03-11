{{/* Define the secrets */}}
{{- define "redmine.secrets" -}}
{{- $secretName := (printf "%s-redmine-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $redmineprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $redmineprevious }}
  REDMINE_SECRET_KEY_BASE: {{ index $redmineprevious.data "REDMINE_SECRET_KEY_BASE" | b64dec }}
  {{- else }}
  {{- $secret_key_base := randAlphaNum 80 }}
  REDMINE_SECRET_KEY_BASE: {{ $secret_key_base }}
  {{- end }}

{{- end -}}
