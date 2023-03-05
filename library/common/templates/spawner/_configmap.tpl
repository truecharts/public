{{/* Configmap Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.configmap" $ -}}
*/}}

{{- define "tc.v1.common.spawner.configmap" -}}

  {{- range $name, $configmap := .Values.configmap -}}

    {{- $enabled := false -}}

    {{- if kindIs "bool" $configmap.enabled -}}
      {{- $enabled = $configmap.enabled -}}
    {{- else if eq $configmap.enabled "true" -}}
      {{- $enabled = true -}}
    {{- end -}}

    {{- if $enabled -}}

      {{/* Create a copy of the configmap */}}
      {{- $objectData := (mustDeepCopy $configmap) -}}

      {{- $objectName := (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $) $name) -}}
      {{- if hasKey $objectData "expandObjectName" -}}
        {{- if not $objectData.expandObjectName -}}
          {{- $objectName = $name -}}
        {{- end -}}
      {{- end -}}

      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "tc.v1.common.lib.configmap.validation" (dict "objectData" $objectData) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "ConfigMap") -}}

      {{/* Set the name of the configmap */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.configmap" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
