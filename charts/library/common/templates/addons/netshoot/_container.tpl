{{/*
The netshoot sidecar container to be inserted.
*/}}
{{- define "common.addon.netshoot.container" -}}
name: netshoot
image: "{{ .Values.netshootImage.repository }}:{{ .Values.netshootImage.tag }}"
imagePullPolicy: {{ .Values.netshootImage.pullPolicy }}
{{- with .Values.addons.netshoot.securityContext }}
securityContext:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.addons.netshoot.env }}
env:
{{- range $k, $v := . }}
  - name: {{ $k }}
    value: {{ $v | quote }}
{{- end }}
{{- end }}
command:
  - /bin/sh
  - -c
  - sleep infinity
{{- with .Values.addons.netshoot.resources }}
resources:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}
