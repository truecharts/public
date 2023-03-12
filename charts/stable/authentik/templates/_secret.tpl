{{/* Define the secret */}}
{{- define "authentik.secret" -}}

{{- $token := randAlphaNum 128 }}
{{- $authentikSecretName := (printf "%s-authentik-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

authentik-secret:
  enabled: true
  data:
    {{/* Secret Key */}}
    {{- with (lookup "v1" "Secret" .Release.Namespace $authentikSecretName) }}
    AUTHENTIK_SECRET_KEY: {{ index .data "AUTHENTIK_SECRET_KEY" | b64dec }}
    {{ $token = index .data "AUTHENTIK_BOOTSTRAP_TOKEN" | b64dec }}
    {{- else }}
    AUTHENTIK_SECRET_KEY: {{ randAlphaNum 32 }}
    {{- end }}
    AUTHENTIK_BOOTSTRAP_TOKEN: {{ $token }}
    {{/* Dependencies */}}
    AUTHENTIK_POSTGRESQL__PASSWORD: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
    AUTHENTIK_REDIS__PASSWORD: {{ .Values.redis.redisPassword | trimAll "\"" }}
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

{{- if .Values.geoip.enabled }}
geoip-secret:
  enabled: true
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

ldap-secret:
  enabled: true
  data:
    {{- with .Values.outposts.ldap.token }}
    AUTHENTIK_TOKEN: {{ . }}
    {{- else }}
    AUTHENTIK_TOKEN: {{ $token }}
    {{- end }}

proxy-secret:
  enabled: true
  data:
    {{- with .Values.outposts.proxy.token }}
    AUTHENTIK_TOKEN: {{ . }}
    {{- else }}
    AUTHENTIK_TOKEN: {{ $token }}
    {{- end }}
{{- end }}
