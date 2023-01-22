{{/*
The code-server sidecar container to be inserted.
*/}}
{{- define "tc.v1.common.addon.codeserver.container" -}}
imageSelector: "codeserverImage"
imagePullPolicy: {{ .Values.codeserverImage.pullPolicy }}
securityContext:
  runAsUser: 0
  runAsGroup: 0
  runAsNonRoot: false
  readOnlyRootFilesystem: false
env:
{{- range $envList := .Values.addons.codeserver.envList -}}
  {{- if and $envList.name $envList.value }}
  {{ $envList.name }}: {{ $envList.value | quote }}
  {{- else }}
    {{- fail "Please specify name/value for codeserver environment variable" -}}
  {{- end -}}
{{- end -}}
{{- with .Values.addons.codeserver.env -}}
{{- range $k, $v := . }}
  {{ $k }}: {{ $v | quote }}
{{- end -}}
{{- end }}
ports:
- name: codeserver
  containerPort: {{ .Values.addons.codeserver.service.ports.codeserver.port }}
  protocol: TCP
args:
{{- range .Values.addons.codeserver.args }}
- {{ . | quote }}
{{- end }}
- "--port"
- "{{ .Values.addons.codeserver.service.ports.codeserver.port }}"
- {{ .Values.addons.codeserver.workingDir | default "/" }}
volumeMounts:
  - inherit: all
resources:
  inherit: true
{{- end -}}
