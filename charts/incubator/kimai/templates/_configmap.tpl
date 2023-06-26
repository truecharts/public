{{/* Define the configmap */}}
{{- define "kimai.configmap" -}}
{{- $trusted_hosts := .Values.kimai.trusted_hosts }}
{{- if (contains "localhost" $trusted_hosts) -}}
  {{- $trusted_hosts := .Values.kimai.trusted_hosts }}
{{- else -}}
  {{- $trusted_hosts := cat .Values.kimai.trusted_hosts ", localhost" -}}
{{- end -}}
{{- $trusted_hosts := regexReplaceAll " " $trusted_hosts "" -}}

kimai-config:
  enabled: true
  data:
    {{/* Admin credentials */}}
    ADMINMAIL: .Values.kimai.credentials.ADMINMAIL
    ADMINPASS: .Values.kimai.credentials.ADMINPASS
    {{/* Trusted Hosts */}}
    TRUSTED_HOSTS: $trusted_hosts

{{- end -}}
