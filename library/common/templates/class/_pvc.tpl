{{/* PVC Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.pvc" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the PVC.
  labels: The labels of the PVC.
  annotations: The annotations of the PVC.
*/}}

{{- define "tc.v1.common.class.pvc" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $pvcRetain := $rootCtx.Values.fallbackDefaults.pvcRetain -}}
  {{- if (kindIs "bool" $objectData.retain) -}}
    {{- $pvcRetain = $objectData.retain -}}
  {{- end -}}

  {{- $pvcSize := $rootCtx.Values.fallbackDefaults.pvcSize -}}
  {{- with $objectData.size -}}
    {{- $pvcSize = tpl . $rootCtx -}}
  {{- end }}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ $objectData.name }}
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
  accessModes:
    {{- include "tc.v1.common.lib.pvc.accessModes" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "PVC") | trim | nindent 4 }}
  resources:
    requests:
      storage: {{ $pvcSize }}
  {{- with $objectData.volumeName }}
  volumeName: {{ tpl . $rootCtx }}
  {{- end -}}
  {{- with (include "tc.v1.common.lib.storage.storageClassName" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "PVC") | trim) }}
  storageClassName: {{ . }}
  {{- end -}}
{{- end -}}
