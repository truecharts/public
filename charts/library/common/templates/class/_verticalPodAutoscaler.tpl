{{/*
This template serves as a blueprint for vertical pod autoscaler objects that are created
using the common library.
*/}}
{{- define "tc.v1.common.class.vpa" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $_ := set $objectData "updatePolicy" ($objectData.updatePolicy | default dict) -}}
  {{- $_ := set $objectData "resourcePolicy" ($objectData.resourcePolicy | default dict) }}
---
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "VPA") }}
  {{- $labels := (mustMerge ($objectData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($objectData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  targetRef:
    apiVersion: apps/v1
    kind: {{ $objectData.workload.type }}
    name: {{ $objectData.name }}
  updatePolicy:
    updateMode: {{ $objectData.updatePolicy.updateMode | default "Auto" }}
    {{- with $objectData.updatePolicy.minReplicas }}
    minReplicas: {{ . }}
    {{- end -}}
    {{- if $objectData.updatePolicy.evictionRequirements }}
    evictionRequirements:
      {{- range $req := $objectData.updatePolicy.evictionRequirements }}
      - resources: {{ $req.resources | toJson }}
        changeRequirement: {{ $req.changeRequirement }}
      {{- end }}
    {{- end -}}

{{- end -}}
