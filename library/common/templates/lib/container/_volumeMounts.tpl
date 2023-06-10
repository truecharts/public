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

  {{- $codeServerIgnoredTypes := (list "configmap" "secret") -}}
  {{- $keys := (list "persistence") -}}
  {{- if eq $objectData.podType "StatefulSet" -}}
    {{- $keys = mustAppend $keys "volumeClaimTemplates" -}}
  {{- end -}}

  {{- range $key := $keys -}}
    {{- range $persistenceName, $persistenceValues := (get $rootCtx.Values $key) -}}
      {{- if $persistenceValues.enabled -}}
        {{/* Dont try to mount configmap/sercet to codeserver */}}
        {{- if not (and (eq $objectData.shortName "codeserver") (mustHas $persistenceValues.type $codeServerIgnoredTypes)) -}}
          {{- $volMount := (fromJson (include "tc.v1.common.lib.container.volumeMount.isSelected" (dict "persistenceName" $persistenceName "persistenceValues" $persistenceValues "objectData" $objectData "key" $key))) -}}
          {{- if $volMount -}}
            {{- $volMounts = mustAppend $volMounts $volMount -}}
          {{- end -}}
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
      {{- fail (printf "%s - Expected non-empty <mountPath>" (camelcase $volMount.key)) -}}
    {{- end -}}

    {{- if not (hasPrefix "/" $volMount.mountPath) -}}
      {{- fail (printf "%s - Expected <mountPath> to start with a forward slash [/]" (camelcase $volMount.key)) -}}
    {{- end -}}

    {{- $propagationTypes := (list "None" "HostToContainer" "Bidirectional") -}}
    {{- if and $volMount.mountPropagation (not (mustHas $volMount.mountPropagation $propagationTypes)) -}}
      {{- fail (printf "%s - Expected <mountPropagation> to be one of [%s], but got [%s]" (camelcase $volMount.key) (join ", " $propagationTypes) $volMount.mountPropagation) -}}
    {{- end -}}

    {{- if not (kindIs "bool" $volMount.readOnly) -}}
      {{- fail (printf "%s - Expected <readOnly> to be [boolean], but got [%s]" (camelcase $volMount.key) (kindOf $volMount.readOnly)) -}}
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
  {{- $key := .key -}}

  {{/* Initialize from the default values */}}
  {{- $volMount := dict -}}
  {{- $_ := set $volMount "name" $persistenceName -}}
  {{- $_ := set $volMount "key" $key -}}
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
  {{- if and $persistenceValues.targetSelectAll (ne $key "volumeClaimTemplates") -}}
    {{- $return = true -}}
    {{/* Set custom path on autopermissions container */}}
    {{- if and (eq $objectData.shortName "autopermissions") $persistenceValues.autoPermissions -}}
      {{- if or $persistenceValues.autoPermissions.chown $persistenceValues.autoPermissions.chmod -}}
        {{- $return = true -}}
        {{- $_ := set $volMount "mountPath" (printf "/mounts/%v" $persistenceName) -}}
      {{- end -}}
    {{- end -}}

  {{/* If the container is the autopermission */}}
  {{- else if (eq $objectData.shortName "autopermissions") -}}
    {{- if $persistenceValues.autoPermissions -}}
      {{- if or $persistenceValues.autoPermissions.chown $persistenceValues.autoPermissions.chmod -}}
        {{- $return = true -}}
        {{- $_ := set $volMount "mountPath" (printf "/mounts/%v" $persistenceName) -}}
      {{- end -}}
    {{- end -}}

  {{/* Else if selector is defined */}}
  {{- else if $persistenceValues.targetSelector -}}
    {{/* If pod is selected */}}
    {{- if mustHas $objectData.podShortName ($persistenceValues.targetSelector | keys) -}}
      {{- $selectorValues := (get $persistenceValues.targetSelector $objectData.podShortName) -}}
      {{- if not (kindIs "map" $selectorValues) -}}
        {{- fail (printf "%s - Expected <targetSelector.%s> to be a [dict], but got [%s]" (camelcase $key) $objectData.podShortName (kindOf $selectorValues)) -}}
      {{- end -}}

      {{- if not $selectorValues -}}
        {{- fail (printf "%s - Expected non-empty <targetSelector.%s>" (camelcase $key) $objectData.podShortName) -}}
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
