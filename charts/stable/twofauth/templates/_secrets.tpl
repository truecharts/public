{{/* Define the secrets */}}
{{- define "twofauth.secret" -}}
  {{- $secretName := (printf "%s-twofauth-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

  {{ $URL := (printf "http://%s:%v/" .Values.config.nodeIP .Values.service.main.ports.main.port) }}

  {{- if and (.Values.ingress.main.enabled) (gt (len .Values.ingress.main.hosts) 0) -}}
    {{- $URL = (printf "https://%s/" (index .Values.ingress.main.hosts 0).host) -}}
  {{- end -}}

  {{- $appKey := randAlphaNum 32 -}}

  {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
    {{- $appKey = index .data "APP_KEY" | b64dec -}}
  {{- end }}
enabled: true
data:
  APP_KEY: {{ $appKey }}
  APP_URL: {{ $URL }}
{{- end -}}
