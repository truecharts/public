{{/* Define the configmap */}}
{{- define "statping.config" -}}

enabled: true
data:
  PORT: {{ .Values.service.main.ports.main.port | quote }}
  DB_CONN: "postgres"
  DB_DATABASE: {{ .Values.postgresql.postgresqlDatabase | quote }}
  DB_USER: {{ .Values.postgresql.postgresqlUsername | quote }}
  DB_PORT: "5432"
  POSTGRES_SSLMODE: "disable"

  {{- with .Values.statping.name }}
  NAME: {{ . | quote }}
  {{- end -}}
  {{- with .Values.statping.description }}
  DESCRIPTION: {{ . | quote }}
  {{- end -}}
  {{- with .Values.statping.domain }}
  DOMAIN: {{ . | quote }}
  {{- end -}}
  {{- with .Values.statping.language }}
  LANGUAGE: {{ . | quote }}
  {{- end }}

  ADMIN_USER: {{ .Values.statping.admin_user | quote }}
  ADMIN_PASSWORD: {{ .Values.statping.admin_pass | quote }}
  ADMIN_EMAIL: {{ .Values.statping.admin_email | quote }}

  SAMPLE_DATA: {{ .Values.statping.sample_data | quote }}
  ALLOW_REPORTS: {{ .Values.statping.allow_reports | quote }}
  USE_CDN: {{ .Values.statping.use_cdn | quote }}
  DISABLE_LOGS: {{ .Values.statping.disable_logs | quote }}
  DISABLE_COLORS: {{ .Values.statping.disable_colors | quote }}

  {{- with .Values.statping.remove_after }}
  REMOVE_AFTER: {{ . | quote }}
  {{- end -}}
  {{- with .Values.statping.cleanup_interval }}
  CLEANUP_INTERVAL: {{ . | quote }}
  {{- end -}}
{{- end -}}
