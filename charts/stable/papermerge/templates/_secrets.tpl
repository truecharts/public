{{/* Define the secrets */}}
{{- define "papermerge.secrets" -}}
{{- $secretName := (printf "%s-papermerge-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $papermergeprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $papermergeprevious }}
  PAPERMERGE__MAIN__SECRET_KEY: {{ index $papermergeprevious.data "PAPERMERGE__MAIN__SECRET_KEY" | b64dec }}
  {{- else }}
  {{- $pass_key := randAlphaNum 32 }}
  PAPERMERGE__MAIN__SECRET_KEY: {{ $pass_key }}
  {{- end }}

{{- end -}}
