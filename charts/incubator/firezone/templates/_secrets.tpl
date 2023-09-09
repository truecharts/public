{{/* Define the secrets */}}
{{- define "firezone.secrets" -}}
{{- $secretName := (printf "%s-firezone-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}
{{- $keyGuardian := randAlphaNum 64 -}}
{{- $keyDatabase := randAlphaNum 64 -}}
{{- $keySecret := randAlphaNum 64 -}}
{{- $keyLive := randAlphaNum 64 -}}
{{- $keyCookieSigning := randAlphaNum 64 -}}
{{- $keyCookieEncrypt := randAlphaNum 64 -}}
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
  # firezone requires all these keys to be in base 64 format presented in the container, so this b64enc here is intentional
  # https://www.firezone.dev/docs/reference/env-vars#secrets-and-encryption
  GUARDIAN_SECRET_KEY: {{ $keyGuardian | b64enc }}
  DATABASE_ENCRYPTION_KEY: {{ $keyDatabase | b64enc }}
  SECRET_KEY_BASE: {{ $keySecret | b64enc }}
  LIVE_VIEW_SIGNING_SALT: {{ $keyLive | b64enc }}
  COOKIE_SIGNING_SALT: {{ $keyCookieSigning | b64enc }}
  COOKIE_ENCRYPTION_SALT: {{ $keyCookieEncrypt | b64enc }}
{{- end -}}
