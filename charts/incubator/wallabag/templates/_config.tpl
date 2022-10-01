{{/* Define the configmap */}}
{{- define "wallabag.config" -}}

{{- $configName := printf "%s-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  SYMFONY__ENV__DATABASE_DRIVER: pdo_pgsql
  SYMFONY__ENV__DATABASE_HOST: {{ printf "%v-%v" .Release.Name "postgresql" }}
  SYMFONY__ENV__DATABASE_PORT: "5432"
  SYMFONY__ENV__DATABASE_NAME: {{ .Values.postgresql.postgresqlDatabase }}
  SYMFONY__ENV__DATABASE_USER: {{ .Values.postgresql.postgresqlUsername }}
  SYMFONY__ENV__REDIS_HOST: {{ printf "%v-%v" .Release.Name "redis" }}
  SYMFONY__ENV__REDIS_PORT: "6379"
  SYMFONY__ENV__LOCALE:
  {{- with .Values.wallabag.general.locale }}
  SYMFONY__ENV__LOCALE: {{ . }}
  {{- end }}
  {{- with .Values.wallabag.mail.host }}
  SYMFONY__ENV__MAILER_HOST: {{ . }}
  {{- end }}
  {{- with .Values.wallabag.mail.user }}
  SYMFONY__ENV__MAILER_USER: {{ . }}
  {{- end }}
  {{- with .Values.wallabag.mail.from }}
  SYMFONY__ENV__FROM_EMAIL: {{ . }}
  {{- end }}
  SYMFONY__ENV__TWOFACTOR_AUTH: {{ .Values.wallabag.two_factor.enabled | quote }}
  {{- with .Values.wallabag.two_factor.from }}
  SYMFONY__ENV__TWOFACTOR_SENDER: {{ . }}
  {{- end }}
  SYMFONY__ENV__FOSUSER_REGISTRATION: {{ .Values.wallabag.fosuser.registration | quote }}
  SYMFONY__ENV__FOSUSER_CONFIRMATION: {{ .Values.wallabag.fosuser.confirmation | quote }}
  {{- with .Values.wallabag.general.app_url }}
  SYMFONY__ENV__DOMAIN_NAME: {{ . }}
  {{- end }}
  {{- with .Values.wallabag.general.server_name }}
  SYMFONY__ENV__SERVER_NAME: {{ . }}
  {{- end }}
{{- end -}}
