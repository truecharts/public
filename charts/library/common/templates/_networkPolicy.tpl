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

  {{- with .Values.networkPolicy.policyTypes }}
  policyTypes:
    {{- . | toYaml | nindent 4 }}
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
