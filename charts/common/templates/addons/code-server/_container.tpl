{{/*
The code-server sidecar container to be inserted.
*/}}
{{- define "tc.common.addon.codeserver.container" -}}
name: codeserver
image: "{{ .Values.codeserverImage.repository }}:{{ .Values.codeserverImage.tag }}"
imagePullPolicy: {{ .Values.codeserverImage.pullPolicy }}
securityContext:
  runAsUser: 0
  runAsGroup: 0
env:
{{- range $envList := .Values.addons.codeserver.envList }}
  {{- if and $envList.name $envList.value }}
  - name: {{ $envList.name }}
    value: {{ $envList.value | quote }}
  {{- else }}
  {{- fail "Please specify name/value for codeserver environment variable" }}
  {{- end }}
{{- end}}
{{- with .Values.addons.codeserver.env }}
{{- range $k, $v := . }}
  - name: {{ $k }}
    value: {{ $v | quote }}
{{- end }}
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
{{- with (include "tc.common.controller.volumeMounts" . | trim) }}
volumeMounts:
  {{ nindent 2 . }}
{{- end }}
{{- if or .Values.addons.codeserver.git.deployKey .Values.addons.codeserver.git.deployKeyBase64 .Values.addons.codeserver.git.deployKeySecret }}
  - name: deploykey
    mountPath: /root/.ssh/id_rsa
    subPath: id_rsa
{{- end }}
{{- with .Values.addons.codeserver.resources }}
resources:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}
