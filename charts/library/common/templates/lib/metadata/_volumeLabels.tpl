{{/* Labels that are added to podSpec */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.metadata.volumeLabels" $ }}
*/}}
{{- define "tc.v1.common.lib.metadata.volumeLabels" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $pvcNames := "" -}}

  {{- range $name, $persistenceValues := $rootCtx.Values.persistence -}}
    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                  "rootCtx" $rootCtx "objectData" $persistenceValues
                  "name" $name "caller" "Volumes"
                  "key" "persistence")) -}}
    {{- if (eq $enabled "true") -}}
      {{- $persistence := (mustDeepCopy $persistenceValues) -}}
      {{- $_ := set $persistence "shortName" $name -}}

      {{- $selected := false -}}

      {{/* If set to true, define volume */}}
      {{- if $persistence.targetSelectAll -}}
        {{- $selected = true -}}

      {{/* If the pod is the autopermission */}}
      {{- else if eq $objectData.shortName "autopermissions" -}}
        {{- if $persistence.autoPermissions -}}
          {{- if $persistence.autoPermissions.enabled -}}
            {{- $selected = true -}}
          {{- end -}}
        {{- end -}}

      {{/* If targetSelector is set, check if pod is selected */}}
      {{- else if $persistence.targetSelector -}}
        {{- if not (kindIs "map" $persistence.targetSelector) -}}
          {{- fail (printf "Persistence - Expected [targetSelector] to be [dict], but got [%s]" (kindOf $persistence.targetSelector)) -}}
        {{- end -}}

        {{- if (mustHas $objectData.shortName (keys $persistence.targetSelector)) -}}
          {{- $selected = true -}}
        {{- end -}}

      {{/* If no targetSelector is set or targetSelectAll, check if pod is primary */}}
      {{- else if $objectData.primary -}}
        {{- $selected = true -}}
      {{- end -}}

      {{/* If pod selected */}}
      {{- if $selected -}}
        {{/* Define the volume based on type */}}
        {{- $type := ($persistence.type | default $rootCtx.Values.global.fallbackDefaults.persistenceType) -}}

        {{- if eq "pvc" $type }}
           {{- if $pvcNames -}}
             {{ $pvcNames = ( printf "%s+%s" $pvcNames $name ) }}
           {{- else -}}
             {{ $pvcNames = $name }}
           {{- end -}}
        {{ end -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}
"truecharts.org/pvc": {{ $pvcNames }}
{{- end -}}
