{{/* DaemonSet Spec */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.workload.daemonsetSpec" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData:
  revisionHistoryLimit: The number of old ReplicaSets to retain to allow rollback.
  strategy: The daemonset strategy to use to replace existing pods with new ones.
*/}}
{{- define "tc.v1.common.lib.workload.daemonsetSpec" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $strategy := $objectData.strategy | default "RollingUpdate" }}
revisionHistoryLimit: {{ $objectData.revisionHistoryLimit | default 3 }}
updateStrategy:
  type: {{ $strategy }}
  {{- if and (eq $objectData.strategy "RollingUpdate") $objectData.rollingUpdate -}}
    {{ if (or (hasKey $objectData.rollingUpdate "maxUnavailable") (hasKey $objectData.rollingUpdate "maxSurge")) }}
  rollingUpdate:
      {{- if hasKey $objectData.rollingUpdate "maxUnavailable" }}
    maxUnavailable: {{ $objectData.rollingUpdate.maxUnavailable }}
      {{- end -}}
      {{- if hasKey $objectData.rollingUpdate "maxSurge" }}
    maxSurge: {{ $objectData.rollingUpdate.maxSurge }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
