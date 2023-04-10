{{/* Define the secrets */}}
{{- define "paperlessng.secrets" -}}
{{- $secretName := (printf "%s-paperlessng-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $paperlessprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
<<<<<<<< HEAD:charts/stable/paperless-ngx/templates/_secrets.tpl
========

>>>>>>>> 04d045fc3f (feat(stable): BREAKING CHANGE migrate to new common part 3):charts/stable/paperless-ngx/templates/_sercrets.tpl
data:
  {{- if $paperlessprevious }}
  PAPERLESS_SECRET_KEY: {{ index $paperlessprevious.data "PAPERLESS_SECRET_KEY" | b64dec }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  PAPERLESS_SECRET_KEY: {{ $secret_key }}
  {{- end }}

{{- end -}}
