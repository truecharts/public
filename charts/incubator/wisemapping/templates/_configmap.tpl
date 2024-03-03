{{/* Define the configmap */}}
{{- define "wisemapping.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $pgdb := .Values.cnpg.main.database -}}
{{- $pguser := .Values.cnpg.main.user -}}
{{- $pgpassword := .Values.cnpg.main.creds.password | trimAll "\"" -}}
{{- $pghost := .Values.cnpg.main.creds.host | trimAll "\"" -}}

wisemapping-config:
  enabled: true
  data:
    app.properties: |
     ; Database Details
     database.url=jdbc:{{ $pghost }}/wisemapping
     database.driver=org.postgresql.Driver
     database.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
     database.username= {{ $pguser }}
     database.password= {{ $pgpassword }}
     database.validation.enabled=true
     database.validation.query=
     database.validation.enabled=false
     ; Paths
     admin.user = admin@wisemapping.org
     #site.baseurl = http://localhost:8080
     # Site Homepage URL. This will be used as URL for homepage location.
     site.homepage = c/login
     # Font end static content can be deployed externally to the web app. Uncomment here and specify the url base location.
     site.static.js.url = /static

{{- end -}}