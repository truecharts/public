{{/* Network Attachment Definition Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.networkAttachmentDefinition" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the Network Attachment Definition.
  labels: The labels of the Network Attachment Definition.
  annotations: The annotations of the Network Attachment Definition.
  config: The config of the interface
*/}}

{{- define "tc.v1.common.class.networkAttachmentDefinition" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}
---
apiVersion: k8s.cni.cncf.io/v1
kind: NetworkAttachmentDefinition
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Network Attachment Definition") }}
  {{- $labels := (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml) | default dict -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml) | default dict -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  config: {{ $objectData.config | squote }}
{{- end -}}
