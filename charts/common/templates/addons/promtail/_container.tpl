{{/*
The promtail sidecar container to be inserted.
*/}}
{{- define "tc.common.addon.promtail.container" -}}
name: promtail
image: "{{ .Values.promtailImage.repository }}:{{ .Values.promtailImage.tag }}"
imagePullPolicy: {{ .Values.promtailImage.pullPolicy }}

securityContext:
  runAsUser: 0
  runAsGroup: 0

env:
{{- range $envList := .Values.addons.promtail.envList }}
  {{- if and $envList.name $envList.value }}
  - name: {{ $envList.name }}
    value: {{ $envList.value | quote }}
  {{- else }}
  {{- fail "Please specify name/value for promtail environment variable" }}
  {{- end }}
{{- end}}
{{- with .Values.addons.promtail.env }}
{{- range $k, $v := . }}
  - name: {{ $k }}
    value: {{ $v | quote }}
{{- end }}
{{- end }}
args:
{{- range .Values.addons.promtail.args }}
- {{ . | quote }}
{{- end }}
- "-config.file=/etc/promtail/promtail.yaml"
volumeMounts:
  - name: promtail-config
    mountPath: /etc/promtail/promtail.yaml
    subPath: promtail.yaml
    readOnly: true
{{- with (include "tc.common.controller.volumeMounts" . | trim) }}
  {{ nindent 2 . }}
{{- end }}
{{- with .Values.addons.promtail.resources }}
resources:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}
