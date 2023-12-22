{{/* Define the secrets */}}
{{- define "authelia.secrets" -}}
{{- $basename := include "tc.v1.common.lib.chart.names.fullname" $ -}}
{{- $fetchname := printf "%s-authelia-secrets" $basename -}}

{{/* Initialize all keys */}}
{{- $oidckey := genPrivateKey "rsa" }}
{{- $oidcsecret := randAlphaNum 32 }}
{{- $jwtsecret := randAlphaNum 50 }}
{{- $sessionsecret := randAlphaNum 50 }}
{{- $encryptionkey := randAlphaNum 100 }}

enabled: true
data:
  {{ with (lookup "v1" "Secret" .Release.Namespace $fetchname) }}
    {{/* Get previous values and decode */}}
    {{ $sessionsecret = (index .data "SESSION_ENCRYPTION_KEY") | b64dec }}
    {{ $jwtsecret = (index .data "JWT_TOKEN") | b64dec }}
    {{ $encryptionkey = (index .data "ENCRYPTION_KEY") | b64dec }}

    {{/* Check if those keys ever existed. as OIDC is optional */}}
    {{ if and (hasKey .data "OIDC_PRIVATE_KEY") (hasKey .data "OIDC_HMAC_SECRET") }}
      {{ $oidckey = (index .data "OIDC_PRIVATE_KEY") | b64dec }}
      {{ $oidcsecret = (index .data "OIDC_HMAC_SECRET") | b64dec }}
    {{ end }}
  {{ end }}
  SESSION_ENCRYPTION_KEY: {{ $sessionsecret }}
  JWT_TOKEN: {{ $jwtsecret }}
  ENCRYPTION_KEY: {{ $encryptionkey }}

  {{- if .Values.authentication_backend.ldap.enabled }}
  LDAP_PASSWORD: {{ .Values.authentication_backend.ldap.plain_password | quote }}
  {{- end }}

  {{- if and .Values.notifier.smtp.enabled .Values.notifier.smtp.plain_password }}
  SMTP_PASSWORD: {{ .Values.notifier.smtp.plain_password | quote }}
  {{- end }}

  {{- if .Values.duo_api.enabled }}
  DUO_API_KEY: {{ .Values.duo_api.plain_api_key | quote }}
  {{- end }}

  STORAGE_PASSWORD: {{ $.Values.cnpg.main.creds.password | trimAll "\"" }}

  REDIS_PASSWORD: {{ .Values.redis.creds.redisPassword | trimAll "\"" }}
  {{- if .Values.redisProvider.high_availability.enabled }}
  REDIS_SENTINEL_PASSWORD: {{ .Values.redis.sentinelPassword | trimAll "\"" }}
  {{- end }}

  OIDC_PRIVATE_KEY: |
    {{- $oidckey | nindent 4 }}
  OIDC_HMAC_SECRET: {{ $oidcsecret }}
{{- end -}}
