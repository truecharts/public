{{/* Define the configmap */}}
{{- define "watcharr.configmaps" -}}
{{- $secretName := (printf "%s-watcharr-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $watcharr := .Values.watcharr -}}

{{- $secretKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $secretKey = index .data "JWT_SECRET" | b64dec -}}
 {{- end }}
watcharr-env:
  enabled: true
  data:
    .env: |
      JWT_SECRET={{ $secretKey }}
      JELLYFIN_HOST={{ $watcharr.jellyfin_host }}
      SIGNUP_ENABLED={{ $watcharr.signup_enabled }}
      TMDB_KEY={{ $watcharr.tmdb_key }}
      DEBUG={{ $watcharr.debug }}
      MODE={{ $watcharr.mode }}
{{- end -}}
