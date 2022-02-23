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
    FrontendApplicationTitle: {{ .Values.pydioinstall.title }}
    FrontendLogin: {{ .Values.pydioinstall.username }}
    FrontendPassword: {{ .Values.pydioinstall.password }}
    FrontendRepeatPassword: {{ .Values.pydioinstall.password }}
    DbConnectionType: tcp
    DbTCPHostname: {{ printf "%v-%v" .Release.Name "mariadb" }}
    DbTCPPort: 3306
    DbTCPName: {{ .Values.mariadb.mariadbDatabase }}
    DbTCPUser: {{ .Values.mariadb.mariadbUsername }}
    DbTCPPassword: {{ .Values.mariadb.mariadbPassword | trimAll "\"" }}

{{- end -}}
