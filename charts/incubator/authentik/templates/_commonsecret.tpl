{{/* Define the configmap */}}
{{- define "authentik.commonsecret" -}}

{{- $configName := printf "%s-env-config" (include "tc.common.names.fullname" .) }}
{{- $authentikSecretName := printf "%s-authentik-secret" (include "tc.common.names.fullname" .) }}
{{- $geoipSecretName := printf "%s-geoip-secret" (include "tc.common.names.fullname" .) }}

{{- $pgPass := .Values.postgresql.postgresqlPassword | trimAll "\"" }}
{{- $pgUser := .Values.postgresql.postgresqlUsername }}
{{- $pgDB := .Values.postgresql.postgresqlDatabase }}
{{- $redisPass := .Values.redis.redisPassword | trimAll "\"" }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $authentikSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $authentikSecretName) }}
  AUTHENTIK_SECRET_KEY: {{ index .data "AUTHENTIK_SECRET_KEY" }}
  {{- else }}
  AUTHENTIK_SECRET_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}

  AUTHENTIK_POSTGRESQL__NAME: {{ .Values.postgresql.postgresqlDatabase }}
  AUTHENTIK_POSTGRESQL__USER: {{ .Values.postgresql.postgresqlUsername }}
  AUTHENTIK_POSTGRESQL__PORT: "5432"
  AUTHENTIK_POSTGRESQL__HOST: {{ printf "%v-%v" .Release.Name "postgresql" }}
  AUTHENTIK_POSTGRESQL__PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" }}
  AUTHENTIK_REDIS__PORT: "6379"
  AUTHENTIK_REDIS__HOST: {{ printf "%v-%v" .Release.Name "redis" }}
  AUTHENTIK_REDIS__PASSWORD: {{ .Values.redis.redisPassword | trimAll "\"" }}
  AUTHENTIK_BOOTSTRAP_PASSWORD: {{ .Values.authentik.password }}
  AUTHENTIK_BOOTSTRAP_TOKEN:  {{ .Values.authentik.token }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $geoipSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  GEOIPUPDATE_ACCOUNT_ID: {{ .Values.geoip.account_id }}
  GEOIPUPDATE_LICENSE_KEY: {{ .Values.geoip.license_key }}
  GEOIPUPDATE_PROXY: {{ .Values.geoip.proxy }}
  GEOIPUPDATE_PROXY_USER_PASSWORD: {{ .Values.geoip.proxy_pass }}

{{- end -}}
