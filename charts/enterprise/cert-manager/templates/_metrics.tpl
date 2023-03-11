{{- define "certmanager.metrics" -}}
{{- if .Values.customMetrics.enabled }}
---
apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
  name: cert-manager
  namespace: cert-manager
  labels:
    app: cert-manager
    app.kubernetes.io/name: cert-manager
    app.kubernetes.io/instance: cert-manager
    app.kubernetes.io/component: "controller"
spec:
  jobLabel: app.kubernetes.io/name
  selector:
    matchLabels:
      app: cert-manager
      app.kubernetes.io/name: cert-manager
      app.kubernetes.io/instance: cert-manager
      app.kubernetes.io/component: "controller"
  podMetricsEndpoints:
    - port: http
      honorLabels: true
{{- end }}
{{- end -}}
