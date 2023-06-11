{{/* Define the secrets */}}
{{- define "authentik.secrets" -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}
  {{- $fetchname := printf "%v-server-worker" -}}

  {{- $secretKey := randAlphaNum 32 -}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $fetchname) -}}
    {{ $secretKey = index .data "AUTHENTIK_SECRET_KEY" }}
  {{- end }}

server-worker:
  enabled: true
  data:
    {{/* Dependencies */}}
    AUTHENTIK_POSTGRESQL__PASSWORD: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
    AUTHENTIK_REDIS__PASSWORD: {{ .Values.redis.creds.redisPassword | trimAll "\"" }}

    {{/* Secret Key */}}
    AUTHENTIK_SECRET_KEY: {{ $secretKey }}

    {{/* Initial credentials */}}
    AUTHENTIK_BOOTSTRAP_EMAIL: {{ .Values.authentik.credentials.email | quote }}
    AUTHENTIK_BOOTSTRAP_PASSWORD: {{ .Values.authentik.credentials.password | quote }}

    {{/* Mail */}}
    {{- with .Values.authentik.email.host }}
    AUTHENTIK_EMAIL__HOST: {{ . }}
    {{- end -}}
    {{- with .Values.authentik.email.user }}
    AUTHENTIK_EMAIL__USERNAME: {{ . }}
    {{- end -}}
    {{- with .Values.authentik.email.pass }}
    AUTHENTIK_EMAIL__PASSWORD: {{ . }}
    {{- end -}}
    {{- with .Values.authentik.email.from }}
    AUTHENTIK_EMAIL__FROM: {{ . }}
    {{- end }}

geoip:
  enabled: {{ .Values.authentik.geoip.enabled }}
  data:
    GEOIPUPDATE_VERBOSE: "0"
    GEOIPUPDATE_PRESERVE_FILE_TIMES: "1"
    GEOIPUPDATE_ACCOUNT_ID: {{ .Values.authentik.geoip.accountID | quote }}
    GEOIPUPDATE_LICENSE_KEY: {{ .Values.authentik.geoip.licenseKey | quote }}
{{- end -}}
