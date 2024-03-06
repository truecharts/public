{{/* Define the configmap */}}
{{- define "wisemapping.configmap" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $pgdb := .Values.cnpg.main.database -}}
{{- $pguser := .Values.cnpg.main.user -}}
{{- $pgpassword := .Values.cnpg.main.creds.password | trimAll "\"" -}}
{{- $pghost := .Values.cnpg.main.creds.host | trimAll "\"" -}}

enabled: true
data:

  {{- if .Values.wisemappingConfig }}
  app.properties: |
    {{- .Values.wisemappingConfig | toYaml | nindent 4 }}
  {{- else }}
  app.properties.dummy: |
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
     admin.user = {{ .Values.workload.main.podSpec.containers.main.env.ADMIN_EMAIL }}
     #site.baseurl = http://localhost:8080
     # Site Homepage URL. This will be used as URL for homepage location.
     site.homepage = c/login
     # Font end static content can be deployed externally to the web app. Uncomment here and specify the url base location.
     site.static.js.url = /static
  {{- end }}
{{- end -}}

{{- define "wisemapping.configVolume" -}}
enabled: true
type: configmap
objectName: wisemapping-config
targetSelector:
  main:
    main: {}
    init-config: {}
{{- if .Values.wisemappingConfig }}
mountPath: /usr/local/tomcat/webapps/ROOT/WEB-INF/
items:
  - key: app.properties
    path: app.properties
{{- else  }}
mountPath: /usr/local/tomcat/webapps/ROOT/WEB-INF/dummy
items:
  - key: app.properties.dummy
    path: app.properties.dummy
{{- end -}}
{{- end -}}
