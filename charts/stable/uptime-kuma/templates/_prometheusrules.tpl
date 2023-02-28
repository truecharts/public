{{- define "uptime.prometheusrule" -}}
{{- if hasKey .Values "metrics" }}
{{- if and .Values.metrics.enabled .Values.metrics.prometheusRule.enabled }}
---
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: {{ include "tc.common.names.fullname" . }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
    {{- with .Values.metrics.prometheusRule.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  groups:
    - name: {{ include "tc.common.names.fullname" . }}
      rules:
        {{- with .Values.metrics.prometheusRule.rules }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
{{- end }}
{{- end }}
{{- end -}}
