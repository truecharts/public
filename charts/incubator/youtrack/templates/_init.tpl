{{- define "youtrack.init" -}}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: {{ .Values.image.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilysystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
args:
  - configure
  {{- include "youtrack.args" . | nindent 2 -}}
{{- end -}}

{{- define "youtrack.args" -}}
- --listen-port={{ .Values.service.main.ports.main.port }}
{{- end -}}
