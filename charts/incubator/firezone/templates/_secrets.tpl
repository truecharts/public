{{/* Define the secrets */}}
{{- define "firezone.secrets" -}}
{{- $secretName := (printf "%s-firezone-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

# firezone requires all these keys to be in base 64 | b64enc format presented in the container, so this b64enc here is intentional
# https://www.firezone.dev/docs/reference/env-vars#secrets-and-encryption
{{- $keyGuardian := randAlphaNum 48 | b64enc -}}
{{- $keyDatabase := randAlphaNum 32 | b64enc -}}
{{- $keySecret := randAlphaNum 48 | b64enc -}}
{{- $keyLive := randAlphaNum 24 | b64enc -}}
{{- $keyCookieSigning := randAlphaNum 6 | b64enc -}}
{{- $keyCookieEncrypt := randAlphaNum 6 | b64enc -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $keyGuardian = index .data "GUARDIAN_SECRET_KEY" | b64dec -}}
  {{- $keyDatabase = index .data "DATABASE_ENCRYPTION_KEY" | b64dec -}}
  {{- $keySecret = index .data "SECRET_KEY_BASE" | b64dec -}}
  {{- $keyLive = index .data "LIVE_VIEW_SIGNING_SALT" | b64dec -}}
  {{- $keyCookieSigning = index .data "COOKIE_SIGNING_SALT" | b64dec -}}
  {{- $keyCookieEncrypt = index .data "COOKIE_ENCRYPTION_SALT" | b64dec -}}
{{- end }}
enabled: true
data:
  GUARDIAN_SECRET_KEY: {{ $keyGuardian }}
  DATABASE_ENCRYPTION_KEY: {{ $keyDatabase }}
  SECRET_KEY_BASE: {{ $keySecret }}
  LIVE_VIEW_SIGNING_SALT: {{ $keyLive }}
  COOKIE_SIGNING_SALT: {{ $keyCookieSigning }}
  COOKIE_ENCRYPTION_SALT: {{ $keyCookieEncrypt }}
{{- end -}}
