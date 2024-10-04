{{/*
This template serves as a blueprint for all Route objects that are created
within the common library.
*/}}
{{- define "tc.v1.common.class.route" -}}
{{- $values := .Values.route -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.route -}}
    {{- $values = . -}}
  {{- end -}}
{{- end -}}

  {{- $routeLabels := $values.labels -}}
  {{- $routeAnnotations := $values.annotations -}}

{{- $fullName := include "tc.v1.common.lib.chart.names.fullname" . -}}
{{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
  {{- $fullName = printf "%v-%v" $fullName $values.nameOverride -}}
{{- end -}}
{{- $routeKind := $values.kind | default "HTTPRoute" -}}

{{/* Get the name of the primary service, if any */}}
{{- $primaryServiceName := (include "tc.v1.common.lib.util.service.primary" (dict "rootCtx" $)) -}}
{{/* Get service values of the primary service, if any */}}
{{- $primaryService := get $.Values.service $primaryServiceName -}}
{{- $defaultServiceName := $fullName -}}

{{- if and (hasKey $primaryService "nameOverride") $primaryService.nameOverride -}}
  {{- $defaultServiceName = printf "%v-%v" $defaultServiceName $primaryService.nameOverride -}}
{{- end -}}
{{- $defaultServicePort := get $primaryService.ports (include "tc.v1.common.lib.util.service.ports.primary" (dict "svcValues" $primaryService "rootCtx" $)) }}

---
apiVersion: gateway.networking.k8s.io/v1alpha2
{{- if and (ne $routeKind "GRPCRoute") (ne $routeKind "HTTPRoute") (ne $routeKind "TCPRoute") (ne $routeKind "TLSRoute") (ne $routeKind "UDPRoute") -}}
  {{- fail (printf "Not a valid route kind (%s)" $routeKind) -}}
{{- end }}
kind: {{ $routeKind }}
metadata:
  name: {{ $fullName }}
  namespace: {{ $.Values.namespace | default $.Values.global.namespace | default $.Release.Namespace }}
  {{- $labels := (mustMerge ($routeLabels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $ | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($routeAnnotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $ | fromYaml)) }}
  annotations:
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "annotations" $annotations) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
spec:
  parentRefs:
  {{- range $values.parentRefs }}
    - group: {{ default "gateway.networking.k8s.io" .group }}
      kind: {{ default "Gateway" .kind }}
      name: {{ required (printf "parentRef name is required for %v %v" $routeKind $fullName) .name }}
      namespace: {{ required (printf "parentRef namespace is required for %v %v" $routeKind $fullName) .namespace }}
      {{- if .sectionName }}
      sectionName: {{ .sectionName | quote }}
      {{- end }}
  {{- end }}
  {{- if and (ne $routeKind "TCPRoute") (ne $routeKind "UDPRoute") $values.hostnames }}
  hostnames:
  {{- with $values.hostnames }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- end }}
  rules:
  {{- range $values.rules }}
  - backendRefs:
    {{- range .backendRefs }}
    - group: {{ default "" .group | quote}}
      kind: {{ default "Service" .kind }}
      name: {{ default $defaultServiceName .name }}
      namespace: {{ default $.Release.Namespace .namespace }}
      port: {{ default $defaultServicePort.port .port }}
      weight: {{ default 1 .weight }}
    {{- end }}
    {{- if (eq $routeKind "HTTPRoute") }}
      {{- with .matches }}
    matches:
        {{- toYaml . | nindent 6 }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
