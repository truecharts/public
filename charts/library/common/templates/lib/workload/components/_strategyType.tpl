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
  {{- $strategy := $objectData.strategy | default "Recreate" -}}
  {{- $replicas := 1 -}}
  {{- if hasKey $objectData "replicas" -}}
    {{- $replicas = $objectData.replicas -}}
  {{- end -}}

  {{- if eq $replicas 1 -}}
    {{- range $name, $persistence := .Values.persistence }}
      {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                  "rootCtx" $rootCtx "objectData" $persistenceValues
                  "name" $name "caller" "Volumes"
                  "key" "persistence")) -}}

      {{- if (ne $enabled "true") -}}{{- continue -}}{{- end -}}

      {{- $type := ($persistence.type | default $rootCtx.Values.global.fallbackDefaults.persistenceType) -}}
      {{- $typesWithAccessMode := (list "pvc") -}}

      {{- if (mustHas $type $typesWithAccessMode) -}}
        {{- $modes := include "tc.v1.common.lib.pvc.accessModes" (dict "rootCtx" $rootCtx
            "objectData" $persistence "caller" "Volumes") | fromYamlArray
        -}}

        {{- $hasRWO := include "tc.v1.common.lib.pod.volumes.hasRWO" (dict "modes" $modes) | toBool -}}

        {{- if $hasRWO -}}
          {{- $strategy = "Recreate" -}}
          {{- include "add.warning" (dict "rootCtx" $rootCtx "warn" (printf
            "WARNING: The [accessModes] on volume [%s] is set to [ReadWriteOnce] with a single replica and an strategy of [%s]. This is not stable, defaulting to [Recreate] strategy" $name $strategy))
          -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- set $objectData.strategy $strategy -}}
{{- end -}}
