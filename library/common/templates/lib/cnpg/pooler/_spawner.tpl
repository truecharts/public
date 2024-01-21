{{- define "tc.v1.common.lib.cnpg.spawner.pooler" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if not (hasKey $objectData "pooler") -}}
    {{- $_ := set $objectData "pooler" dict -}}
  {{- end -}}

  {{- $monitoring := false -}}
  {{- if (hasKey $objectData "monitoring") -}}
    {{- if (kindIs "bool" $objectData.monitoring.enablePodMonitor) -}}
      {{- $monitoring := $objectData.monitoring.enablePodMonitor -}}
    {{- end -}}
  {{- end -}}

  {{- $_ := set $objectData.pooler "type" "rw" -}}
  {{/* Validate Pooler */}}
  {{- include "tc.v1.common.lib.cnpg.pooler.validation" (dict "objectData" $objectData) -}}

  {{/* Create the RW Pooler object  */}}
  {{- include "tc.v1.common.class.cnpg.pooler" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}

  {{- if $monitoring -}} {{/* TODO: Unit tests for Pooler Metrics */}}
    {{- $poolerMetrics := include "tc.v1.common.lib.cnpg.metrics.pooler" (dict "poolerName" (printf "%s-rw" $objectData.name)) | fromYaml -}}
    {{- $_ := set $.Values.metrics (printf "cnpg-%s-rw" $objectData.shortName) $poolerMetrics -}}
  {{- end -}}

  {{- if $objectData.pooler.createRO -}}
    {{- $_ := set $objectData.pooler "type" "ro" -}}

    {{/* Validate Pooler */}}
    {{- include "tc.v1.common.lib.cnpg.pooler.validation" (dict "objectData" $objectData) -}}
    {{/* Create the RO Pooler object  */}}
    {{- include "tc.v1.common.class.cnpg.pooler" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}

    {{- if $monitoring -}} {{/* TODO: Unit tests for Pooler Metrics */}}
      {{- $poolerMetrics := include "tc.v1.common.lib.cnpg.metrics.pooler" (dict "poolerName" (printf "%s-rw" $objectData.name)) | fromYaml -}}
      {{- $_ := set $.Values.metrics (printf "cnpg-%s-ro" $objectData.shortName) $poolerMetrics -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
