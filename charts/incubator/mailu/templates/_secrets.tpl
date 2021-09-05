{{/* Define the secrets */}}
{{- define "authelia.secrets" -}}
---

apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "common.labels" . | nindent 4 }}
  name: dbcreds
{{- $dbprevious := lookup "v1" "Secret" .Release.Namespace "dbcreds" }}
{{- $dbPass := "" }}
data:
{{- if $dbprevious }}
  {{- $dbPass = ( index $dbprevious.data "postgresql-password" ) | b64dec  }}
  postgresql-password: {{ ( index $dbprevious.data "postgresql-password" ) }}
  postgresql-postgres-password: {{ ( index $dbprevious.data "postgresql-postgres-password" ) }}
{{- else }}
  {{- $dbPass = randAlphaNum 50 }}
  postgresql-password: {{ $dbPass | b64enc | quote }}
  postgresql-postgres-password: {{ randAlphaNum 50 | b64enc | quote }}
{{- end }}
  url: {{ ( printf "%v%v:%v@%v-%v:%v/%v" "postgresql://" .Values.postgresql.postgresqlUsername $dbPass .Release.Name "postgresql" "5432" .Values.postgresql.postgresqlDatabase  ) | b64enc | quote }}
  plainhost: {{ ( printf "%v-%v" .Release.Name "postgresql" ) | b64enc | quote }}
type: Opaque


---

apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "common.labels" . | nindent 4 }}
  name: rediscreds
{{- $redisprevious := lookup "v1" "Secret" .Release.Namespace "rediscreds" }}
{{- $redisPass := "" }}
{{- $sentinelPass := "" }}
data:
{{- if $redisprevious }}
  {{- $redisPass = ( index $redisprevious.data "redis-password" ) | b64dec  }}
  {{- $sentinelPass = ( index $redisprevious.data "redis-password" ) | b64dec  }}
  redis-password: {{ ( index $redisprevious.data "redis-password" ) }}
  sentinel-password: {{ ( index $redisprevious.data "sentinel-password" ) }}
{{- else }}
  {{- $redisPass = randAlphaNum 50 }}
  {{- $sentinelPass = randAlphaNum 50 }}
  redis-password: {{ $redisPass | b64enc | quote }}
  sentinel-password: {{ $sentinelPass | b64enc | quote }}
{{- end }}
  masterhost: {{ ( printf "%v-%v" .Release.Name "redis-master" ) | b64enc | quote }}
  slavehost: {{ ( printf "%v-%v" .Release.Name "redis-slave" ) | b64enc | quote }}
type: Opaque


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
data:
  {{- if $autheliaprevious }}
  SESSION_ENCRYPTION_KEY: {{ index $autheliaprevious.data "SESSION_ENCRYPTION_KEY"  }}
  JWT_TOKEN: {{ index $autheliaprevious.data "JWT_TOKEN"  }}
  {{- else }}
  {{- $jwtsecret := randAlphaNum 50 }}
  {{- $sessionsecret := randAlphaNum 50 }}
  SESSION_ENCRYPTION_KEY: {{ $jwtsecret | b64enc | quote }}
  JWT_TOKEN: {{ $jwtsecret | b64enc | quote }}
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

  {{- if $dbprevious }}
  STORAGE_PASSWORD: {{ ( index $dbprevious.data "postgresql-password" ) }}
  {{- else }}
  STORAGE_PASSWORD: {{ $dbPass | b64enc | quote }}
  {{- end }}

  {{- if $redisprevious }}
  REDIS_PASSWORD: {{ ( index $redisprevious.data "redis-password" ) }}
  {{- if .Values.redisProvider.high_availability.enabled}}
  REDIS_SENTINEL_PASSWORD: {{ ( index $redisprevious.data "sentinel-password" ) }}
  {{- end }}
  {{- else }}
  REDIS_PASSWORD: {{ $redisPass | b64enc | quote }}
  {{- if .Values.redisProvider.high_availability.enabled}}
  REDIS_SENTINEL_PASSWORD: {{ $sentinelPass | b64enc | quote }}
  {{- end }}
  {{- end }}

  {{- if .Values.identity_providers.oidc.enabled }}
  {{- if $autheliaprevious }}
  OIDC_PRIVATE_KEY: {{ index $autheliaprevious.data "OIDC_PRIVATE_KEY"  }}
  OIDC_HMAC_SECRET: {{index $autheliaprevious.data "OIDC_HMAC_SECRET" }}
  {{- else }}
  {{- $oidckey := genPrivateKey "rsa"   }}
  {{- $oidcsecret := randAlphaNum 32 }}
  OIDC_PRIVATE_KEY: {{ $oidckey | b64enc }}
  OIDC_HMAC_SECRET: {{ $oidcsecret | b64enc }}
  {{- end }}
  {{- end }}


{{- end -}}
