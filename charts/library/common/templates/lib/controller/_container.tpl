{{- /* The main container included in the controller */ -}}
{{- define "common.controller.mainContainer" -}}
- name: {{ include "common.names.fullname" . }}
  image: {{ printf "%s:%s" .Values.image.repository (default .Chart.AppVersion .Values.image.tag) | quote }}
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- with .Values.command }}
  command:
    {{- if kindIs "string" . }}
    - {{ . }}
    {{- else }}
      {{ toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with .Values.args }}
  args:
    {{- if kindIs "string" . }}
    - {{ . }}
    {{- else }}
    {{ toYaml . | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- with .Values.securityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.lifecycle }}
  lifecycle:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.termination.messagePath }}
  terminationMessagePath: {{ . }}
  {{- end }}
  {{- with .Values.termination.messagePolicy }}
  terminationMessagePolicy: {{ . }}
  {{- end }}

  env:
   {{- if .Values.securityContext.readOnlyRootFilesystem }}
    - name: S6_READ_ONLY_ROOT
      value: "1"
   {{- end }}
   {{- range $key, $value := .Values.envTpl }}
    - name: {{ $key }}
      value: {{ tpl $value $ | quote }}
   {{- end }}
   {{- range $key, $value := .Values.envValueFrom }}
    - name: {{ $key }}
      valueFrom:
        {{- if $value.secretKeyRef }}
        secretKeyRef:
          name: {{ tpl $value.secretKeyRef.name $ | quote }}
          key: {{ tpl $value.secretKeyRef.key $ | quote }}
        {{- else if $value.configMapRef }}
        configMapRef:
          name: {{ tpl $value.configMapRef.name $ | quote }}
          key: {{ tpl $value.configMapRef.key $ | quote }}
        {{- else }}
        {{- $value | toYaml | nindent 8 }}
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
          {{- toYaml $value | nindent 6 }}
        {{- else }}
          {{- dict "valueFrom" $value | toYaml | nindent 6 }}
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
  envFrom:
  {{- range .Values.envFrom -}}
  {{- if  .secretRef }}
    - secretRef:
        name: {{ tpl .secretRef.name $ | quote }}
  {{- else if  .configMapRef }}
    - configMapRef:
        name: {{ tpl .configMapRef.name $ | quote }}
  {{- else }}
  {{- end }}
  {{- end -}}
  {{- if .Values.secret }}
    - secretRef:
        name: {{ include "common.names.fullname" . }}
  {{- end }}
  ports:
  {{- include "common.controller.ports" . | trim | nindent 4 }}
  {{- with (include "common.controller.volumeMounts" . | trim) }}
  volumeMounts:
    {{ nindent 4 . }}
  {{- end }}
  {{- include "common.controller.probes" . | trim | nindent 2 }}
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
