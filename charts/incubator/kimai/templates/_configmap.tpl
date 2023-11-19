{{/* Define the configmap */}}
{{- define "kimai.configmap" -}}

{{- $trusted_hosts := .Values.kimai.trusted_hosts -}}

{{- if not (mustHas "localhost" $trusted_hosts) -}}
  {{- $trusted_hosts = mustAppend $trusted_hosts "localhost" -}}
{{- end }}
kimai-config:
  enabled: true
  data:
    APP_ENV: prod
    DB_TYPE: mysql
    DB_PORT: "3306"
    DB_USER: {{ .Values.mariadb.mariadbDatabase }}
    DB_BASE: {{ .Values.mariadb.mariadbUsername }}
    {{/* Admin credentials */}}
    ADMINMAIL: {{ .Values.kimai.credentials.adminMail }}
    ADMINPASS: {{ .Values.kimai.credentials.adminPass | quote }}
    {{/* Trusted Hosts */}}
    TRUSTED_HOSTS: {{ join "," $trusted_hosts }}
    memory_limit: "256M"
{{- end -}}
