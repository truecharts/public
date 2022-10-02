{{- define "briefkasten.createdb" -}}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: {{ .Values.image.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-config'
command: ["/bin/bash", "-c"]
args:
  - |-
    pnpm db:push
{{- end -}}
