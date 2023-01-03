{{/* Define the secret */}}
{{- define "jenkins.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

{{- $opts := list }}
{{- $opts = mustAppend $opts (printf "--httpPort=%v" .Values.service.main.ports.main.port) -}}
{{- $opts = mustAppend $opts (printf "--httpsPort=%v" .Values.service.main.ports.main.port) -}}

{{- $java := list -}}
{{- $java = mustAppend $java .Values.jenkins.java_opts }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  JENKINS_SLAVE_AGENT_PORT: "{{ .Values.service.agent.ports.agent.port }}"
  JENKINS_JAVA_OPTS: {{ join " " $java | quote }}
  JENKINS_OPTS: {{ printf "%s%s" (join "" $opts) (join "" .Values.jenkins.opts) | quote }}
  PLUGINS_FORCE_UPGRADE: {{ default false .Values.ajenkinsrk.plugins_force_upgrade | quote }}
  TRY_UPGRADE_IF_NO_MARKER: {{ default false .Values.jenkins.upgrade_if_no_marker | quote }}
{{- end -}}
