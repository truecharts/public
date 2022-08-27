{{/* Define the init container */}}
{{- define "inventree.init" -}}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
command: ["sh", "-c"]
args:
  - |-
    echo "Staring invoke update!"
    echo "Staring at $(pwd)"
    ls -ls
    invoke update
    echo "Init done!"
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
