{{/*
Blueprint for the NetworkPolicy object that can be included in the addon.
*/}}
{{- define "common.networkpolicy" -}}
{{- if .Values.networkPolicy.enabled }}
---
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  labels:
    {{- include "common.labels" . | nindent 4 }}
  name: {{ include "common.names.fullname" . }}
spec:
  podSelector:
  {{- if .Values.networkPolicy.podSelector }}
  {{- with .Values.networkPolicy.podSelector }}
    {{- . | toYaml | nindent 4 }}
  {{- end -}}
  {{- else }}
    matchLabels:
    {{- include "common.labels.selectorLabels" . | nindent 6 }}
  {{- end }}

  {{- if .Values.networkPolicy.policyType }}
  {{- if eq .Values.networkPolicy.policyType "ingress" }}
  policyTypes: ["Ingress"]
  {{- else if eq .Values.networkPolicy.policyType "egress" }}
  policyTypes: ["Egress"]

  {{- else if eq .Values.networkPolicy.policyType "ingress-egress" }}
  policyTypes: ["Ingress", "Egress"]
  {{- end -}}
  {{- end -}}

  {{- with .Values.networkPolicy.egress }}
  egress:
    {{- . | toYaml | nindent 4 }}
  {{- end -}}

  {{- with .Values.networkPolicy.ingress }}
  ingress:
    {{- . | toYaml | nindent 4 }}
  {{- end -}}

{{- end -}}
{{- end -}}
