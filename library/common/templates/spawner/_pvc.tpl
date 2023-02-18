{{/* PVC Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.pvc" $ -}}
*/}}

{{- define "tc.v1.common.spawner.pvc" -}}

  {{- range $name, $persistence := .Values.persistence -}}

    {{- if $persistence.enabled -}}

      {{/* Create a copy of the persistence */}}
      {{- $objectData := (mustDeepCopy $persistence) -}}

      {{- $_ := set $objectData "type" ($objectData.type | default $.Values.fallbackDefaults.persistenceType) -}}

      {{/* Perform general validations */}}
      {{- include "tc.v1.common.lib.persistence.validation" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Persistence") -}}

      {{/* Only spawn PVC if it's enabled and type of "pvc" */}}
      {{- if and (eq "pvc" $objectData.type) (not $objectData.existingClaim) -}}

        {{- $objectName := (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $) $name) -}}
        {{/* Perform validations */}}
        {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}

        {{/* Set the name of the secret */}}
        {{- $_ := set $objectData "name" $objectName -}}
        {{- $_ := set $objectData "shortName" $name -}}

        {{/* Call class to create the object */}}
        {{- include "tc.v1.common.class.pvc" (dict "rootCtx" $ "objectData" $objectData) -}}

      {{- end -}}
    {{- end -}}

  {{- end -}}

{{- end -}}
