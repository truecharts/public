{{/* Define the proxy container */}}
{{- define "briefkaster.createdb" -}}
image: {{ .Values.proxyImage.repository }}:{{ .Values.proxyImage.tag }}
imagePullPolicy: {{ .Values.proxyImage.pullPolicy }}
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
command: ["/bin/sh", "-c"]
args:
  - |-
    pnpm db:push
{{- end -}}
