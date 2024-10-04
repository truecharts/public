{{/* volumesnapshotclass Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.volumesnapshotclass" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the volumesnapshotclass.
  labels: The labels of the volumesnapshotclass.
  annotations: The annotations of the volumesnapshotclass.
*/}}

{{- define "tc.v1.common.class.volumesnapshotclass" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $isDefault := false -}}
  {{- if (kindIs "bool" $objectData.isDefault) -}}
    {{- $isDefault = $objectData.isDefault  -}}
  {{- end }}
---
apiVersion: snapshot.storage.k8s.io/v1
kind: VolumeSnapshotClass
metadata:
  name: {{ $objectData.name }}
  {{- $labels := (mustMerge ($objectData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($objectData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) }}
  annotations:
    snapshot.storage.kubernetes.io/is-default-class: {{ $isDefault | quote }}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
driver: {{ tpl $objectData.driver $rootCtx }}
deletionPolicy: {{ $objectData.deletionPolicy | default "Retain" }}
  {{- with $objectData.parameters }}
parameters:
    {{- range $k, $v := . }}
  {{ tpl $k $rootCtx }}: {{ (tpl ($v | toString) $rootCtx) | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}
