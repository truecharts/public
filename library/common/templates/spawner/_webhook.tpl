{{/* MutatingWebhookConfiguration Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.webhook" $ -}}
*/}}

{{- define "tc.v1.common.spawner.webhook" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $mutatingWebhookConfiguration := .Values.webhook -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $mutatingWebhookConfiguration
                    "name" $name "caller" "Webhook"
                    "key" "webhook")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the mutatingWebhookConfiguration */}}
      {{- $objectData := (mustDeepCopy $mutatingWebhookConfiguration) -}}

      {{- $objectName := $name -}}

      {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "Webhook"
                "key" "webhook")) -}}

      {{- if eq $expandName "true" -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Webhook") -}}

      {{/* Set the name of the MutatingWebhookConfiguration */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{- include "tc.v1.common.lib.webhook.validation" (dict "rootCtx" $ "objectData" $objectData) -}}

      {{- $type := tpl $objectData.type $ -}}
      {{/* Call class to create the object */}}
      {{- if eq $type "validating" -}}
        {{- include "tc.v1.common.class.validatingWebhookconfiguration" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- else if eq $type "mutating" -}}
        {{- include "tc.v1.common.class.mutatingWebhookConfiguration" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- end -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
