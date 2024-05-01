{{/* replicationsource Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.replicationsource" (dict "rootCtx" $ "objectData" $objectData "volsyncData" $volsyncData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the replicationsource.
  labels: The labels of the replicationsource.
  annotations: The annotations of the replicationsource.
  data: The data of the replicationsource.
  namespace: The namespace of the replicationsource. (Optional)
*/}}

{{- define "tc.v1.common.class.replicationsource" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $volsyncData := .volsyncData -}}

  {{- $schedule := "0 0 * * *" -}}
  {{- if and $volsyncData.src.trigger $volsyncData.src.trigger.schedule -}}
    {{- $schedule = $volsyncData.src.trigger.schedule -}}
  {{- end }}

  {{- $retain := dict "hourly" 24 "daily" 7 "weekly" 5 -}}
  {{- if $volsyncData.src.retain -}}
    {{- $items := list "hourly" "daily" "weekly" -}}
    {{- range $item := $items -}}
      {{- with get $volsyncData.src.retain $item -}}
        {{- $_ := set $retain $item . -}}
      {{- end -}}
    {{- end -}}
  {{- end }}
---
apiVersion: volsync.backube/v1alpha1
kind: ReplicationSource
metadata:
  name: {{ printf "%s-%s" $objectData.name $volsyncData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Replication Source") }}
  {{- $labels := (mustMerge ($volsyncData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($volsyncData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  sourcePVC: {{ $objectData.name }}
  trigger:
    schedule: {{ $schedule }}
  {{ $volsyncData.type }}:
    repository: {{ $volsyncData.repository }}
    copyMethod: {{ $volsyncData.copyMethod | default "Snapshot" }}
    pruneIntervalDays: {{ $volsyncData.src.pruneIntervalDays | default 7 }}
    retain:
      hourly: {{ $retain.hourly }}
      daily: {{ $retain.daily }}
      weekly: {{ $retain.weekly }}
    {{- include "tc.v1.common.lib.volsync.storage" (dict "rootCtx" $rootCtx "objectData" $objectData "volsyncData" $volsyncData "target" "src") | trim | nindent 4 }}
    {{- include "tc.v1.common.lib.volsync.cache" (dict "rootCtx" $rootCtx "objectData" $objectData "volsyncData" $volsyncData "target" "src") | trim | nindent 4 }}
    {{- include "tc.v1.common.lib.volsync.moversecuritycontext" (dict "rootCtx" $rootCtx "objectData" $objectData "volsyncData" $volsyncData "target" "src") | trim | nindent 4 }}
{{- end }}
