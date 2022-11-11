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
    - name: TZ
      value: {{ tpl (toYaml .Values.TZ) $ | quote }}
    - name: UMASK
      value: {{ tpl (toYaml .Values.security.UMASK) $ | quote }}
    - name: UMASK_SET
      value: {{ tpl (toYaml .Values.security.UMASK) $ | quote }}
  {{- if not (.Values.scaleGPU) }}
    - name: NVIDIA_VISIBLE_DEVICES
      value: "void"
  {{- else }}
    - name: NVIDIA_DRIVER_CAPABILITIES
      value: {{ join "," .Values.nvidiaCaps | quote }}
  {{- end }}
  {{- if and (or (not .Values.podSecurityContext.runAsUser) (not .Values.podSecurityContext.runAsGroup))  (or .Values.security.PUID (eq (.Values.security.PUID | int) 0)) }} {{/* If root user or root group and a PUID is set, set PUID and related envs */}}
    - name: PUID
      value: {{ tpl (toYaml .Values.security.PUID) $ | quote }}
    - name: USER_ID
      value: {{ tpl (toYaml .Values.security.PUID) $ | quote }}
    - name: UID
      value: {{ tpl (toYaml .Values.security.PUID) $ | quote }}
    - name: PGID
      value: {{ tpl (toYaml .Values.podSecurityContext.fsGroup) $ | quote }}
    - name: GROUP_ID
      value: {{ tpl (toYaml .Values.podSecurityContext.fsGroup) $ | quote }}
    - name: GID
      value: {{ tpl (toYaml .Values.podSecurityContext.fsGroup) $ | quote }}
  {{- end }}
  {{- if or (.Values.securityContext.readOnlyRootFilesystem) (.Values.securityContext.runAsNonRoot) }} {{/* Mainly for LSIO containers, tell S6 to avoid using rootfs */}}
    - name: S6_READ_ONLY_ROOT
      value: "1"
  {{- end }}
  {{- $context := dict -}} {{/* Create a new context and pass it to envVars include, so tpl can work. */}}
  {{- $_ := set $context "envs" .Values.env -}}
  {{- $_ := set $context "root" $ -}}
  {{- include "ix.v1.common.container.envVars" $context | nindent 4 }}
{{- end -}}

{{/*
The "tpl (toYaml somepath) $" is used to expand template content (if any)
Cases like this are when we set these values on another tpl file with template
*/}}
