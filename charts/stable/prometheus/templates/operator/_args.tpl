{{/* Define the args */}}
{{- define "prometheus.operator.args" -}}
args:
  {{- if .Values.operator.kubeletService.enabled }}
  - --kubelet-service={{ .Values.operator.kubeletService.namespace }}/{{ template "kube-prometheus.fullname" . }}-kubelet
  {{- end }}
  {{- if .Values.operator.logFormat }}
  - --log-format={{ .Values.operator.logFormat }}
  {{- end }}
  {{- if .Values.operator.logLevel }}
  - --log-level={{ .Values.operator.logLevel }}
  {{- end }}
  - --localhost=127.0.0.1
  - --prometheus-config-reloader=$(PROMETHEUS_CONFIG_RELOADER)
  {{- if .Values.operator.configReloaderResources.requests }}
    {{- if .Values.operator.configReloaderResources.requests.cpu }}
  - --config-reloader-cpu-request={{ .Values.operator.configReloaderResources.requests.cpu }}
    {{- end }}
    {{- if .Values.operator.configReloaderResources.requests.memory }}
  - --config-reloader-memory-request={{ .Values.operator.configReloaderResources.requests.memory }}
    {{- end }}
  {{- end }}
  {{- if .Values.operator.configReloaderResources.limits }}
    {{- if .Values.operator.configReloaderResources.limits.cpu }}
  - --config-reloader-cpu-limit={{ .Values.operator.configReloaderResources.limits.cpu }}
    {{- end }}
    {{- if .Values.operator.configReloaderResources.limits.memory }}
  - --config-reloader-memory-limit={{ .Values.operator.configReloaderResources.limits.memory }}
    {{- end }}
  {{- end }}
{{- end -}}
