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
{{- if .Values.portForwardingList }}
ports:
  {{- range $index, $config := .Values.portForwardingList }}
  - containerPort: {{ $config.containerPort }}
  {{- end }}
{{- end }}
{{- end }}
