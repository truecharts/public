{{/* Call this template:
{{ include "tc.v1.common.lib.workload.components.strategyType" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData:
  replicas: The number of replicas.
  strategy: The deployment strategy to use to replace existing pods with new ones.
*/}}
{{- define "tc.v1.common.lib.workload.components.strategyType" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $defaultStrategy := .defaultStrategy -}}
  {{- $resource := .resource -}}
  {{- $strategy := $objectData.strategy | default $defaultStrategy -}}

  {{- $replicas := 1 -}}
  {{- if hasKey $objectData "replicas" -}}
    {{- $replicas = $objectData.replicas -}}
  {{- end -}}
  {{- $replicas = $replicas | int -}}

  {{- $volsRWO := list -}}
  {{- range $name, $persistence := $rootCtx.Values.persistence }}
    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                "rootCtx" $rootCtx "objectData" $persistence
                "name" $name "caller" "Volumes"
                "key" "persistence")) -}}

    {{- if (ne $enabled "true") -}}{{- continue -}}{{- end -}}

    {{- $type := ($persistence.type | default $rootCtx.Values.global.fallbackDefaults.persistenceType) -}}
    {{- $typesWithAccessMode := (list "pvc") -}}

    {{- if (mustHas $type $typesWithAccessMode) -}}
      {{- $modes := include "tc.v1.common.lib.pvc.accessModes" (dict "rootCtx" $rootCtx
          "objectData" $persistence "caller" "Volumes") | fromYamlArray
      -}}

      {{- $hasRWO := include "tc.v1.common.lib.pod.volumes.hasRWO" (dict "modes" $modes) -}}
      {{- if ne $hasRWO "true" -}}{{- continue -}}{{- end -}}
      {{- $volsRWO = mustAppend $volsRWO $name -}}
    {{- end -}}
  {{- end -}}

  {{/* If there are any RWO vols, do some checks and add warnings */}}
  {{- if gt (len $volsRWO) 0 -}}
    {{/* RWO + replicas > 1 is a no-no */}}
    {{- if gt $replicas 1 -}}
      {{- include "add.warning" (dict "rootCtx" $rootCtx "warn" (printf
          "WARNING: The [accessModes] on volume(s) [%s] is set to [ReadWriteOnce] with a more than 1 replica. This is not stables" (join "," $volsRWO)
        )) -}}
    {{- else -}}
      {{/* DaemonSets and StatefulSets can have RWO with 1 replica under their supported strategies (OnDelete, RollingUpdate) */}}

      {{- if eq $resource "Deployment" -}}

        {{/* On Deployments with single replicas, warn if strategy is not recreate */}}
        {{- if eq $strategy "Recreate" -}}
          {{- include "add.warning" (dict "rootCtx" $rootCtx "warn" (printf
            "WARNING: The [accessModes] on volume(s) [%s] is set to [ReadWriteOnce] with a single replica and an strategy of [%s]. %s"
            (join "," $volsRWO) $strategy "This is not stable, defaulting to [Recreate] strategy"
          )) -}}
        {{- end -}}
        {{- $strategy = "Recreate" -}}

      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{/* Update strategy */}}
  {{- $_ := set $objectData "strategy" $strategy -}}
{{- end -}}
