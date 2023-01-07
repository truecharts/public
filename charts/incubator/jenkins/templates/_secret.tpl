{{/* Define the secret */}}
{{- define "jenkins.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) -}}

{{- $java_opts := list -}}
{{- $java_opts = mustAppend $java_opts .Values.jenkins.java_opts -}}
{{- $jenkin_opts := (include "jenkins.opts" . | fromYaml).opts -}}
{{- $jenkin_opts = mustAppend $jenkin_opts .Values.jenkins.jenkins_java_opts }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  JAVA_OPTS: {{ join " "  $java_opts | quote }}
  JENKINS_JAVA_OPTS: {{ join " " $jenkin_opts | quote }}


  PLUGINS_FORCE_UPGRADE: {{ default false .Values.jenkins.plugins_force_upgrade | quote }}
  TRY_UPGRADE_IF_NO_MARKER: {{ default false .Values.jenkins.upgrade_if_no_marker | quote }}
{{- end -}}

{{- define "jenkins.opts" -}}
opts:
  - --httpPort={{ .Values.service.main.ports.main.port }}
  - -Djenkins.model.Jenkins.slaveAgentPort={{ .Values.service.agent.ports.agent.port }}
{{- end -}}
