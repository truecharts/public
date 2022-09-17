{{/* Define the config */}}
{{- define "blocky.configmap" -}}
{{- $configName := printf "%s-config" (include "tc.common.names.fullname" .) }}
{{- $config := merge ( include "blocky.config" . | fromYaml ) ( .Values.blockyConfig ) }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  tc-config.yaml: |
{{ $config | toYaml | indent 6 }}
{{- end -}}

{{- define "blocky.config" -}}
redis:
  address: {{ printf "%v-%v" .Release.Name "redis" }}:6379
  password: {{ .Values.redis.redisPassword | trimAll "\"" }}
  database: 0
  required: true
  connectionAttempts: 10
  connectionCooldown: 3s
{{- if .Values.blocky.enablePrometheus }}
prometheus:
  enable: true
  path: /metrics
{{- end }}
upstream:
  default:
{{- .Values.defaultUpstreams | toYaml | nindent 8 }}

{{- range $id, $value := .Values.upstreams }}
  {{ $value.name }}:
{{- $value.dnsservers | toYaml | nindent 8 }}
{{- end }}

{{- if or .Values.conditional.rewrite .Values.conditional.mapping ( and .Values.k8sgateway.enabled .Values.k8sgateway.domains ) }}
conditional:
{{- if .Values.conditional.rewrite }}
  rewrite:
{{- range $id, $value := .Values.conditional.rewrite }}
    {{ $value.in }}: {{ $value.out }}
{{- end }}
{{- end }}

{{- if or .Values.conditional.mapping ( and .Values.k8sgateway.enabled .Values.k8sgateway.domains ) }}
  mapping:
{{- if and .Values.k8sgateway.enabled .Values.k8sgateway.domains }}
{{- range $id, $value := .Values.k8sgateway.domains }}
    {{ $value.domain }}: 127.0.0.1:{{ .Values.service.k8sgateway.ports.k8sgateway.targetPort }}
{{- end }}
{{- end }}
{{- range $id, $value := .Values.conditional.mapping }}
    {{ $value.domain }}: {{ $value.dnsserver }}
{{- end }}
{{- end }}
{{- end }}

blocking:
  blockType: {{ .Values.blocking.blockType }}
  blockTTL: {{ .Values.blocking.blockTTL }}
  refreshPeriod: {{ .Values.blocking.refreshPeriod }}
  downloadTimeout: {{ .Values.blocking.downloadTimeout }}
  downloadAttempts: {{ .Values.blocking.downloadAttempts }}
  downloadCooldown: {{ .Values.blocking.downloadCooldown }}
  failStartOnListError: {{ .Values.blocking.failStartOnListError }}
  processingConcurrency: {{ .Values.blocking.processingConcurrency }}
{{- if .Values.blocking.whitelist }}
  whiteLists:
{{- range $id, $value := .Values.blocking.whitelist }}
    {{ $value.name }}:
{{- $value.lists | toYaml | nindent 10 }}
{{- end }}
{{- end }}

{{- if .Values.blocking.blacklist }}
  blackLists:
{{- range $id, $value := .Values.blocking.blacklist }}
    {{ $value.name }}:
{{- $value.lists | toYaml | nindent 10 }}
{{- end }}
{{- end }}

{{- if .Values.blocking.clientGroupsBlock }}
  clientGroupsBlock:
{{- range $id, $value := .Values.blocking.clientGroupsBlock }}
    {{ $value.name }}:
{{- $value.groups | toYaml | nindent 10 }}
{{- end }}
{{- end }}

{{- end -}}
