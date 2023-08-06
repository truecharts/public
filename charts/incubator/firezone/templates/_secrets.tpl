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
  GUARDIAN_SECRET_KEY: {{ $keyGuardian }}
  DATABASE_ENCRYPTION_KEY: {{ $keyDatabase }}
  SECRET_KEY_BASE: {{ $keySecret }}
  LIVE_VIEW_SIGNING_SALT: {{ $keyLive }}
  COOKIE_SIGNING_SALT: {{ $keyCookieSigning }}
  COOKIE_ENCRYPTION_SALT: {{ $keyCookieEncrypt }}
{{- end -}}
