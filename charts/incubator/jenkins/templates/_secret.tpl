{{/* Define the secret */}}
{{- define "jenkins.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  JAVA_OPTS: {{ join " " (include "java.opts" . | fromYaml).opts | quote }}
  JENKINS_OPTS: {{ join " " (include "jenkins.opts" . | fromYaml).opts | quote }}
  JENKINS_JAVA_OPTS: {{ join " " (include "jenkins.java.opts" . | fromYaml).opts | quote }}
  PLUGINS_FORCE_UPGRADE: {{ .Values.jenkins.plugins_force_upgrade | quote }}
  TRY_UPGRADE_IF_NO_MARKER: {{ .Values.jenkins.upgrade_if_no_marker | quote }}
{{- end -}}

{{- define "jenkins.java.opts" -}}
opts:
  - -Djenkins.model.Jenkins.slaveAgentPort={{ .Values.service.agent.ports.agent.port }}
  - -Djenkins.model.Jenkins.slaveAgentPortEnforce=true
  {{- range $opt := .Values.jenkins.jenkins_java_opts }}
  - {{ $opt }}
  {{- end }}
{{- end -}}

{{- define "jenkins.opts" -}}
opts:
  - --httpPort={{ .Values.service.main.ports.main.port }}
  {{- range $opt := .Values.jenkins.jenkins_opts }}
  - {{ $opt }}
  {{- end }}
{{- end -}}

{{- define "java.opts" -}}
opts:
  {{- range $opt := .Values.jenkins.java_opts }}
  - {{ $opt }}
  {{- end }}
{{- end -}}
