{{/* Define the worker container */}}
{{- define "inventree.worker" -}}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
command: ["invoke", "worker"]
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
volumeMounts:
  - name: data
    mountPath: "/home/inventree/data"
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-inventree-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-inventree-config'
{{- end -}}
