{{/* The main container included in the controller */}}
{{- define "ix.v1.common.controller.mainContainer" -}}
- name: {{ include "ix.v1.common.names.fullname" . }}
  image: {{/* TODO: */}}
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- if .Values.command }}
  command:
  {{- $context := dict -}} {{/* Create a new context and pass it to envVars include, so tpl can work. */}}
  {{- $_ := set $context "commands" .Values.command -}}
  {{- $_ := set $context "root" $ -}}
    {{- include "ix.v1.common.container.command" $context | nindent 4 }}
  {{- end }}
  {{- if or (.Values.extraArgs) (.Values.args) }}
  args:
  {{- $context := dict -}} {{/* Create a new context and pass it to envVars include, so tpl can work. */}}
  {{- $_ := set $context "args" .Values.args -}}
  {{- $_ := set $context "extraArgs" .Values.extraArgs -}}
  {{- $_ := set $context "root" $ -}}
    {{- include "ix.v1.common.container.args" $context | nindent 4 }}
  {{- end }}
  {{- if .Values.tty }}
  tty: true
  {{- else }}
  tty: false
  {{- end }}
  {{- if .Values.stdin }}
  stdin: true
  {{- else }}
  stdin: false
  {{- end }}
  securityContext:
    {{- include "ix.v1.common.container.securityContext" . | nindent 4 }}
  {{- with .Values.lifecycle }}
  lifecycle:
    {{- tpl (toYaml .) $ | nindent 4 }}
  {{- end }}
  {{- with .Values.termination.messagePath }}
  terminationMessagePath: {{ tpl . $ }}
  {{- end }}
  {{- with .Values.termination.messagePolicy }}
  terminationMessagePolicy: {{ tpl . $ }}
  {{- end }}
  env:
  {{- if .Values.injectFixedEnvs -}}
    {{- include "ix.v1.common.container.fixedEnvs" . | nindent 4 -}}
  {{- end -}}
  {{- $context := dict -}} {{/* Create a new context and pass it to envVars include, so tpl can work. */}}
  {{- $_ := set $context "envs" .Values.env -}}
  {{- $_ := set $context "root" $ -}}
  {{- include "ix.v1.common.container.envVars" $context | nindent 4 -}}
  {{- $context := dict -}} {{/* Create a new context and pass it to envList include, so tpl can work. */}}
  {{- $_ := set $context "envList" .Values.envList -}}
  {{- $_ := set $context "root" $ -}}
  {{- include "ix.v1.common.container.envList" $context | nindent 4 -}}
{{- end -}}

{{/*
The "tpl (toYaml somepath) $" is used to expand template content (if any)
Cases like this are when we set these values on another tpl file with template
*/}}
