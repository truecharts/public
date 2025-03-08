{{- define "prometheus.prometheus.servicemonitor" -}}
{{- if and .Values.prometheus.enabled .Values.prometheus.serviceMonitor.enabled }}
---
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: {{ template "kube-prometheus.prometheus.fullname" . }}
  namespace: {{ .Release.Namespace }}
  labels: {{- include "kube-prometheus.prometheus.labels" . | nindent 4 }}
spec:
  selector:
    matchLabels: {{- include "kube-prometheus.prometheus.matchLabels" . | nindent 6 }}
  namespaceSelector:
    matchNames:
      - {{ .Release.Namespace }}
  endpoints:
    - port: http
      {{- if .Values.prometheus.serviceMonitor.interval }}
      interval: {{ .Values.prometheus.serviceMonitor.interval }}
      {{- end }}
      path: {{ trimSuffix "/" .Values.prometheus.routePrefix }}/metrics
      {{- if .Values.prometheus.serviceMonitor.metricRelabelings }}
      metricRelabelings: {{- include "tc.v1.common.tplvalues.render" ( dict "value" .Values.prometheus.serviceMonitor.metricRelabelings "context" $) | nindent 8 }}
      {{- end }}
      {{- if .Values.prometheus.serviceMonitor.relabelings }}
      relabelings: {{- toYaml .Values.prometheus.serviceMonitor.relabelings | nindent 8 }}
      {{- end }}
{{- end }}
{{- end }}
