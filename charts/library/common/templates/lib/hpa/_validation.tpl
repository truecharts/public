{{- define "tc.v1.common.lib.hpa.validation" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $minReplicas := 1 -}}
  {{- with $objectData.minReplicas -}}
    {{- if not (mustHas (kindOf $objectData.minReplicas) (list "int" "int64" "float64")) -}}
      {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.minReplicas] to be an integer, but got [%s]" $objectData.hpaName (kindOf $objectData.minReplicas)) -}}
    {{- end -}}
    {{- $minReplicas = $objectData.minReplicas -}}
  {{- end -}}

  {{- $maxReplicas := 3 -}}
  {{- with $objectData.maxReplicas -}}
    {{- if not (mustHas (kindOf $objectData.maxReplicas) (list "int" "int64" "float64")) -}}
      {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.maxReplicas] to be an integer, but got [%s]" $objectData.hpaName (kindOf $objectData.maxReplicas)) -}}
    {{- end -}}
    {{- $maxReplicas = $objectData.maxReplicas -}}
  {{- end -}}

  {{- $_ := set $objectData "minReplicas" $minReplicas -}}
  {{- $_ := set $objectData "maxReplicas" $maxReplicas -}}

  {{- if lt $maxReplicas $minReplicas -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.minReplicas] to be less than [hpa.%s.maxReplicas], but got [%d] and [%d]" $objectData.hpaName $objectData.hpaName ($minReplicas | int) ($maxReplicas | int)) -}}
  {{- end -}}

  {{- if $objectData.behavior -}}
    {{- if $objectData.behavior.scaleUp -}}
      {{- include "tc.v1.common.lib.hpa.validation.behavior" (dict "objectData" $objectData "rootCtx" $rootCtx "data" $objectData.behavior.scaleUp "key" "scaleUp") -}}
    {{- end -}}
    {{- if $objectData.behavior.scaleDown -}}
      {{- include "tc.v1.common.lib.hpa.validation.behavior" (dict "objectData" $objectData "rootCtx" $rootCtx "data" $objectData.behavior.scaleDown "key" "scaleDown") -}}
    {{- end -}}
  {{- end -}}

  {{- if $objectData.metrics -}}
    {{- include "tc.v1.common.lib.hpa.validation.metrics" (dict "objectData" $objectData "rootCtx" $rootCtx "data" $objectData.metrics) -}}
  {{- end -}}

{{- end -}}

{{- define "tc.v1.common.lib.hpa.validation.behavior" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $data := .data -}}
  {{- $key := .key -}}

  {{- if $data.selectPolicy -}}
    {{- $validSelectPolicies := list "Max" "Min" "Disabled" -}}
    {{- if not (mustHas $data.selectPolicy $validSelectPolicies) -}}
      {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.behavior.%s.selectPolicy] to be one of [%s], but got [%s]" $objectData.hpaName $key (join ", " $validSelectPolicies) $data.selectPolicy) -}}
    {{- end -}}
  {{- end -}}

  {{- if $data.stabilizationWindowSeconds -}}
    {{- if not (mustHas (kindOf $data.stabilizationWindowSeconds) (list "int" "int64" "float64")) -}}
      {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.behavior.%s.stabilizationWindowSeconds] to be an integer, but got [%s]" $objectData.hpaName $key (kindOf $data.stabilizationWindowSeconds)) -}}
    {{- end -}}
  {{- end -}}

  {{- if $data.policies -}}
    {{- if not (kindIs "slice" $data.policies) -}}
      {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.behavior.%s.policies] to be a list, but got [%s]" $objectData.hpaName $key (kindOf $data.policies)) -}}
    {{- end -}}

    {{- $validPolicies := list "Pods" "Percent" -}}
    {{- range $idx, $policy := $data.policies -}}
      {{- if not (kindIs "map" $policy) -}}
        {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.behavior.%s.policies.%d] to be a map, but got [%s]" $objectData.hpaName $key $idx (kindOf $policy)) -}}
      {{- end -}}

      {{- if not (mustHas $policy.type $validPolicies) -}}
        {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.behavior.%s.policies.%d.type] to be one of [%s], but got [%s]" $objectData.hpaName $key $idx (join ", " $validPolicies) $policy.type) -}}
      {{- end -}}

      {{- if not (mustHas (kindOf $policy.value) (list "int" "int64" "float64")) -}}
        {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.behavior.%s.policies.%d.value] to be an integer, but got [%s]" $objectData.hpaName $key $idx (kindOf $policy.value)) -}}
      {{- end -}}

      {{- if not (mustHas (kindOf $policy.periodSeconds) (list "int" "int64" "float64")) -}}
        {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.behavior.%s.policies.%d.periodSeconds] to be an integer, but got [%s]" $objectData.hpaName $key $idx (kindOf $policy.periodSeconds)) -}}
      {{- end -}}

      {{- if le ($policy.value | int) 0 -}}
        {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.behavior.%s.policies.%d.value] to be greater than 0, but got [%v]" $objectData.hpaName $key $idx $policy.value) -}}
      {{- end -}}

      {{- if or (lt ($policy.periodSeconds | int) 1) (gt ($policy.periodSeconds | int) 1800) -}}
        {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.behavior.%s.policies.%d.periodSeconds] to be between 1 and 1800, but got [%v]" $objectData.hpaName $key $idx $policy.periodSeconds) -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.hpa.validation.metrics" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- if not (kindIs "slice" $objectData.metrics) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics] to be a list, but got [%s]" $objectData.hpaName (kindOf $objectData.metrics)) -}}
  {{- end -}}

  {{- range $idx, $metric := $objectData.metrics -}}
    {{- if not (kindIs "map" $metric) -}}
      {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d] to be a map, but got [%s]" $objectData.hpaName $idx (kindOf $metric)) -}}
    {{- end -}}

    {{- if not (mustHas $metric.type (list "Resource" "Pods" "Object" "External" "ContainerResource")) -}}
      {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.type] to be one of [Resource, Pods, Object, External, ContainerResource], but got [%s]" $objectData.hpaName $idx $metric.type) -}}
    {{- end -}}

    {{- if eq $metric.type "Resource" -}}
      {{- include "tc.v1.common.lib.hpa.validation.metrics.resource" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric "idx" $idx) -}}
    {{- else if eq $metric.type "Pods" -}}
      {{- include "tc.v1.common.lib.hpa.validation.metrics.pods" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric "idx" $idx) -}}
    {{- else if eq $metric.type "Object" -}}
      {{- include "tc.v1.common.lib.hpa.validation.metrics.object" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric "idx" $idx) -}}
    {{- else if eq $metric.type "External" -}}
      {{- include "tc.v1.common.lib.hpa.validation.metrics.external" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric "idx" $idx) -}}
    {{- else if eq $metric.type "ContainerResource" -}}
      {{- include "tc.v1.common.lib.hpa.validation.metrics.containerResource" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric "idx" $idx) -}}
    {{- end -}}

  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.hpa.validation.metrics.resource" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $metric := .metric -}}
  {{- $idx := .idx -}}

  {{- if not (kindIs "map" $metric.resource) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.resource] to be a map, but got [%s]" $objectData.hpaName $idx (kindOf $metric.resource)) -}}
  {{- end -}}

  {{- if or (not $metric.resource.name) (not (kindIs "string" $metric.resource.name)) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.resource.name] to be a string, but got [%s]" $objectData.hpaName $idx (kindOf $metric.resource.name)) -}}
  {{- end -}}

  {{- include "tc.v1.common.lib.hpa.validation.metrics.metric.target" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric.resource "key" "resource" "idx" $idx) -}}
{{- end -}}

{{- define "tc.v1.common.lib.hpa.validation.metrics.containerResource" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $metric := .metric -}}
  {{- $idx := .idx -}}

  {{- if not (kindIs "map" $metric.containerResource) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.containerResource] to be a map, but got [%s]" $objectData.hpaName $idx (kindOf $metric.containerResource)) -}}
  {{- end -}}

  {{- if or (not $metric.containerResource.name) (not (kindIs "string" $metric.containerResource.name)) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.containerResource.name] to be a string, but got [%s]" $objectData.hpaName $idx (kindOf $metric.containerResource.name)) -}}
  {{- end -}}

  {{- include "tc.v1.common.lib.hpa.validation.metrics.metric.target" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric.containerResource "key" "containerResource" "idx" $idx) -}}
{{- end -}}

{{- define "tc.v1.common.lib.hpa.validation.metrics.pods" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $metric := .metric -}}
  {{- $idx := .idx -}}

  {{- if not (kindIs "map" $metric.pods) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.pods] to be a map, but got [%s]" $objectData.hpaName $idx (kindOf $metric.pods)) -}}
  {{- end -}}

  {{- if not (kindIs "map" $metric.pods.metric) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.pods.metric] to be a map, but got [%s]" $objectData.hpaName $idx (kindOf $metric.pods.metric)) -}}
  {{- end -}}

  {{- if or (not $metric.pods.metric.name) (not (kindIs "string" $metric.pods.metric.name)) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.pods.metric.name] to be a string, but got [%s]" $objectData.hpaName $idx (kindOf $metric.pods.metric.name)) -}}
  {{- end -}}

  {{- include "tc.v1.common.lib.hpa.validation.metrics.metric.target" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric.pods "key" "pods" "idx" $idx) -}}
{{- end -}}

{{- define "tc.v1.common.lib.hpa.validation.metrics.object" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $metric := .metric -}}
  {{- $idx := .idx -}}

  {{- if not (kindIs "map" $metric.object) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.object] to be a map, but got [%s]" $objectData.hpaName $idx (kindOf $metric.object)) -}}
  {{- end -}}

  {{- if not (kindIs "map" $metric.object.metric) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.object.metric] to be a map, but got [%s]" $objectData.hpaName $idx (kindOf $metric.object.metric)) -}}
  {{- end -}}

  {{- if or (not $metric.object.metric.name) (not (kindIs "string" $metric.object.metric.name)) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.object.metric.name] to be a string, but got [%s]" $objectData.hpaName $idx (kindOf $metric.object.metric.name)) -}}
  {{- end -}}

  {{- include "tc.v1.common.lib.hpa.validation.metrics.metric.target" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric.object "key" "object" "idx" $idx) -}}
{{- end -}}

{{- define "tc.v1.common.lib.hpa.validation.metrics.external" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $metric := .metric -}}
  {{- $idx := .idx -}}

  {{- if not (kindIs "map" $metric.external) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.external] to be a map, but got [%s]" $objectData.hpaName $idx (kindOf $metric.external)) -}}
  {{- end -}}

  {{- if not (kindIs "map" $metric.external.metric) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.external.metric] to be a map, but got [%s]" $objectData.hpaName $idx (kindOf $metric.external.metric)) -}}
  {{- end -}}

  {{- if or (not $metric.external.metric.name) (not (kindIs "string" $metric.external.metric.name)) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.external.metric.name] to be a string, but got [%s]" $objectData.hpaName $idx (kindOf $metric.external.metric.name)) -}}
  {{- end -}}

  {{- include "tc.v1.common.lib.hpa.validation.metrics.metric.target" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric.external "key" "external" "idx" $idx) -}}
{{- end -}}

{{- define "tc.v1.common.lib.hpa.validation.metrics.metric.target" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $data := .metric -}}
  {{- $key := .key -}}
  {{- $idx := .idx -}}

  {{- if not (kindIs "map" $data.target) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.%s.target] to be a map, but got [%s]" $objectData.hpaName $idx $key (kindOf $data.target)) -}}
  {{- end -}}

  {{- $validTargetTypes := list "AverageValue" "Utilization" -}}
  {{- if not (mustHas $data.target.type $validTargetTypes) -}}
    {{- fail (printf "Horizontal Pod Autoscaler - Expected [hpa.%s.metrics.%d.%s.target.type] to be one of [%s], but got [%s]" $objectData.hpaName $idx $key (join ", " $validTargetTypes) $data.target.type) -}}
  {{- end -}}
{{- end -}}
