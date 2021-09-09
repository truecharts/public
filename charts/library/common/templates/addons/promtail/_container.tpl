{{/*
The promtail sidecar container to be inserted.
*/}}
{{- define "common.addon.promtail.container" -}}
{{- if lt (len .Values.addons.promtail.volumeMounts) 1 }}
{{- fail "At least 1 volumeMount is required for the promtail container" }}
{{- end -}}
name: promtail
image: "{{ .Values.addons.promtail.image.repository }}:{{ .Values.addons.promtail.image.tag }}"
imagePullPolicy: {{ .Values.addons.promtail.pullPolicy }}
{{- with .Values.addons.promtail.securityContext }}
securityContext:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.addons.promtail.env }}
env:
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
{{- with .Values.addons.promtail.volumeMounts }}
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.addons.promtail.resources }}
resources:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}
