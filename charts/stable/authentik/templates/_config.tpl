{{/* Define the configmaps */}}
{{- define "authentik.configmaps" -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}
  {{- $serverHost := printf "https://%v:%v" $fullname .Values.service.main.ports.main.port -}}
  {{- $host := .Values.chartContext.appUrl }}
server:
  enabled: true
  data:
    AUTHENTIK_LISTEN__HTTPS: {{ printf "0.0.0.0:%v" .Values.service.main.ports.main.port | quote }}
    AUTHENTIK_LISTEN__HTTP: {{ printf "0.0.0.0:%v" .Values.service.http.ports.http.port | quote }}
    AUTHENTIK_LISTEN__METRICS: {{ printf "0.0.0.0:%v" .Values.service.servermetrics.ports.servermetrics.port | quote }}

server-worker:
  enabled: true
  data:
    {{/* Dependencies */}}
    AUTHENTIK_POSTGRESQL__NAME: {{ .Values.cnpg.main.database }}
    AUTHENTIK_POSTGRESQL__USER: {{ .Values.cnpg.main.user }}
    AUTHENTIK_POSTGRESQL__HOST: {{ .Values.cnpg.main.creds.host }}
    AUTHENTIK_POSTGRESQL__PORT: "5432"
    AUTHENTIK_REDIS__HOST: {{ .Values.redis.creds.plain }}
    AUTHENTIK_REDIS__PORT: "6379"

    {{/* Outposts */}}
    AUTHENTIK_OUTPOSTS__DISCOVER: "false"

    {{/* GeoIP */}}
    {{- $geoipPath := (printf "/geoip/%v.mmdb" .Values.authentik.geoip.editionID) -}}
    {{- if not .Values.authentik.geoip.enabled -}}
      {{- $geoipPath = "/tmp/non-existent-file" -}}
    {{- end -}}

    {{- if or .Values.authentik.geoip.enabled .Values.authentik.geoip.wipeBuiltInDb }}
    AUTHENTIK_GEOIP: {{ $geoipPath }}
    {{- end }}

    {{/* Mail */}}
    AUTHENTIK_EMAIL__USE_TLS: {{ .Values.authentik.email.useTLS | quote }}
    AUTHENTIK_EMAIL__USE_SSL: {{ .Values.authentik.email.useSSL | quote }}
    {{- with .Values.authentik.email.port }}
    AUTHENTIK_EMAIL__PORT: {{ . | quote }}
    {{- end -}}
    {{- with .Values.authentik.email.timeout }}
    AUTHENTIK_EMAIL__TIMEOUT: {{ . | quote }}
    {{- end }}

    {{/* LDAP */}}
    AUTHENTIK_LDAP__TASK_TIMEOUT_HOURS: {{ .Values.authentik.ldap.taskTimeoutHours | quote }}
    AUTHENTIK_LDAP__TLS__CIPHERS: {{ .Values.authentik.ldap.tlsCiphers | quote }}

    {{/* Logging */}}
    AUTHENTIK_LOG_LEVEL: {{ .Values.authentik.logging.logLevel }}

    {{/* Error Reporting */}}
    AUTHENTIK_ERROR_REPORTING__ENABLED: {{ .Values.authentik.errorReporting.enabled | quote }}
    AUTHENTIK_ERROR_REPORTING__SEND_PII: {{ .Values.authentik.errorReporting.sendPII | quote }}
    {{- with .Values.authentik.errorReporting.environment }}
    AUTHENTIK_ERROR_REPORTING__ENVIRONMENT: {{ . | quote }}
    {{- end -}}
    {{- with .Values.authentik.errorReporting.sentryDSN }}
    AUTHENTIK_ERROR_REPORTING__SENTRY_DSN: {{ . | quote }}
    {{- end -}}
    {{- with .Values.authentik.general.avatars }}
    AUTHENTIK_AVATARS: {{ join "," . }}
    {{- end -}}
    {{- with .Values.authentik.general.footerLinks }}
    AUTHENTIK_FOOTER_LINKS: {{ toJson . | squote }}
    {{- end }}

    {{/* General */}}
    AUTHENTIK_DISABLE_UPDATE_CHECK: {{ .Values.authentik.general.disableUpdateCheck | quote }}
    AUTHENTIK_DISABLE_STARTUP_ANALYTICS: {{ .Values.authentik.general.disableStartupAnalytics | quote }}
    AUTHENTIK_DEFAULT_USER_CHANGE_NAME: {{ .Values.authentik.general.allowUserChangeName | quote }}
    AUTHENTIK_DEFAULT_USER_CHANGE_EMAIL: {{ .Values.authentik.general.allowUserChangeEmail | quote }}
    AUTHENTIK_DEFAULT_USER_CHANGE_USERNAME: {{ .Values.authentik.general.allowUserChangeUsername | quote }}
    AUTHENTIK_GDPR_COMPLIANCE: {{ .Values.authentik.general.gdprCompliance | quote }}
    AUTHENTIK_DEFAULT_TOKEN_LENGTH: {{ .Values.authentik.general.tokenLength | quote }}
    AUTHENTIK_IMPERSONATION: {{ .Values.authentik.general.impersonation | quote }}

{{- if .Values.authentik.outposts.proxy.enabled }}
proxy:
  enabled: true
  data:
    AUTHENTIK_LISTEN__HTTP: {{ printf "0.0.0.0:%v" .Values.service.proxy.ports.http.port | quote }}
    AUTHENTIK_LISTEN__HTTPS: {{ printf "0.0.0.0:%v" .Values.service.proxy.ports.https.port | quote }}
    AUTHENTIK_LISTEN__METRICS: {{ printf "0.0.0.0:%v" .Values.service.proxymetrics.ports.proxymetrics.port | quote }}
    AUTHENTIK_HOST: {{ .Values.authentik.outposts.proxy.host | default $serverHost }}
    AUTHENTIK_INSECURE: "true"
    # TODO: node ip or ingress host
    AUTHENTIK_HOST_BROWSER: {{ .Values.authentik.outposts.proxy.browserHost | default  $host }}
{{- end -}}

{{- if .Values.authentik.outposts.radius.enabled }}
radius:
  enabled: true
  data:
    AUTHENTIK_LISTEN__RADIUS: {{ printf "0.0.0.0:%v" .Values.service.radius.ports.radius.port | quote }}
    AUTHENTIK_LISTEN__METRICS: {{ printf "0.0.0.0:%v" .Values.service.radiusmetrics.ports.radiusmetrics.port | quote }}
    AUTHENTIK_HOST: {{ $serverHost }}
    AUTHENTIK_INSECURE: "true"
    # TODO: node ip or ingress host
    AUTHENTIK_HOST_BROWSER: {{ $host }}
{{- end -}}

{{- if .Values.authentik.outposts.ldap.enabled }}
ldap:
  enabled: true
  data:
    AUTHENTIK_LISTEN__LDAP: {{ printf "0.0.0.0:%v" .Values.service.ldap.ports.ldap.port | quote }}
    AUTHENTIK_LISTEN__LDAPS: {{ printf "0.0.0.0:%v" .Values.service.ldaps.ports.ldaps.port | quote }}
    AUTHENTIK_LISTEN__METRICS: {{ printf "0.0.0.0:%v" .Values.service.ldapmetrics.ports.ldapmetrics.port | quote }}
    AUTHENTIK_HOST: {{ $serverHost }}
    AUTHENTIK_INSECURE: "true"
    # TODO: node ip or ingress host
    AUTHENTIK_HOST_BROWSER: {{ $host }}
{{- end -}}

{{- if .Values.authentik.geoip.enabled }}
geoip:
  enabled: true
  data:
    GEOIPUPDATE_EDITION_IDS: {{ .Values.authentik.geoip.editionID }}
    GEOIPUPDATE_FREQUENCY: {{ .Values.authentik.geoip.frequency | quote }}
    GEOIPUPDATE_DB_DIR: {{ .Values.persistence.geoip.targetSelector.geoip.geoip.mountPath | quote }}
{{- end -}}

{{- end -}}
