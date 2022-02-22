{{/* Define the secrets */}}
{{- define "authelia.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: authelia-secrets
{{- $autheliaprevious := lookup "v1" "Secret" .Release.Namespace "authelia-secrets" }}
{{- $oidckey := "" }}
{{- $oidcsecret := "" }}
{{- $jwtsecret := "" }}
{{- $sessionsecret := "" }}
{{- $encryptionkey := "" }}
data:
  {{- if $autheliaprevious }}
  SESSION_ENCRYPTION_KEY: {{ index $autheliaprevious.data "SESSION_ENCRYPTION_KEY"  }}
  JWT_TOKEN: {{ index $autheliaprevious.data "JWT_TOKEN"  }}
  {{- if ( hasKey $autheliaprevious.data "ENCRYPTION_KEY" ) }}
  ENCRYPTION_KEY: {{ index $autheliaprevious.data "ENCRYPTION_KEY"  }}
  {{- else }}
  {{- $encryptionkey := randAlphaNum 100 }}
  ENCRYPTION_KEY: {{ $encryptionkey | b64enc }}
  {{- end }}
  {{- else }}
  {{- $jwtsecret := randAlphaNum 50 }}
  {{- $sessionsecret := randAlphaNum 50 }}
  {{- $encryptionkey := randAlphaNum 100 }}
  SESSION_ENCRYPTION_KEY: {{ $sessionsecret | b64enc }}
  JWT_TOKEN: {{ $jwtsecret | b64enc}}
  ENCRYPTION_KEY: {{ $encryptionkey | b64enc }}
  {{- end }}

  {{- if .Values.authentication_backend.ldap.enabled }}
  LDAP_PASSWORD: {{ .Values.authentication_backend.ldap.plain_password | b64enc | quote }}
  {{- end }}

  {{- if .Values.notifier.smtp.enabled }}
  SMTP_PASSWORD: {{ .Values.notifier.smtp.plain_password | b64enc | quote }}
  {{- end }}

  {{- if .Values.duo_api.enabled }}
  DUO_API_KEY: {{ .Values.duo_api.plain_api_key | b64enc }}
  {{- end }}

  STORAGE_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}

  REDIS_PASSWORD: {{ .Values.redis.redisPassword | trimAll "\"" | b64enc }}
  {{- if .Values.redisProvider.high_availability.enabled}}
  REDIS_SENTINEL_PASSWORD: {{ .Values.redis.sentinelPassword | trimAll "\"" | b64enc }}
  {{- end }}

  {{- if $autheliaprevious }}
  {{- if and ( hasKey $autheliaprevious.data "OIDC_PRIVATE_KEY" ) ( hasKey $autheliaprevious.data "OIDC_HMAC_SECRET" ) }}
  OIDC_PRIVATE_KEY: {{ index $autheliaprevious.data "OIDC_PRIVATE_KEY"  }}
  OIDC_HMAC_SECRET: {{ index $autheliaprevious.data "OIDC_HMAC_SECRET" }}
  {{- else }}
  {{- $oidckey := genPrivateKey "rsa"   }}
  {{- $oidcsecret := randAlphaNum 32 }}
  OIDC_PRIVATE_KEY: {{ $oidckey | b64enc }}
  OIDC_HMAC_SECRET: {{ $oidcsecret | b64enc }}
  {{- end }}
  {{- end }}


{{- end -}}
