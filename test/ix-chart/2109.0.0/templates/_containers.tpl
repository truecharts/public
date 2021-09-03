{{/*
Container Command
*/}}
{{- define "containerCommand" }}
{{- if .Values.containerCommand }}
command:
  {{- range .Values.containerCommand }}
  - {{ . | quote}}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Container Args
*/}}
{{- define "containerArgs" }}
{{- if .Values.containerArgs }}
args:
  {{- range .Values.containerArgs }}
  - {{ . | quote}}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Container Environment Variables
*/}}
{{- define "containerEnvVariables" }}
{{- if .Values.containerEnvironmentVariables }}
env:
  {{- range .Values.containerEnvironmentVariables }}
  - name: {{ .name | quote }}
    value: {{ .value | quote }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Container Liveness Probe
*/}}
{{- define "containerLivenssProbe" }}
{{- if .Values.livenessProbe }}
livenessProbe:
  exec:
    command:
      {{ toYaml .Values.livenessProbe.command | indent 16 }}
  initialDelaySeconds: {{ .Values.livenessProbe.initialDelaySeconds }}
  periodSeconds: {{ .Values.periodSeconds }}
{{- end }}
{{- end }}

{{/*
Container Ports
*/}}
{{- define "containerPorts" }}
{{- if or .Values.portForwardingList .Values.hostPortsList }}
ports:
  {{- range $index, $config := .Values.portForwardingList }}
  - containerPort: {{ $config.containerPort }}
  {{- end }}
  {{- range $index, $config := .Values.hostPortsList }}
  - containerPort: {{ $config.containerPort }}
    hostPort: {{ $config.hostPort }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Container Resource Configuration
*/}}
{{- define "containerResourceConfiguration" }}
{{- if .Values.gpuConfiguration }}
resources:
  limits:
    {{- toYaml .Values.gpuConfiguration | nindent 4 }}
{{- end }}
{{- end }}
