{{- define "pydiocells.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.names.fullname" . }}-install
  labels:
    {{- include "common.labels" . | nindent 4 }}
data:
  pydiocells-install: |-
    frontendapplicationtitle: {{ .Values.pydioinstall.title }}
    frontendlogin: {{ .Values.pydioinstall.username }}
    frontendpassword: {{ .Values.pydioinstall.password }}
    frontendrepeatpassword: {{ .Values.pydioinstall.password }}
    dbconnectiontype: tcp
    dbtcphostname: {{ printf "%v-%v" .Release.Name "mariadb" }}
    dbtcpport: 3306
    dbtcpname: {{ .Values.mariadb.mariadbDatabase }}
    dbtcpuser: {{ .Values.mariadb.mariadbUsername }}
    dbtcppassword: {{ .Values.mariadb.mariadbPassword | trimAll "\"" }}

{{- end -}}
