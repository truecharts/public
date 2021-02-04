{{- /*
The main container included in the controller.
*/ -}}
{{- define "common.controller.mainContainer" -}}
- name: {{ include "common.names.fullname" . }}
  image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- with .Values.args }}
  args: {{ . }}
  {{- end }}
  {{- with .Values.securityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- if .Values.env }}
  env:
  {{- range $envVariable := .Values.environmentVariables }}
  {{- if and $envVariable.name $envVariable.value }}
    - name: {{ $envVariable.name }}
    value: {{ $envVariable.value | quote }}
  {{- else }}
    {{- fail "Please specify name/value for environment variable" }}
  {{- end }}
  {{- end}}
  {{- range $key, $value := .Values.env }}
  - name: {{ $key }}
    value: {{ $value | quote }}
  {{- end }}
  {{- end }}
  {{- with .Values.envFrom }}
  envFrom:
    {{- toYaml . | nindent 12 }}
  {{- end }}
  {{- include "common.controller.ports" . | trim | nindent 2 }}
  volumeMounts:
  {{- range $index, $PVC := .Values.persistence }}
  {{- if $PVC.enabled }}
  - mountPath: {{ $PVC.mountPath }}
    name: {{ $index }}
  {{- if $PVC.subPath }}
    subPath: {{ $PVC.subPath }}
  {{- end }}
  {{- end }}
  {{- end }}
  {{- include "configuredAppVolumeMounts" . | indent 2 }}
  {{- if .Values.additionalVolumeMounts }}
    {{- toYaml .Values.additionalVolumeMounts | nindent 2 }}
  {{- end }}
  {{- include "common.controller.probes" . | nindent 2 }}
  {{- with .Values.resources }}
  resources:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- if and .Values.gpuConfiguration .Values.resources }}
    limits:
      {{- toYaml .Values.gpuConfiguration | nindent 14 }}
  {{- else if .Values.gpuConfiguration }}
  resources:
    limits:
      {{- toYaml .Values.gpuConfiguration | nindent 14 }}
  {{- end }}
{{- end -}}
