{{/* Returns volumeMount list */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.volumeMount" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.volumeMount" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $volMounts := list -}}

  {{- $codeServerIgnoredTypes := (list "configmap" "secret" "vct") -}}

  {{- range $persistenceName, $persistenceValues := $rootCtx.Values.persistence -}}
    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                  "rootCtx" $rootCtx "objectData" $persistenceValues
                  "name" $persistenceName "caller" "Volume Mount"
                  "key" "persistence")) -}}

    {{/* TLDR: Enabled + Not VCT without STS */}}
    {{- if and (eq $enabled "true") (not (and (eq $persistenceValues.type "vct") (ne $objectData.podType "StatefulSet"))) -}}
      {{/* Dont try to mount configmap/sercet/vct to codeserver */}}
      {{- if not (and (eq $objectData.shortName "codeserver") (mustHas $persistenceValues.type $codeServerIgnoredTypes)) -}}
        {{- $volMount := (include "tc.v1.common.lib.container.volumeMount.isSelected" (dict
          "rootCtx" $rootCtx "persistenceName" $persistenceName "persistenceValues" $persistenceValues "objectData" $objectData
        )) | fromJson -}}
        {{- if $volMount -}}
          {{- $volMounts = mustAppend $volMounts $volMount -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- range $volMount := $volMounts -}}
    {{/* Expand values */}}
    {{- $_ := set $volMount "mountPath" (tpl $volMount.mountPath $rootCtx) -}}
    {{- $_ := set $volMount "subPath" (tpl $volMount.subPath $rootCtx) -}}
    {{- $_ := set $volMount "mountPropagation" (tpl $volMount.mountPropagation $rootCtx) -}}

    {{- if not $volMount.mountPath -}}
      {{- fail (printf "Persistence - Expected non-empty [mountPath]") -}}
    {{- end -}}

    {{- if not (hasPrefix "/" $volMount.mountPath) -}}
      {{- fail (printf "Persistence - Expected [mountPath] to start with a forward slash [/]") -}}
    {{- end -}}

    {{- $propagationTypes := (list "None" "HostToContainer" "Bidirectional") -}}
    {{- if and $volMount.mountPropagation (not (mustHas $volMount.mountPropagation $propagationTypes)) -}}
      {{- fail (printf "Persistence - Expected [mountPropagation] to be one of [%s], but got [%s]" (join ", " $propagationTypes) $volMount.mountPropagation) -}}
    {{- end -}}

    {{- if not (kindIs "bool" $volMount.readOnly) -}}
      {{- fail (printf "Persistence - Expected [readOnly] to be [boolean], but got [%s]" (kindOf $volMount.readOnly)) -}}
    {{- end }}
- name: {{ $volMount.name }}
  mountPath: {{ $volMount.mountPath }}
  readOnly: {{ $volMount.readOnly }}
      {{- with $volMount.subPath }}
  subPath: {{ . }}
      {{- end -}}
      {{- with $volMount.mountPropagation }}
  mountPropagation: {{ . }}
      {{- end -}}
  {{- end -}}

{{- end -}}

{{- define "tc.v1.common.lib.container.volumeMount.isSelected" -}}
  {{- $persistenceName := .persistenceName -}}
  {{- $persistenceValues := .persistenceValues -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{/* Initialize from the default values */}}
  {{- $volMount := dict -}}
  {{- if eq $persistenceValues.type "vct" -}}
    {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}
    {{- $persistenceName = printf "%s-%s" $fullname $persistenceName -}}
  {{- end -}}
  {{- $_ := set $volMount "name" $persistenceName -}}
  {{- if eq $persistenceValues.type "device" -}} {{/* On devices use the hostPath as default if mountpath is not defined */}}
    {{- $_ := set $volMount "mountPath" ($persistenceValues.mountPath | default $persistenceValues.hostPath | default "") -}}
  {{- else -}}
    {{- $_ := set $volMount "mountPath" ($persistenceValues.mountPath | default "") -}}
  {{- end -}}
  {{- $_ := set $volMount "subPath" ($persistenceValues.subPath | default "") -}}
  {{- $_ := set $volMount "readOnly" ($persistenceValues.readOnly | default false) -}}
  {{- $_ := set $volMount "mountPropagation" ($persistenceValues.mountPropagation | default "") -}}

  {{- $return := false -}}
  {{/* If targetSelectAll is set, means all pods/containers */}} {{/* targetSelectAll does not make sense for vct */}}
  {{- if and $persistenceValues.targetSelectAll (ne $persistenceValues.type "vct") -}}
    {{- $return = true -}}
    {{/* Set custom path on autopermissions container */}}
    {{- if and (eq $objectData.shortName "autopermissions") $persistenceValues.autoPermissions -}}
      {{- if $persistenceValues.autoPermissions.enabled -}}
        {{- $return = true -}}
        {{- $_ := set $volMount "mountPath" (printf "/mounts/%v" $persistenceName) -}}
      {{- end -}}
    {{- end -}}

  {{/* If the container is the autopermission */}}
  {{- else if (eq $objectData.shortName "autopermissions") -}}
    {{- if $persistenceValues.autoPermissions -}}
      {{- if $persistenceValues.autoPermissions.enabled -}}
        {{- $return = true -}}
        {{- $_ := set $volMount "mountPath" (printf "/mounts/%v" $persistenceName) -}}
      {{- end -}}
    {{- end -}}

  {{/* Else if selector is defined */}}
  {{- else if $persistenceValues.targetSelector -}}
    {{- if not (kindIs "map" $persistenceValues.targetSelector) -}}
      {{- fail (printf "Persistence - Expected [targetSelector] to be a [dict] but got [%s]" (kindOf $persistenceValues.targetSelector)) -}}
    {{- end -}}

    {{/* If pod is selected */}}
    {{- if mustHas $objectData.podShortName ($persistenceValues.targetSelector | keys) -}}
      {{- $selectorValues := (get $persistenceValues.targetSelector $objectData.podShortName) -}}
      {{- if not (kindIs "map" $selectorValues) -}}
        {{- fail (printf "Persistence - Expected [targetSelector.%s] to be a [dict], but got [%s]" $objectData.podShortName (kindOf $selectorValues)) -}}
      {{- end -}}

      {{- if not $selectorValues -}}
        {{- fail (printf "Persistence - Expected non-empty [targetSelector.%s]" $objectData.podShortName) -}}
      {{- end -}}

      {{/* If container is selected */}}
      {{- if or (mustHas $objectData.shortName ($selectorValues | keys)) (eq $objectData.shortName "codeserver") -}}
        {{/* Merge with values that might be set for the specific container */}}
        {{- $fetchedSelectorValues := (get $selectorValues $objectData.shortName) -}}
        {{- if and (eq $objectData.shortName "codeserver") (not $fetchedSelectorValues) -}}
          {{- $fetchedSelectorValues = (get $selectorValues ($selectorValues | keys | first)) -}}
        {{- end -}}
        {{- $volMount = mustMergeOverwrite $volMount $fetchedSelectorValues -}}
        {{- $return = true -}}
      {{- end -}}
    {{- end -}}

  {{/* if its the codeserver */}}
  {{- else if (eq $objectData.shortName "codeserver") -}}
    {{- $return = true -}}

  {{/* Else if not selector, but pod and container is primary */}}
  {{- else if and $objectData.podPrimary $objectData.primary -}}
    {{- $return = true -}}
  {{- end -}}

  {{- if $return -}} {{/* If it's selected, return the volumeMount */}}
    {{- $volMount | toJson -}}
  {{- else -}} {{/* Else return an empty dict */}}
    {{- dict | toJson -}}
  {{- end -}}
{{- end -}}
