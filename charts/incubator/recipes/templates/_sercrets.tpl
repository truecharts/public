{{/* Define the secrets */}}
{{- define "recipes.secrets" -}}
{{- $secretName := (printf "%s-recipes-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $recipesprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $recipesprevious }}
  SECRET_KEY: {{ index $recipesprevious.data "SECRET_KEY" | b64dec }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  SECRET_KEY: {{ $secret_key }}
  {{- end }}

{{- end -}}
