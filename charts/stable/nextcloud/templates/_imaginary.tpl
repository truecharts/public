{{/* Define the imaginary container */}}
{{- define "nextcloud.imaginary" -}}
image: {{ .Values.imaginaryImage.repository }}:{{ .Values.imaginaryImage.tag }}
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
securityContext:
  runAsUser: 33
  runAsGroup: 33
  readOnlyRootFilesystem: true
  runAsNonRoot: true
ports:
  - containerPort: 9090
args: ["-enable-url-source"]
env:
  - name: PORT:
    value: 9090
{{- end -}}
