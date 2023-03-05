{{/* Secret Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.secret" $ -}}
*/}}

{{- define "tc.v1.common.spawner.secret" -}}

  {{- range $name, $secret := .Values.secret -}}

    {{- $enabled := false -}}
    {{- if hasKey $secret "enabled" -}}
      {{- if not (kindIs "invalid" $secret.enabled) -}}
        {{- $enabled = $secret.enabled -}}
      {{- else -}}
        {{- fail (printf "Secret - Expected the defined key [enabled] in <secret.%s> to not be empty" $name) -}}
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

      {{/* Create a copy of the secret */}}
      {{- $objectData := (mustDeepCopy $secret) -}}

      {{- $objectName := (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $) $name) -}}
      {{- if hasKey $objectData "expandObjectName" -}}
        {{- if not $objectData.expandObjectName -}}
          {{- $objectName = $name -}}
        {{- end -}}
      {{- end -}}

      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "tc.v1.common.lib.secret.validation" (dict "objectData" $objectData) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Secret") -}}

      {{/* Set the name of the secret */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.secret" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
