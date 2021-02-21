{{- /*
The main container included in the controller.
*/ -}}
{{- define "common.controller.mainContainer" -}}
- name: {{ include "common.names.fullname" . }}
  image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- with .Values.command }}
  command: {{ . }}
  {{- end }}
  {{- with .Values.args }}
  args: {{ . }}
  {{- end }}
  {{- with .Values.securityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  env:
    - name: PUID
      value: {{ .Values.PUID | quote }}
    - name: PGID
      value: {{ .Values.PGID | quote }}
    - name: UMASK
      value: {{ .Values.UMASK | quote }}
  {{- if .Values.timezone }}
    - name: TZ
      value: {{ .Values.timezone | quote }}
  {{- end }}
  {{- if or .Values.env .Values.envTpl .Values.envValueFrom .Values.envVariable .Values.environmentVariables }}
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
  {{- range $key, $value := .Values.envTpl }}
    - name: {{ $key }}
      value: {{ tpl $value $ | quote }}
  {{- end }}
  {{- range $key, $value := .Values.envValueFrom }}
    - name: {{ $key }}
      valueFrom: 
        {{- $value | toYaml | nindent 8 }}
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
  {{- include "common.custom.configuredAppVolumeMounts" . | indent 2 }}
  {{- if .Values.additionalVolumeMounts }}
    {{- toYaml .Values.additionalVolumeMounts | nindent 2 }}
  {{- end }}
  {{- if eq .Values.controllerType "statefulset"  }}
  {{- range $index, $vct := .Values.volumeClaimTemplates }}
  - mountPath: {{ $vct.mountPath }}
    name: {{ $vct.name }}
  {{- if $vct.subPath }}
    subPath: {{ $vct.subPath }}
  {{- end }}
  {{- end }}
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
