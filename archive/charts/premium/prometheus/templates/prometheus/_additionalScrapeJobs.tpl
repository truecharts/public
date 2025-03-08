{{- define "prometheus.prometheus.additionalscrapejobs" -}}
{{- if (and .Values.prometheus.additionalScrapeConfigs.enabled (eq .Values.prometheus.additionalScrapeConfigs.type "internal") ) }}
---
apiVersion: v1
kind: Secret
metadata:
  name: additional-scrape-jobs-{{ template "kube-prometheus.prometheus.fullname" . }}
  namespace: {{ .Release.Namespace }}
  labels: {{- include "kube-prometheus.prometheus.labels" . | nindent 4 }}
data:
  scrape-jobs.yaml: {{ include "tc.v1.common.tplvalues.render" ( dict "value" .Values.prometheus.additionalScrapeConfigs.internal.jobList "context" $ ) | b64enc | quote }}
{{- end }}
{{- end }}
