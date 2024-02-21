{{/* Define the ingressRoute */}}
{{- define "traefik.ingressRoute" -}}
{{ if .Values.ingressRoute.dashboard.enabled }}

{{- $ingressRouteLabels := .Values.ingressRoute.dashboard.labels }}
{{- $ingressRouteAnnotations := .Values.ingressRoute.dashboard.annotations }}

---
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: {{ include "tc.v1.common.lib.chart.names.fullname" . }}-dashboard
  {{- $labels := (mustMerge ($ingressRouteLabels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $ | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (mustMerge ($ingressRouteAnnotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $ | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}

spec:
  entryPoints:
    - main
  routes:
  - match: PathPrefix(`/dashboard`) || PathPrefix(`/api`)
    kind: Rule
    services:
    - name: api@internal
      kind: TraefikService
{{ end }}
{{- end }}
