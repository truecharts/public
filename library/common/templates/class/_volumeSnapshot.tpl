{{/* volumesnapshot Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.volumesnapshot" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the volumesnapshot.
  labels: The labels of the volumesnapshot.
  annotations: The annotations of the volumesnapshot.
  namespace: The namespace of the volumesnapshot. (Optional)
*/}}

{{- define "tc.v1.common.class.volumesnapshot" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}
---
apiVersion: snapshot.storage.k8s.io/v1
kind: VolumeSnapshot
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "volumesnapshot") }}
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
  {{- with $objectData.volumeSnapshotClassName }}
  volumeSnapshotClassName: {{ . }}
  {{- end -}}
  {{- if $objectData.source }}
  source:
    {{- with $objectData.source.persistentVolumeClaimName }}
    persistentVolumeClaimName: {{ . }}
    {{- end -}}
    {{- with $objectData.source.volumeSnapshotContentName }}
    volumeSnapshotContentName: {{ . }}
    {{- end -}}
  {{- end -}}
{{- end -}}
