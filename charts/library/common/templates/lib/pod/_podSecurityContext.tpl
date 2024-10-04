{{/* Returns Pod Security Context */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.securityContext" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.securityContext" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if not $rootCtx.Values.securityContext.pod -}}
    {{- fail "Pod - Expected non-empty [securityContext.pod]" -}}
  {{- end -}}

  {{/* Initialize from the "global" option */}}
  {{- $secContext := mustDeepCopy $rootCtx.Values.securityContext.pod -}}

  {{/* Override with pods option */}}
  {{- with $objectData.podSpec.securityContext -}}
    {{- $secContext = mustMergeOverwrite $secContext . -}}
  {{- end -}}

  {{- $gpu := (include "tc.v1.common.lib.pod.resources.hasGPU" (dict "rootCtx" $rootCtx "objectData" $objectData)) -}}

  {{- $deviceGroups := (list 5 10 20 24) -}}
  {{- $deviceAdded := false -}}
  {{- $hostUsers := false -}}
  {{- $hostUserPersistence := (list "configmap" "secret" "emptyDir" "downwardAPI" "projected") -}}
  {{- $podSelected := false -}}

  {{- range $persistenceName, $persistenceValues := $rootCtx.Values.persistence -}}
    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                  "rootCtx" $rootCtx "objectData" $persistenceValues
                  "name" $persistenceName "caller" "Pod Security Context"
                  "key" "persistence")) -}}
    {{- if (eq $enabled "true") -}}
      {{- if $persistenceValues.targetSelectAll -}}
        {{- $podSelected = true -}}
      {{- else if and $persistenceValues.targetSelector (kindIs "map" $persistenceValues.targetSelector) -}}
        {{- if mustHas $objectData.shortName ($persistenceValues.targetSelector | keys) -}}
          {{- $podSelected = true -}}
        {{- end -}}
      {{- else if $objectData.podPrimary -}}
        {{- $podSelected = true -}}
      {{- end -}}
    {{- end -}}

    {{- if $podSelected -}}
      {{- if eq $persistenceValues.type "device" -}}
        {{- $deviceAdded = true -}}
      {{- end -}}

      {{- if not (mustHas $persistenceValues.type $hostUserPersistence) -}}
        {{- $hostUsers = true -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{/* Make sure no host "things" are used */}}
  {{- $hostNet := (eq (include "tc.v1.common.lib.pod.hostNetwork" (dict "rootCtx" $rootCtx "objectData" $objectData)) "true") -}}
  {{- $hostPID := (eq (include "tc.v1.common.lib.pod.hostPID" (dict "rootCtx" $rootCtx "objectData" $objectData)) "true") -}}
  {{- $hostIPC := (eq (include "tc.v1.common.lib.pod.hostIPC" (dict "rootCtx" $rootCtx "objectData" $objectData)) "true") -}}
  {{- if or $hostIPC $hostNet $hostPID -}}
    {{- $hostUsers = true -}}
  {{- end }}

  {{- range $containerName, $containerValues := $objectData.podSpec.containers -}}
    {{- $secContContainer := fromJson (include "tc.v1.common.lib.container.securityContext.calculate" (dict "rootCtx" $rootCtx "objectData" $containerValues)) }}
    {{- if or $secContContainer.allowPrivilegeEscalation $secContContainer.privileged $secContContainer.capabilities.add
        (not $secContContainer.readOnlyRootFilesystem) (not $secContContainer.runAsNonRoot)
        (lt ($secContContainer.runAsUser | int) 1) (lt ($secContContainer.runAsGroup | int) 1) -}}
      {{- $hostUsers = true -}}
    {{- end -}}
  {{- end -}}

  {{- if eq $gpu "true" -}}
    {{- $_ := set $secContext "supplementalGroups" (concat $secContext.supplementalGroups (list 44 107)) -}}
    {{- $hostUsers = true -}}
  {{- end -}}

  {{- if $deviceAdded -}}
    {{- $_ := set $secContext "supplementalGroups" (concat $secContext.supplementalGroups $deviceGroups) -}}
    {{- $hostUsers = true -}}
  {{- end -}}

  {{- $_ := set $secContext "supplementalGroups" (concat $secContext.supplementalGroups (list 568)) -}}

  {{- if not (deepEqual $secContext.supplementalGroups (mustUniq $secContext.supplementalGroups)) -}}
    {{- fail (printf "Pod - Expected [supplementalGroups] to have only unique values, but got [%s]" (join ", " $secContext.supplementalGroups)) -}}
  {{- end -}}

  {{- $portRange := fromJson (include "tc.v1.common.lib.helpers.securityContext.getPortRange" (dict "rootCtx" $rootCtx "objectData" $objectData)) -}}
  {{/* If a container wants to bind a port <= 1024 change the unprivileged_port_start */}}
  {{- if and $portRange.low (le (int $portRange.low) 1024) -}}
    {{/* That sysctl is not supported when hostNet is enabled */}}
    {{- if ne (include "tc.v1.common.lib.pod.hostNetwork" (dict "rootCtx" $rootCtx "objectData" $objectData)) "true" -}}
      {{- $_ := set $secContext "sysctls" (mustAppend $secContext.sysctls (dict "name" "net.ipv4.ip_unprivileged_port_start" "value" (printf "%v" $portRange.low))) -}}
    {{- end -}}
  {{- end -}}

  {{- if or (kindIs "invalid" $secContext.fsGroup) (eq (toString $secContext.fsGroup) "") -}}
    {{- fail "Pod - Expected non-empty [fsGroup]" -}}
  {{- end -}}

  {{/* Used by the fixedEnv template */}}
  {{- $_ := set $objectData.podSpec "calculatedFSGroup" $secContext.fsGroup -}}

  {{- if not $secContext.fsGroupChangePolicy -}}
    {{- fail "Pod - Expected non-empty [fsGroupChangePolicy]" -}}
  {{- end -}}

  {{- $policies := (list "Always" "OnRootMismatch") -}}
  {{- if not (mustHas $secContext.fsGroupChangePolicy $policies) -}}
    {{- fail (printf "Pod - Expected [fsGroupChangePolicy] to be one of [%s], but got [%s]" (join ", " $policies) $secContext.fsGroupChangePolicy) -}}
  {{- end }}
fsGroup: {{ include "tc.v1.common.helper.makeIntOrNoop" $secContext.fsGroup }}
fsGroupChangePolicy: {{ $secContext.fsGroupChangePolicy }}
  {{- with $secContext.supplementalGroups }}
supplementalGroups:
    {{- range . }}
  - {{ include "tc.v1.common.helper.makeIntOrNoop" . }}
    {{- end -}}
  {{- else }}
supplementalGroups: []
  {{- end -}}
  {{- with $secContext.sysctls }}
sysctls:
    {{- $hostUsers = true -}}
    {{- range . }}
    {{- if not .name -}}
      {{- fail "Pod - Expected non-empty [name] in [sysctls]" -}}
    {{- end -}}
    {{- if not .value -}}
      {{- fail "Pod - Expected non-empty [value] in [sysctls]" -}}
    {{- end }}
  - name: {{ tpl .name $rootCtx | quote }}
    value: {{ tpl .value $rootCtx | quote }}
    {{- end -}}
  {{- else }}
sysctls: []
  {{- end -}}

  {{/* Used by _hostUsers.tpl */}}
  {{- $_ := set $objectData.podSpec "calculatedHostUsers" $hostUsers -}}
{{- end -}}
