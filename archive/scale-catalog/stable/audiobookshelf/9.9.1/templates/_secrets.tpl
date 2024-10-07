{{/* Define the secrets */}}
{{- define "audiobookshelf.secrets" -}}
{{- $secretName := (printf "%s-audiobookshelf-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $audiobookshelfprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
{{- $token_secret := "" }}
enabled: true
data:
  {{- if $audiobookshelfprevious }}
  TOKEN_SECRET: {{ index $audiobookshelfprevious.data "TOKEN_SECRET" | b64dec }}
  {{- else }}
  {{- $token_secret := randAlphaNum 32 }}
  TOKEN_SECRET: {{ $token_secret  }}
  {{- end }}

{{- end -}}
