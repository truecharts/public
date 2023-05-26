{{/* Define the ingressClass */}}
{{- define "traefik.ingressClass" -}}
---
{{ if $.Values.ingressClass.enabled }}
  {{- if .Capabilities.APIVersions.Has "networking.k8s.io/v1/IngressClass" }}
apiVersion: networking.k8s.io/v1
  {{- else if .Capabilities.APIVersions.Has "networking.k8s.io/v1beta1/IngressClass" }}
apiVersion: networking.k8s.io/v1beta1
  {{- else if or (eq .Values.ingressClass.fallbackApiVersion "v1beta1") (eq .Values.ingressClass.fallbackApiVersion "v1") }}
apiVersion: {{ printf "networking.k8s.io/%s" .Values.ingressClass.fallbackApiVersion }}
  {{- else }}
  {{- fail "\n\n ERROR: You must have at least networking.k8s.io/v1beta1 to use ingressClass" }}
  {{- end }}
kind: IngressClass
metadata:
  annotations:
    ingressclass.kubernetes.io/is-default-class: {{ .Values.ingressClass.isDefaultClass | quote }}
  labels:
    {{- include "tc.v1.common.lib.metadata.allLabels" . | nindent 4 }}
  name: {{ .Release.Name }}
spec:
  controller: traefik.io/ingress-controller
{{- end }}
{{- end }}
