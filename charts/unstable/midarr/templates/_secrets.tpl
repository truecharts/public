{{/* Define the secrets */}}
{{- define "midarr.secrets" -}}
{{- $secretName := (printf "%s-midarr-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

{{- $midarr := .Values.midarr -}}

{{- $admin := $midarr.admin -}}
{{- $general := $midarr.general -}}
{{- $radarr := $midarr.radarr -}}
{{- $sonarr := $midarr.sonarr -}}

{{- $host := printf "%v-cnpg-main-rw" (include "tc.v1.common.lib.chart.names.fullname" $) }}
{{- $password := .Values.cnpg.main.creds.password | trimAll "\"" }}

enabled: true
data:
  {{/* DB */}}
  DB_USERNAME: {{ .Values.cnpg.main.user }}
  DB_DATABASE: {{ .Values.cnpg.main.database }}
  DB_HOSTNAME: {{ $host }}
  DB_PASSWORD: {{ $password }}

  {{/* MIDARR */}}
  {{- with $admin.mail }}
  SETUP_ADMIN_EMAIL: {{ . }}
  {{- end }}

  {{- with $admin.name }}
  SETUP_ADMIN_NAME: {{ . }}
  {{- end }}

  {{- with $admin.pass }}
  SETUP_ADMIN_PASSWORD: {{ . | b64enc }}
  {{- end }}

  {{/* GENERAL */}}
  {{- with $general.app_url }}
  APP_URL: http://localhost:4000
  {{- end }}

  {{- with $general.app_mailer_from }}
  APP_MAILER_FROM: {{ . }}
  {{- end }}

  {{- with $general.sendgrid_api_key }}
  SENDGRID_API_KEY: {{ . | b64enc }}
  {{- end }}

  {{/* RADARR */}}
  {{- with $radarr.base_url }}
  RADARR_BASE_URL: {{ . }}
  {{- end }}

  {{- with $radarr.api_key }}
  RADARR_API_KEY: {{ . | b64enc }}
  {{- end }}

  {{/* SONARR */}}
  {{- with $sonarr.base_url }}
  SONARR_BASE_URL: {{ . }}
  {{- end }}

  {{- with $sonarr.api_key }}
  SONARR_API_KEY: {{ . | b64enc }}
  {{- end }}

{{- end -}}
