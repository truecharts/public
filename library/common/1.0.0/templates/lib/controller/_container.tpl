{{/* The main container included in the controller */}}
{{- define "ix.v1.common.controller.mainContainer" -}}
- name: {{ include "ix.v1.common.names.fullname" . }}
  image: {{/* TODO: */}}
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- with .Values.command }}
  command:
    {{- if kindIs "string" . }}
    - {{ tpl . $ }}
    {{- else }}
      {{- tpl (toYaml .) $ | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- if or (.Values.extraArgs) (.Values.args) }}
  args:
  {{- with .Values.args }} {{/* args usually defined while developing the chart */}}
    {{- if kindIs "string" . }}
    - {{ tpl . $ }}
    {{- else }}
      {{- tpl (toYaml .) $ | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with .Values.extraArgs }} {{/* extraArgs used in cases that users wants to APPEND to args */}}
    {{- if kindIs "string" . }}
    - {{ tpl . $ }}
    {{- else }}
      {{- tpl (toYaml .) $ | nindent 4 }}
    {{- end }}
  {{- end }}
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
   {{- else }} {{/* TODO: Discuss if we want to pass specific capabilites */}}
    - name: NVIDIA_DRIVER_CAPABILITIES
      value: "all"
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
   {{- with .Values.env -}}
    {{- range $k, $v := . -}}
      {{- $name := $k -}}
      {{- $value := $v -}}
      {{- if kindIs "int" $name -}}
        {{- fail "Environment Variables as a list is not supported. Use key-value format." -}}
      {{- end }}
    - name: {{ $name | quote }}
      {{- if not (kindIs "map" $value) }}
        {{- if or (kindIs "string" $value) }} {{/* Single values are parsed as string (eg. int, bool) */}}
          {{- $value = tpl $value $ }} {{/* Expand Value */}}
        {{- end }}
      value: {{ quote $value }}
      {{- else if kindIs "map" $value }} {{/* If value is a dict... */}}
      valueFrom:
        {{- if hasKey $value "configMapKeyRef" }} {{/* And contains configMapRef... */}}
        configMapKeyRef:
          {{- $_ := set $value "name" $value.configMapKeyRef.name -}} {{/* Extract name and key */}}
          {{- $_ := set $value "key" $value.configMapKeyRef.key -}}
        {{- else if hasKey $value "secretKeyRef" }} {{/* And contains secretpRef... */}}
        secretKeyRef:
          {{- $_ := set $value "name" $value.secretKeyRef.name -}} {{/* Extract name and key */}}
          {{- $_ := set $value "key" $value.secretKeyRef.key -}}
          {{- if (hasKey $value.secretKeyRef "optional") }}
            {{- if (kindIs "bool" $value.secretKeyRef.optional) }}
          optional: {{ $value.secretKeyRef.optional }}
            {{- else }}
              {{- fail (printf "<optional> in secretKeyRef must be a boolean on Environment Variable (%s)" $name) -}}
            {{- end }}
          {{- end }}
        {{- else }}
          {{ fail "Not a valid valueFrom reference. Valid options are (configMapKeyRef and secretKeyRef)"}}
        {{- end }}
          name: {{ tpl (required (printf "<name> for the keyRef is not defined in (%s)" $name) $value.name) $ }} {{/* Expand name and key */}}
          key: {{ tpl (required (printf "<key> for the keyRef is not defined in (%s)" $name) $value.key) $ }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end -}}

{{/*
The "tpl (toYaml somepath) $" is used to expand template content (if any)
Cases like this are when we set these values on another tpl file with template
*/}}
