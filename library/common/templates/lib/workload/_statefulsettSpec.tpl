{{/* StatefulSet Spec */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.workload.statefulsetSpec" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData:
  replicas: The number of replicas.
  revisionHistoryLimit: The number of old ReplicaSets to retain to allow rollback.
  strategy: The statefulset strategy to use to replace existing pods with new ones.
*/}}
{{- define "tc.v1.common.lib.workload.statefulsetSpec" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $strategy := $objectData.strategy | default "RollingUpdate" }}
replicas: {{ $objectData.replicas | default 1 }}
revisionHistoryLimit: {{ $objectData.revisionHistoryLimit | default 3 }}
serviceName: {{ $objectData.name }}
updateStrategy:
  type: {{ $strategy }}
  {{- if and (eq $objectData.strategy "RollingUpdate") $objectData.rollingUpdate -}}
    {{- if (or (hasKey $objectData.rollingUpdate "maxUnavailable") (hasKey $objectData.rollingUpdate "partition")) }}
  rollingUpdate:
      {{- if hasKey $objectData.rollingUpdate "maxUnavailable" }}
    maxUnavailable: {{ $objectData.rollingUpdate.maxUnavailable }}
      {{- end -}}
      {{- if hasKey $objectData.rollingUpdate "partition" }}
    partition: {{ $objectData.rollingUpdate.partition }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
