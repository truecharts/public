{{/* Define the configmap */}}
{{- define "authentik.config" -}}

{{- $authentikConfigName := printf "%s-authentik-config" (include "tc.common.names.fullname" .) }}
{{- $geoipConfigName := printf "%s-geoip-config" (include "tc.common.names.fullname" .) }}
{{- $ldapConfigName := printf "%s-ldap-config" (include "tc.common.names.fullname" .) }}
{{- $proxyConfigName := printf "%s-proxy-config" (include "tc.common.names.fullname" .) }}
{{ $host := "http://localhost:9000" }}
{{- if .Values.ingress.main.enabled }}
  {{ $first := (first .Values.ingress.main.hosts) }}
  {{- if $first }}
    {{ $host = printf "https://%s" $first.host }}
  {{- end }}
{{- end }}

---

{{/* This configmap are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $authentikConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Dependencies */}}
  AUTHENTIK_REDIS__HOST: {{ printf "%v-%v" .Release.Name "redis" }}
  AUTHENTIK_REDIS__PORT: "6379"
  AUTHENTIK_POSTGRESQL__NAME: {{ .Values.postgresql.postgresqlDatabase }}
  AUTHENTIK_POSTGRESQL__USER: {{ .Values.postgresql.postgresqlUsername }}
  AUTHENTIK_POSTGRESQL__HOST: {{ printf "%v-%v" .Release.Name "postgresql" }}
  AUTHENTIK_POSTGRESQL__PORT: "5432"
  {{/* Mail */}}
  {{- with .Values.authentik.mail.port }}
  AUTHENTIK_EMAIL__PORT: {{ . | quote }}
  {{- end }}
  AUTHENTIK_EMAIL__USE_TLS: {{ .Values.authentik.mail.tls | quote }}
  AUTHENTIK_EMAIL__USE_SSL: {{ .Values.authentik.mail.ssl | quote }}
  {{- with .Values.authentik.mail.timeout }}
  AUTHENTIK_EMAIL__TIMEOUT: {{ . | quote }}
  {{- end }}
  {{/* Logging */}}
  {{- with .Values.authentik.logging.log_level }}
  AUTHENTIK_LOG_LEVEL: {{ . }}
  {{- end }}
  {{/* General */}}
  AUTHENTIK_DISABLE_STARTUP_ANALYTICS: {{ .Values.authentik.general.disable_startup_analytics | quote }}
  AUTHENTIK_DISABLE_UPDATE_CHECK: {{ .Values.authentik.general.disable_update_check | quote }}
  {{- with .Values.authentik.general.avatars }}
  AUTHENTIK_AVATARS: {{ . }}
  {{- end }}
  AUTHENTIK_DEFAULT_USER_CHANGE_NAME: {{ .Values.authentik.general.allow_user_name_change | quote }}
  AUTHENTIK_DEFAULT_USER_CHANGE_EMAIL: {{ .Values.authentik.general.allow_user_mail_change | quote }}
  AUTHENTIK_DEFAULT_USER_CHANGE_USERNAME: {{ .Values.authentik.general.allow_user_username_change | quote }}
  AUTHENTIK_GDPR_COMPLIANCE: {{ .Values.authentik.general.gdpr_compliance | quote }}
  AUTHENTIK_IMPERSONATION: {{ .Values.authentik.general.impersonation | quote }}
  AUTHENTIK_DEFAULT_TOKEN_LENGTH: {{ .Values.authentik.general.token_length | quote }}
  {{- with .Values.authentik.general.footer_links }}
  AUTHENTIK_FOOTER_LINKS: {{ . | squote }}
  {{- end }}
  {{/* Error Reporting */}}
  AUTHENTIK_ERROR_REPORTING__ENABLED: {{ .Values.authentik.error_reporting.enabled | quote }}
  AUTHENTIK_ERROR_REPORTING__SEND_PII: {{ .Values.authentik.error_reporting.send_pii | quote }}
  {{- with .Values.authentik.error_reporting.environment }}
  AUTHENTIK_ERROR_REPORTING__ENVIRONMENT: {{ . }}
  {{- end }}
  {{/* LDAP */}}
  {{- with .Values.authentik.ldap.tls_ciphers }}
  AUTHENTIK_LDAP__TLS__CIPHERS: {{ . | quote }}
  {{- end }}
  {{/* Metrics */}}
  AUTHENTIK_LISTEN__METRICS: {{ .Values.authentik.metrics.internalPort | quote | default "9301"}}
  {{/* Outposts */}}
  AUTHENTIK_OUTPOSTS__DISCOVER: {{ "false" | quote }}

---

{{/* This configmap is loaded on ldap container */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $ldapConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Both quotes are needed. */}}
  AUTHENTIK_INSECURE: {{ .Values.outposts.ldap.insecure | quote | default "true" | quote }}
  AUTHENTIK_HOST: {{ .Values.outposts.ldap.host | default (printf "http://localhost:%v" .Values.service.http.ports.http.targetPort) }}
  AUTHENTIK_HOST_BROWSER: {{ .Values.outposts.ldap.host_browser | default $host }}
  AUTHENTIK_LISTEN__LDAPS: {{ .Values.service.ldapldaps.ports.ldapldaps.targetPort | quote | default "6636" | quote }}
  AUTHENTIK_LISTEN__LDAP: {{ .Values.service.ldapldap.ports.ldapldap.targetPort | quote | default "3389" | quote }}
  AUTHENTIK_LISTEN__METRICS: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort | quote | default "9302" | quote }}

---

{{/* This configmap is loaded on ldap container */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $proxyConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Both quotes are needed. */}}
  AUTHENTIK_INSECURE: {{ .Values.outposts.proxy.insecure | quote | default "true" | quote }}
  AUTHENTIK_HOST: {{ .Values.outposts.proxy.host | default (printf "http://localhost:%v" .Values.service.http.ports.http.targetPort) }}
  AUTHENTIK_HOST_BROWSER: {{ .Values.outposts.proxy.host_browser | default $host }}
  AUTHENTIK_LISTEN__HTTPS: {{ .Values.service.proxyhttps.ports.proxyhttps.targetPort | quote | default "9444" | quote }}
  AUTHENTIK_LISTEN__HTTP: {{ .Values.service.proxyhttp.ports.proxyhttp.targetPort | quote | default "9001" | quote }}
  AUTHENTIK_LISTEN__METRICS: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort | quote | default "9303" | quote }}

---

{{/* This configmap is loaded on geoip container */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $geoipConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with .Values.geoip.edition_ids }}
  GEOIPUPDATE_EDITION_IDS: {{ . }}
  {{- end }}
  GEOIPUPDATE_FREQUENCY: {{ .Values.geoip.frequency | quote }}
  {{- with .Values.geoip.host_server }}
  GEOIPUPDATE_HOST: {{ . }}
  {{- end }}
  GEOIPUPDATE_PRESERVE_FILE_TIMES: '{{ ternary "1" "0" .Values.geoip.preserve_file_times }}'
  GEOIPUPDATE_VERBOSE: '{{ ternary "1" "0" .Values.geoip.verbose }}'
{{- end }}
