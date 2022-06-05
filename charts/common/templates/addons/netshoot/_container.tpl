{{/*
The netshoot sidecar container to be inserted.
*/}}
{{- define "tc.common.addon.netshoot.container" -}}
name: netshoot
image: "{{ .Values.netshootImage.repository }}:{{ .Values.netshootImage.tag }}"
imagePullPolicy: {{ .Values.netshootImage.pullPolicy }}

securityContext:
  runAsUser: 0
  runAsGroup: 0
  capabilities:
    add:
      - NET_ADMIN

env:
{{- range $envList := .Values.addons.netshoot.envList }}
  {{- if and $envList.name $envList.value }}
  - name: {{ $envList.name }}
    value: {{ $envList.value | quote }}
  {{- else }}
  {{- fail "Please specify name/value for netshoot environment variable" }}
  {{- end }}
{{- end}}
{{- with .Values.addons.netshoot.env }}
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
