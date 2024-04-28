{{/* replicationdestination Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.replicationdestination" (dict "rootCtx" $ "objectData" $objectData "volsyncData" $volsyncData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the replicationdestination.
  labels: The labels of the replicationdestination.
  annotations: The annotations of the replicationdestination.
  data: The data of the replicationdestination.
  namespace: The namespace of the replicationdestination. (Optional)
*/}}

{{- define "tc.v1.common.class.replicationdestination" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $volsyncData := .volsyncData }}
---
apiVersion: volsync.backube/v1alpha1
kind: ReplicationDestination
metadata:
  name: {{ printf "%s-%s-dest" $objectData.name $volsyncData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "replicationdestination") }}
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
  trigger:
    manual: restore-once
  {{ $volsyncData.type }}:
    repository: {{ $volsyncData.repository }}
    copyMethod: {{ $volsyncData.copyMethod | default "Snapshot"}}
    {{- with $volsyncData.dest.capacity }}
    capacity: {{ $volsyncData.dest.capacity }}
    {{- end }}

  {{- include "tc.v1.common.lib.volsync.storage" (dict "rootCtx" $rootCtx "objectData" $objectData "volsyncData" $volsyncData "target" "dest") | trim | nindent 4 }}
  {{- include "tc.v1.common.lib.volsync.cache" (dict "rootCtx" $rootCtx "objectData" $objectData "volsyncData" $volsyncData "target" "dest") | trim | nindent 4 }}
  {{- include "tc.v1.common.lib.volsync.moversecuritycontext" (dict "rootCtx" $rootCtx "objectData" $objectData "volsyncData" $volsyncData "target" "dest") | trim | nindent 4 }}
{{- end -}}
