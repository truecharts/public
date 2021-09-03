{{/* Define the ingressClass */}}
{{- define "traefik.ingressClass" -}}
{{- if .Values.ingressClass.enabled }}
---
kind: IngressClass
metadata:
  annotations:
    ingressclass.kubernetes.io/is-default-class: {{ .Values.ingressClass.isDefaultClass | quote }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  name: {{ .Release.Name }}
spec:
  controller: traefik.io/ingress-controller
{{- end }}
{{- end }}
