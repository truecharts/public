{{/* ValidatingWebhookconfiguration Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.validatingWebhookconfiguration" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the validatingWebhookconfiguration.
  labels: The labels of the validatingWebhookconfiguration.
  annotations: The annotations of the validatingWebhookconfiguration.
  data: The data of the validatingWebhookconfiguration.
  namespace: The namespace of the validatingWebhookconfiguration. (Optional)
*/}}

{{- define "tc.v1.common.class.validatingWebhookconfiguration" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}
---
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Webhook") }}
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
webhooks:
  {{- range $webhook := $objectData.webhooks -}}
    {{- include "tc.v1.common.lib.webhook" (dict "webhook" $webhook "rootCtx" $rootCtx) | trim | nindent 4 }}
  {{- end -}}
{{- end -}}
