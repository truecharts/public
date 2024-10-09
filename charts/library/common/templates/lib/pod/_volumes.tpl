{{/* Returns Volumes */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.volumes" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.volumes" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

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

        {{- include "tc.v1.common.lib.pod.volumes.checkRWO" (dict
            "rootCtx" $rootCtx "objectData" $objectData "persistence" $persistence
            "type" $type "name" $name)
        -}}

        {{- if eq "pvc" $type -}}
          {{- include "tc.v1.common.lib.pod.volume.pvc" (dict "rootCtx" $rootCtx "objectData" $persistence) | trim | nindent 0 -}}
        {{- else if eq "hostPath" $type -}}
          {{- include "tc.v1.common.lib.pod.volume.hostPath" (dict "rootCtx" $rootCtx "objectData" $persistence) | trim | nindent 0 -}}
        {{- else if eq "secret" $type -}}
          {{- include "tc.v1.common.lib.pod.volume.secret" (dict "rootCtx" $rootCtx "objectData" $persistence) | trim | nindent 0 -}}
        {{- else if eq "configmap" $type -}}
          {{- include "tc.v1.common.lib.pod.volume.configmap" (dict "rootCtx" $rootCtx "objectData" $persistence) | trim | nindent 0 -}}
        {{- else if eq "emptyDir" $type -}}
          {{- include "tc.v1.common.lib.pod.volume.emptyDir" (dict "rootCtx" $rootCtx "objectData" $persistence) | trim | nindent 0 -}}
        {{- else if eq "nfs" $type -}}
          {{- include "tc.v1.common.lib.pod.volume.nfs" (dict "rootCtx" $rootCtx "objectData" $persistence) | trim | nindent 0 -}}
        {{- else if eq "iscsi" $type -}}
          {{- include "tc.v1.common.lib.pod.volume.iscsi" (dict "rootCtx" $rootCtx "objectData" $persistence) | trim | nindent 0 -}}
        {{- else if eq "projected" $type -}}
          {{- include "tc.v1.common.lib.pod.volume.projected" (dict "rootCtx" $rootCtx "objectData" $persistence) | trim | nindent 0 -}}
        {{- else if eq "device" $type -}}
          {{- include "tc.v1.common.lib.pod.volume.device" (dict "rootCtx" $rootCtx "objectData" $persistence) | trim | nindent 0 -}}
        {{- end -}}

      {{- end -}}

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

    {{- $hasRWO := false -}}
    {{- range $m := $modes -}}
      {{- if eq $m "ReadWriteOnce" -}}
        {{- $hasRWO = true -}}
        {{- break -}}
      {{- end -}}
    {{- end -}}

    {{- if $hasRWO -}}
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
