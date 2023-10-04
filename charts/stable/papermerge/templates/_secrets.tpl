{{/* Define the secrets */}}
{{- define "papermerge.secrets" -}}

{{- $secretName := (printf "%s-papermerge-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

{{- $pass_key := randAlphaNum 32 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $pass_key = index .data "PAPERMERGE__MAIN__SECRET_KEY" | b64dec -}}
{{- end }}
enabled: true
data:
  PAPERMERGE__MAIN__SECRET_KEY: {{ $pass_key }}
{{- end -}}
