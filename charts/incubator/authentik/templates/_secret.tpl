{{/* Define the secret */}}
{{- define "authentik.secret" -}}

{{- $authentikSecretName := printf "%s-authentik-secret" (include "tc.common.names.fullname" .) }}
{{- $geoipSecretName := printf "%s-geoip-secret" (include "tc.common.names.fullname" .) }}
{{- $ldapSecretName := printf "%s-ldap-secret" (include "tc.common.names.fullname" .) }}

---
{{/* This secrets are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $authentikSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Secret Key */}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $authentikSecretName) }}
  AUTHENTIK_SECRET_KEY: {{ index .data "AUTHENTIK_SECRET_KEY" }}
  {{- else }}
  AUTHENTIK_SECRET_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{/* Dependencies */}}
  AUTHENTIK_POSTGRESQL__NAME: {{ .Values.postgresql.postgresqlDatabase }}
  AUTHENTIK_POSTGRESQL__USER: {{ .Values.postgresql.postgresqlUsername }}
  AUTHENTIK_POSTGRESQL__PORT: "5432"
  AUTHENTIK_POSTGRESQL__HOST: {{ printf "%v-%v" .Release.Name "postgresql" }}
  AUTHENTIK_POSTGRESQL__PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" }}
  AUTHENTIK_REDIS__PORT: "6379"
  AUTHENTIK_REDIS__HOST: {{ printf "%v-%v" .Release.Name "redis" }}
  AUTHENTIK_REDIS__PASSWORD: {{ .Values.redis.redisPassword | trimAll "\"" }}
  {{/* Credentials */}}
  {{- with .Values.authentik.creds.password }}
  AUTHENTIK_BOOTSTRAP_PASSWORD: {{ . }}
  {{- end }}
  {{- with .Values.authentik.creds.token }}
  AUTHENTIK_BOOTSTRAP_TOKEN: {{ . }}
  {{- end }}
  {{/* Mail */}}
  {{- with .Values.authentik.mail.host }}
  AUTHENTIK_EMAIL__HOST: {{ . }}
  {{- end }}
  {{- with .Values.authentik.mail.user }}
  AUTHENTIK_EMAIL__USERNAME: {{ . }}
  {{- end }}
  {{- with .Values.authentik.mail.pass }}
  AUTHENTIK_EMAIL__PASSWORD: {{ . }}
  {{- end }}
  {{- with .Values.authentik.mail.from }}
  AUTHENTIK_EMAIL__FROM: {{ . }}
  {{- end }}
---
{{/* This secrets are loaded on ldap container */}}
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $ldapSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with .Values.outposts.ldap.token }}
  AUTHENTIK_TOKEN: {{ . }}
  {{- end }}
---
{{/* This secrets are loaded on geoip container */}}
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $geoipSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Credentials */}}
  {{- with .Values.geoip.account_id }}
  GEOIPUPDATE_ACCOUNT_ID: {{ . }}
  {{- end }}
  {{- with .Values.geoip.license_key }}
  GEOIPUPDATE_LICENSE_KEY: {{ . }}
  {{- end }}
  {{/* Proxy */}}
  {{- with .Values.geoip.proxy }}
  GEOIPUPDATE_PROXY: {{ . }}
  {{- end }}
  {{- with .Values.geoip.proxy_user_pass }}
  GEOIPUPDATE_PROXY_USER_PASSWORD: {{ . }}
  {{- end }}
{{- end }}
