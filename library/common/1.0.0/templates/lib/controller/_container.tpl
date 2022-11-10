{{/* The main container included in the controller */}}
{{- define "ix.v1.common.controller.mainContainer" -}}
- name: {{ include "ix.v1.common.names.fullname" . }}
  image: TODO:!!
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- with .Values.command }}
  command:
    {{- if kindIs "string" . }}
    - {{ tpl . $ }}
    {{- else }}
      {{- tpl ( toYaml . ) $ | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- if or (.Values.extraArgs) (.Values.args) }}
  args:
  {{- with .Values.args }} {{/* args usually defined while developing the chart */}}
    {{- if kindIs "string" . }}
    - {{ tpl . $ }}
    {{- else }}
      {{- tpl ( toYaml . ) $ | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with .Values.extraArgs }} {{/* extraArgs used in cases that users wants to APPEND to args */}}
    {{- if kindIs "string" . }}
    - {{ tpl . $ }}
    {{- else }}
      {{- tpl ( toYaml . ) $ | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- end }}
  {{- with .Values.tty }}
  tty: {{ . }}
  {{- end }}
  {{- with .Values.stdin }}
  stdin: {{ . }}
  {{- end }}

{{- end -}}
