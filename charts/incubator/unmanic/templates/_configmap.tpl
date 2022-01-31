{{/* Define the configmap */}}
{{- define "unmanic.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: unmanic-config
data:
  {{- if .Values.scaleGPU }}
  NVIDIA_VISIBLE_DEVICES: "all"
  {{- else }}
  NVIDIA_VISIBLE_DEVICES: "void"
  {{- end }}
{{- end -}}
