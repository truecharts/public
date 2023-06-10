{{/* Define the secrets */}}
{{- define "authentik.secrets" -}}

{{- $authentikSecretName := printf "%s-authentik-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}
{{- $geoipSecretName := printf "%s-geoip-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}
{{- $ldapSecretName := printf "%s-ldap-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}
{{- $proxySecretName := printf "%s-proxy-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}
{{- $token := randAlphaNum 128 }}

{{/* This secret is loaded in both the main authentik container and worker */}}
{{ $authentikSecretName }}:
  enabled: true
  data:
    {{/* Secret Key */}}
    {{- with (lookup "v1" "Secret" .Release.Namespace $authentikSecretName) }}
    AUTHENTIK_SECRET_KEY: {{ index .data "AUTHENTIK_SECRET_KEY" }}
    {{ $token = index .data "AUTHENTIK_BOOTSTRAP_TOKEN" }}
    {{- else }}
    AUTHENTIK_SECRET_KEY: {{ randAlphaNum 32 }}
    {{- end }}
    AUTHENTIK_BOOTSTRAP_TOKEN: {{ $token }}
    {{/* Dependencies */}}
    AUTHENTIK_POSTGRESQL__PASSWORD: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
    AUTHENTIK_REDIS__PASSWORD: {{ .Values.redis.creds.redisPassword | trimAll "\"" }}
    {{/* Credentials */}}
    {{- with .Values.authentik.credentials.password }}
    AUTHENTIK_BOOTSTRAP_PASSWORD: {{ . }}
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

{{/* This secret is loaded in the geoip container */}}
{{ $geoipSecretName }}:
  enabled: {{ .Values.geoip.enabled }}
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

{{/* This secret is loaded in the ldap container */}}
{{ $ldapSecretName }}:
  enabled: {{ .Values.outposts.ldap.enabled }}
  data:
    {{- with .Values.outposts.ldap.token }}
    AUTHENTIK_TOKEN: {{ . }}
    {{- else }}
    AUTHENTIK_TOKEN: {{ $token }}
    {{- end }}

{{/* This secret is loaded in the proxy container */}}
{{ $proxySecretName }}:
  enabled: {{ .Values.outposts.proxy.enabled }}
  data:
    {{- with .Values.outposts.proxy.token }}
    AUTHENTIK_TOKEN: {{ . }}
    {{- else }}
    AUTHENTIK_TOKEN: {{ $token }}
    {{- end }}
{{- end }}
