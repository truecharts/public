{{/* Define the configmap */}}
{{- define "kimai.configmap" -}}

{{- $trusted_hosts := .Values.kimai.trusted_hosts }}

{{- if not (mustHas "localhost" $trusted_hosts) -}}
  {{- $trusted_hosts = mustAppend $trusted_hosts "localhost" }}
{{- end -}}

kimai-config:
  enabled: true
  data:
    {{/* Admin credentials */}}
    ADMINMAIL: {{ .Values.kimai.credentials.ADMINMAIL }}
    ADMINPASS: {{ .Values.kimai.credentials.ADMINPASS }}
    {{/* Trusted Hosts */}}
    TRUSTED_HOSTS: {{ join "," $trusted_hosts }}
    DB_TYPE: mysql
    DB_PORT: "3306"
    DB_USER: {{ .Values.mariadb.mariadbDatabase }}
    DB_BASE: {{ .Values.mariadb.mariadbUsername }}
    APP_ENV: prod
{{- end -}}
