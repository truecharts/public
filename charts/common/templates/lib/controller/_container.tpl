{{/* The main container included in the controller */}}
{{- define "tc.common.controller.mainContainer" -}}
- name: {{ include "tc.common.names.fullname" . }}
  image: {{ include "tc.common.images.selector" . }}
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- with .Values.command }}
  command:
    {{- if kindIs "string" . }}
    - {{ tpl . $ }}
    {{- else }}
      {{ tpl ( toYaml . ) $ | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- if or ( .Values.extraArgs ) ( .Values.args ) }}
  args:
  {{- with .Values.args }}
    {{- if kindIs "string" . }}
    - {{ tpl . $ }}
    {{- else }}
    {{- tpl ( toYaml . ) $ | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with .Values.extraArgs }}
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
  {{- with .Values.securityContext }}
  securityContext:
    {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
  {{- with .Values.lifecycle }}
  lifecycle:
    {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
  {{- with .Values.termination.messagePath }}
  terminationMessagePath: {{ tpl . $ }}
  {{- end }}
  {{- with .Values.termination.messagePolicy }}
  terminationMessagePolicy: {{ tpl . $ }}
  {{- end }}

  env:
   {{- if and ( not .Values.podSecurityContext.runAsUser) ( .Values.security.PUID ) }}
    - name: PUID
      value: {{ tpl ( toYaml .Values.security.PUID ) $ | quote }}
    - name: USER_ID
      value: {{ tpl ( toYaml .Values.security.PUID ) $ | quote }}
    - name: UID
      value: {{ tpl ( toYaml .Values.security.PUID ) $ | quote }}
   {{- end }}
    - name: UMASK
      value: {{ tpl ( toYaml .Values.security.UMASK ) $ | quote }}
    - name: UMASK_SET
      value: {{ tpl ( toYaml .Values.security.UMASK ) $ | quote }}
   {{- if and ( not .Values.podSecurityContext.runAsUser) ( .Values.security.PUID ) }}
    - name: PGID
      value: {{ tpl ( toYaml .Values.podSecurityContext.fsGroup ) $ | quote }}
    - name: GROUP_ID
      value: {{ tpl ( toYaml .Values.podSecurityContext.fsGroup ) $ | quote }}
    - name: GID
      value: {{ tpl ( toYaml .Values.podSecurityContext.fsGroup ) $ | quote }}
   {{- end }}
   {{- if or ( .Values.securityContext.readOnlyRootFilesystem ) ( .Values.securityContext.runAsNonRoot ) }}
    - name: S6_READ_ONLY_ROOT
      value: "1"
   {{- end }}
   {{- if not ( .Values.scaleGPU ) }}
    - name: NVIDIA_VISIBLE_DEVICES
      value: "void"
   {{- else }}
    - name: NVIDIA_DRIVER_CAPABILITIES
      value: "all"
   {{- end }}
    - name: TZ
      value: {{ tpl ( toYaml .Values.TZ ) $ | quote }}
  {{- with .Values.env }}
    {{- range $k, $v := . }}
      {{- $name := $k }}
      {{- $value := $v }}
      {{- if kindIs "int" $name }}
        {{- $name = required "environment variables as a list of maps require a name field" $value.name }}
      {{- end }}
    - name: {{ quote $name }}
      {{- if kindIs "map" $value -}}
        {{- if hasKey $value "value" }}
            {{- $value = $value.value -}}
        {{- else if hasKey $value "valueFrom" }}
      valueFrom: {{- tpl ( toYaml $value.valueFrom ) $ | nindent 8 }}
        {{- else }}
      valueFrom: {{- tpl ( toYaml $value ) $ | nindent 8 }}
        {{- end }}
      {{- end }}
      {{- if not (kindIs "map" $value) }}
        {{- if kindIs "string" $value }}
          {{- $value = tpl $value $ }}
        {{- end }}
      value: {{ quote $value }}
      {{- end }}
    {{- end }}
  {{- end }}
  {{- range $envList := .Values.envList }}
    {{- if and $envList.name $envList.value }}
    - name: {{ $envList.name }}
      value: {{ $envList.value | quote }}
    {{- else }}
    {{- fail "Please specify name/value for environment variable" }}
    {{- end }}
  {{- end}}
  envFrom:
  {{- if .Values.secretEnv }}
    - secretRef:
        name: {{ include "tc.common.names.fullname" . }}
  {{- end }}
  {{- range .Values.envFrom }}
  {{- if  .secretRef }}
    - secretRef:
        name: {{ tpl .secretRef.name $ | quote }}
  {{- else if  .configMapRef }}
    - configMapRef:
        name: {{ tpl .configMapRef.name $ | quote }}
  {{- else }}
  {{- end }}
  {{- end }}
  ports:
  {{- include "tc.common.controller.ports" . | trim | nindent 4 }}
  {{- with (include "tc.common.controller.volumeMounts" . | trim) }}
  volumeMounts:
    {{ nindent 4 . }}
  {{- end }}
  {{- include "tc.common.controller.probes" . | trim | nindent 2 }}
  {{/*
  Merges the TrueNAS SCALE generated GPU info with the .Values.resources dict
  */}}
  {{- $resources := dict "limits" ( .Values.scaleGPU | default dict ) }}
  {{- $resources = merge $resources .Values.resources }}
  resources:
  {{- with $resources }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
