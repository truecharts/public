{{/* PersistentVolumeClaim Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.pvc" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the PVC.
  labels: The labels of the PVC.
  annotations: The annotations of the PVC.
  size: The size of the PVC. (Default: 1Gi)
  volumeName: The name of the volume to bind to. (Default: "")
  retain: Whether to retain the PVC after deletion. (Default: false)
  storageClass: The storage class to use. (Absent)
*/}}

{{- define "tc.v1.common.class.pvc" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $pvcRetain := $rootCtx.Values.global.fallbackDefaults.pvcRetain -}}
  {{- if (kindIs "bool" $objectData.retain) -}}
    {{- $pvcRetain = $objectData.retain -}}
  {{- end -}}

  {{- $pvcSize := $rootCtx.Values.global.fallbackDefaults.pvcSize -}}
  {{- with $objectData.size -}}
    {{- $pvcSize = tpl . $rootCtx -}}
  {{- end }}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Persistent Volume Claim") }}
  {{- $labels := (mustMerge ($objectData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($objectData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- if $pvcRetain -}}
    {{- $_ := set $annotations "\"helm.sh/resource-policy\"" "keep" -}}
  {{- end -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  {{- include "tc.v1.common.lib.storage.pvc.spec" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 }}
{{- end -}}
