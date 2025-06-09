{{/* Returns Volumes */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.volumes" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.volumes" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $selectedVolumes := (include "tc.v1.common.lib.pod.volumes.selected" (dict "rootCtx" $rootCtx "objectData" $objectData)) | fromJson -}}

  {{- range $type, $volumes := $selectedVolumes -}}
    {{- range $volume := $volumes -}}
      {{- include (printf "tc.v1.common.lib.pod.volume.%s" $type) (dict "rootCtx" $rootCtx "objectData" $volume) | trim | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.volumes.checkRWO" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $persistence := .persistence -}}
  {{- $type := .type -}}
  {{- $name := .name -}}

  {{/* Only check accessModes if persistence is one of those types */}}
  {{- $typesWithAccessMode := (list "pvc") -}}
  {{- if (mustHas $type $typesWithAccessMode) -}}
    {{- $modes := include "tc.v1.common.lib.pvc.accessModes" (dict "rootCtx" $rootCtx
        "objectData" $persistence "caller" "Volumes") | fromYamlArray
    -}}

    {{- $hasRWO := include "tc.v1.common.lib.pod.volumes.hasRWO" (dict "modes" $modes) -}}

    {{- if eq $hasRWO "true" -}}
      {{- if eq $objectData.type "DaemonSet" -}}
        {{- fail "Expected [accessMode] to not be [ReadWriteOnce] when used on a [DaemonSet]" -}}

      {{- else if and (mustHas $objectData.type (list "Deployment" "StatefulSet")) (gt (($objectData.replicas| default 1) | int) 1) -}}
        {{- include "add.warning" (dict "rootCtx" $rootCtx
            "warn" (printf "WARNING: The [accessModes] on volume [%s] is set to [ReadWriteOnce] when on a [Deployment] with more than 1 replica" $name))
        -}}
      {{- end -}}
    {{- end -}}

  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.volumes.hasRWO" -}}
  {{- $modes := .modes -}}
  {{- $hasRWO := false -}}
  {{- range $m := $modes -}}
    {{- if eq $m "ReadWriteOnce" -}}
      {{- $hasRWO = true -}}
      {{- break -}}
    {{- end -}}
  {{- end -}}
  {{- $hasRWO -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.volumes.selected" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $selectedVolumes := dict
    "pvc" list
    "secret" list
    "configmap" list
    "emptyDir" list
    "hostPath" list
    "nfs" list
    "iscsi" list
    "projected" list
    "device" list
  -}}

  {{- range $name, $persistenceValues := $rootCtx.Values.persistence -}}
    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
      "rootCtx" $rootCtx "objectData" $persistenceValues
      "name" $name "caller" "Volumes"
      "key" "persistence"))
    -}}

    {{- if (ne $enabled "true") -}}{{- continue -}}{{- end -}}
    {{- $persistence := (mustDeepCopy $persistenceValues) -}}
    {{- $_ := set $persistence "shortName" $name -}}

    {{- $selected := false -}}

    {{- if $persistence.targetSelectAll -}}
      {{- $selected = true -}}
    {{- else if eq $objectData.shortName "autopermissions" -}}
      {{- if and $persistence.autoPermissions $persistence.autoPermissions.enabled -}}
        {{- $selected = true -}}
      {{- end -}}
    {{- else if $persistence.targetSelector -}}
      {{- if not (kindIs "map" $persistence.targetSelector) -}}
        {{- fail (printf "Persistence - Expected [targetSelector] to be [dict], but got [%s]" (kindOf $persistence.targetSelector)) -}}
      {{- end -}}

      {{- if (mustHas $objectData.shortName (keys $persistence.targetSelector)) -}}
        {{- $selected = true -}}
      {{- end -}}
    {{- else if $objectData.primary -}}
      {{- $selected = true -}}
    {{- end -}}

    {{- if not $selected -}}{{- continue -}}{{- end -}}

    {{- $type := ($persistence.type | default $rootCtx.Values.global.fallbackDefaults.persistenceType) -}}
    {{- if eq $type "vct" -}}{{- continue -}}{{- end -}}

    {{- include "tc.v1.common.lib.pod.volumes.checkRWO" (dict
      "rootCtx" $rootCtx "objectData" $objectData "persistence" $persistence "type" $type "name" $name)
    -}}

    {{- $_ := set $selectedVolumes $type (mustAppend (index $selectedVolumes $type) $persistence) -}}
  {{- end -}}

  {{- $selectedVolumes | toJson -}}
{{- end -}}
