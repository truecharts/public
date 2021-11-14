{{/* Define the ingressRoute */}}
{{- define "traefik.ingressRoute" -}}
{{- if .Values.ingressRoute.dashboard.enabled }}
---
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: {{ include "common.names.fullname" . }}-dashboard
  annotations:
  {{- with .Values.ingressRoute.dashboard.annotations }}
  {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
spec:
  entryPoints:
    - main
  routes:
  - match: PathPrefix(`/dashboard`) || PathPrefix(`/api`)
    kind: Rule
    services:
    - name: api@internal
      kind: TraefikService
{{- end -}}
{{- end -}}
