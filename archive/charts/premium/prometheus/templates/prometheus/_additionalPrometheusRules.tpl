{{- define "prometheus.prometheus.additionalprometheusrules" -}}
{{- if and .Values.prometheus.enabled .Values.prometheus.additionalPrometheusRules}}
  {{- range .Values.prometheus.additionalPrometheusRules }}
---
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: {{ template "kube-prometheus.name" $ }}-{{ .name }}
  namespace: {{ $.Release.Namespace }}
  labels: {{ include "kube-prometheus.prometheus.labels" $ | nindent 4 }}
spec:
  groups: {{- toYaml .groups | nindent 4 }}
  {{- end }}
{{- end }}
{{- end }}
