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
    {{- fail "Pod - Expected non-empty <.Values.securityContext.pod>" -}}
  {{- end -}}

  {{/* Initialize from the "global" option */}}
  {{- $secContext := mustDeepCopy $rootCtx.Values.securityContext.pod -}}

  {{/* Override with pods option */}}
  {{- with $objectData.podSpec.securityContext -}}
    {{- $secContext = mustMergeOverwrite $secContext . -}}
  {{- end -}}

  {{- $gpuAdded := false -}}
  {{- range $GPUValues := $rootCtx.Values.scaleGPU -}}
    {{/* If there is a selector and pod is selected */}}
    {{- if $GPUValues.targetSelector -}}
      {{- if mustHas $objectData.shortName ($GPUValues.targetSelector | keys) -}}
        {{- $gpuAdded = true -}}
      {{- end -}}
    {{/* If there is not a selector, but pod is primary */}}
    {{- else if $objectData.primary -}}
      {{- $gpuAdded = true -}}
    {{- end -}}
  {{- end -}}

  {{- $deviceGroups := (list 5 10 20 24) -}}
  {{- $deviceAdded := false -}}
  {{- range $persistenceName, $persistenceValues := $rootCtx.Values.persistence -}}
    {{- if $persistenceValues.enabled -}}
      {{- if eq $persistenceValues.type "device" -}}
        {{- if $persistenceValues.targetSelectAll -}}
          {{- $deviceAdded = true -}}
        {{- else if $persistenceValues.targetSelector -}}
          {{- if mustHas $objectData.shortName ($persistenceValues.targetSelector | keys) -}}
            {{- $deviceAdded = true -}}
          {{- end -}}
        {{- else if $objectData.podPrimary -}}
          {{- $deviceAdded = true -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if $gpuAdded -}}
    {{- $_ := set $secContext "supplementalGroups" (concat $secContext.supplementalGroups (list 44 107)) -}}
  {{- end -}}

  {{- if $deviceAdded -}}
    {{- $_ := set $secContext "supplementalGroups" (concat $secContext.supplementalGroups $deviceGroups) -}}
  {{- end -}}

  {{- $_ := set $secContext "supplementalGroups" (concat $secContext.supplementalGroups (list 568)) -}}

  {{- if not (deepEqual $secContext.supplementalGroups (mustUniq $secContext.supplementalGroups)) -}}
    {{- fail (printf "Pod - Expected <supplementalGroups> to have only unique values, but got [%s]" (join ", " $secContext.supplementalGroups)) -}}
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
    {{- fail "Pod - Expected non-empty <fsGroup>" -}}
  {{- end -}}

  {{/* Used by the fixedEnv template */}}
  {{- $_ := set $objectData.podSpec "calculatedFSGroup" $secContext.fsGroup -}}

  {{- if not $secContext.fsGroupChangePolicy -}}
    {{- fail "Pod - Expected non-empty <fsGroupChangePolicy>" -}}
  {{- end -}}

  {{- $policies := (list "Always" "OnRootMismatch") -}}
  {{- if not (mustHas $secContext.fsGroupChangePolicy $policies) -}}
    {{- fail (printf "Pod - Expected <fsGroupChangePolicy> to be one of [%s], but got [%s]" (join ", " $policies) $secContext.fsGroupChangePolicy) -}}
  {{- end }}
fsGroup: {{ $secContext.fsGroup }}
fsGroupChangePolicy: {{ $secContext.fsGroupChangePolicy }}
  {{- with $secContext.supplementalGroups }}
supplementalGroups:
    {{- range . }}
  - {{ . }}
    {{- end -}}
  {{- else }}
supplementalGroups: []
  {{- end -}}
  {{- with $secContext.sysctls }}
sysctls:
    {{- range . }}
    {{- if not .name -}}
      {{- fail "Pod - Expected non-empty <name> in <sysctls>" -}}
    {{- end -}}
    {{- if not .value -}}
      {{- fail "Pod - Expected non-empty <value> in <sysctls>" -}}
    {{- end }}
  - name: {{ tpl .name $rootCtx | quote }}
    value: {{ tpl .value $rootCtx | quote }}
    {{- end -}}
  {{- else }}
sysctls: []
  {{- end -}}
{{- end -}}
