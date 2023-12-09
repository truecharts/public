{{/* RBAC Spawner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.rbac" $ -}}
*/}}

{{- define "tc.v1.common.spawner.rbac" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{/* Primary validation for enabled rbacs. */}}
  {{- include "tc.v1.common.lib.rbac.primaryValidation" $ -}}

  {{- range $name, $rbac := .Values.rbac -}}
    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $rbac
                    "name" $name "caller" "RBAC"
                    "key" "rbac")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the configmap */}}
      {{- $objectData := (mustDeepCopy $rbac) -}}

      {{- $objectName := $fullname -}}
      {{- if not $objectData.primary -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "RBAC") -}}

      {{/* Set the name of the rbac */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* If clusteWide key does not exist, assume false */}}
      {{- if not (hasKey $objectData "clusterWide") -}}
        {{- $_ := set $objectData "clusterWide" false -}}
      {{- end -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.rbac" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
