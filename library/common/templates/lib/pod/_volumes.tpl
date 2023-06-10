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
    {{- if $persistenceValues.enabled -}}
      {{- $persistence := (mustDeepCopy $persistenceValues) -}}
      {{- $_ := set $persistence "shortName" $name -}}

      {{- $selected := false -}}

      {{/* If set to true, define volume */}}
      {{- if $persistence.targetSelectAll -}}
        {{- $selected = true -}}

      {{/* If the pod is the autopermission */}}
      {{- else if eq $objectData.shortName "autopermissions" -}}
        {{- if $persistence.autoPermissions -}}
          {{- if or $persistence.autoPermissions.chown $persistence.autoPermissions.chmod -}}
            {{- $selected = true -}}
          {{- end -}}
        {{- end -}}

      {{/* If targetSelector is set, check if pod is selected */}}
      {{- else if $persistence.targetSelector -}}
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
        {{- $type := ($persistence.type | default $rootCtx.Values.fallbackDefaults.persistenceType) -}}

        {{- if eq "pvc" $type -}}
          {{- include "tc.v1.common.lib.pod.volume.pvc" (dict "rootCtx" $rootCtx "objectData" $persistence) | trim | nindent 0 -}}
        {{- else if eq "ixVolume" $type -}}
          {{- include "tc.v1.common.lib.pod.volume.ixVolume" (dict "rootCtx" $rootCtx "objectData" $persistence) | trim | nindent 0 -}}
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
        {{- else if eq "device" $type -}}
          {{- include "tc.v1.common.lib.pod.volume.device" (dict "rootCtx" $rootCtx "objectData" $persistence) | trim | nindent 0 -}}
        {{- end -}}

      {{- end -}}

    {{- end -}}
  {{- end -}}
{{- end -}}
