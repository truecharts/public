{{/* MutatingWebhookConfiguration Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.webhook" $ -}}
*/}}

{{- define "tc.v1.common.spawner.webhook" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $mutatingWebhookConfiguration := .Values.webhook -}}

    {{- $enabled := false -}}
    {{- if hasKey $mutatingWebhookConfiguration "enabled" -}}
      {{- if not (kindIs "invalid" $mutatingWebhookConfiguration.enabled) -}}
        {{- $enabled = $mutatingWebhookConfiguration.enabled -}}
      {{- else -}}
        {{- fail (printf "Webhook - Expected the defined key [enabled] in <webhook.%s> to not be empty" $name) -}}
      {{- end -}}
    {{- end -}}

    {{- if kindIs "string" $enabled -}}
      {{- $enabled = tpl $enabled $ -}}

      {{/* After tpl it becomes a string, not a bool */}}
      {{-  if eq $enabled "true" -}}
        {{- $enabled = true -}}
      {{- else if eq $enabled "false" -}}
        {{- $enabled = false -}}
      {{- end -}}
    {{- end -}}

    {{- if $enabled -}}

      {{/* Create a copy of the mutatingWebhookConfiguration */}}
      {{- $objectData := (mustDeepCopy $mutatingWebhookConfiguration) -}}

      {{- $objectName := (printf "%s-%s" $fullname $name) -}}
      {{- if hasKey $objectData "expandObjectName" -}}
        {{- if not $objectData.expandObjectName -}}
          {{- $objectName = $name -}}
        {{- end -}}
      {{- end -}}

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
