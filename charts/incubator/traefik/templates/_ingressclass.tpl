{{/* Define the ingressClass */}}
{{- define "traefik.ingressClass" -}}
{{- if and .Values.ingressClass.enabled (semverCompare ">=2.3.0" (default .Chart.AppVersion .Values.image.tag)) -}}
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
    {{- include "common.labels" . | nindent 4 }}
  name: {{ include "common.names.fullname" . }}
spec:
  controller: traefik.io/ingress-controller
{{- end }}
{{- end }}
