{{/* Service Spawner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.service" $ -}}
*/}}

{{- define "tc.v1.common.spawner.service" -}}

  {{/* Primary validation for enabled service. */}}
  {{- include "tc.v1.common.lib.service.primaryValidation" $ -}}

  {{- range $name, $service := .Values.service -}}

    {{- if $service.enabled -}}

      {{/* Create a copy of the configmap */}}
      {{- $objectData := (mustDeepCopy $service) -}}

      {{- $objectName := include "tc.v1.common.lib.chart.names.fullname" $ -}}
      {{- if not $objectData.primary -}}
        {{- $objectName = (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $) $name) -}}
        {{- if hasKey $objectData "expandObjectName" -}}
          {{- if not $objectData.expandObjectName -}}
            {{- $objectName = $name -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}

      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Service") -}}
      {{- include "tc.v1.common.lib.service.validation" (dict "rootCtx" $ "objectData" $objectData) -}}

      {{/* Set the name of the service account */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.service" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
