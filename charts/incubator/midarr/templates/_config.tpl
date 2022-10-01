{{/* Define the configmap */}}
{{- define "midarr.config" -}}

{{- $configName := printf "%s-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  DB_USERNAME: {{ .Values.postgresql.postgresqlUsername }}
  DB_DATABASE: {{ .Values.postgresql.postgresqlDatabase }}
  DB_HOSTNAME: {{ printf "%v-%v" .Release.Name "postgresql" }}
  {{- with .Values.midarr.admin.mail }}
  SETUP_ADMIN_EMAIL: {{ . }}
  {{- end }}
  {{- with .Values.midarr.admin.name }}
  SETUP_ADMIN_NAME: {{ . }}
  {{- end }}
  {{- with .Values.midarr.radarr.base_url }}
  RADARR_BASE_URL: {{ . }}
  {{- end }}
  {{- with .Values.midarr.sonarr.base_url }}
  SONARR_BASE_URL: {{ . }}
  {{- end }}
  {{- with .Values.midarr.general.app_url }}
  APP_URL: http://localhost:4000
  {{- end }}
  {{- with .Values.midarr.general.app_mailer_from }}
  APP_MAILER_FROM: example@email.com
  {{- end }}
{{- end -}}
