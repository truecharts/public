{{/* Returns Fixed Env */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.fixedEnv" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.fixedEnv" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{/* Avoid nil pointers */}}
  {{- if not (hasKey $objectData "fixedEnv") -}}
    {{- $_ := set $objectData "fixedEnv" dict -}}
  {{- end -}}

  {{- $nvidiaCaps := $rootCtx.Values.containerOptions.NVIDIA_CAPS -}}

  {{- if $objectData.fixedEnv.NVIDIA_CAPS -}}
    {{- $nvidiaCaps = $objectData.fixedEnv.NVIDIA_CAPS -}}
  {{- end -}}

  {{- if not (deepEqual $nvidiaCaps (mustUniq $nvidiaCaps)) -}}
    {{- fail (printf "Container - Expected [fixedEnv.NVIDIA_CAPS] to have only unique values, but got [%s]" (join ", " $nvidiaCaps)) -}}
  {{- end -}}

  {{- $caps := (list "all" "compute" "utility" "graphics" "video") -}}
  {{- range $cap := $nvidiaCaps -}}
    {{- if not (mustHas $cap $caps) -}}
      {{- fail (printf "Container - Expected [fixedEnv.NVIDIA_CAPS] entry to be one of [%s], but got [%s]" (join ", " $caps) $cap) -}}
    {{- end -}}
  {{- end -}}

  {{- $secContext := fromJson (include "tc.v1.common.lib.container.securityContext.calculate" (dict "rootCtx" $rootCtx "objectData" $objectData)) -}}

  {{- $fixed := list -}}
  {{- $TZ := $objectData.fixedEnv.TZ | default $rootCtx.Values.TZ -}}
  {{- $UMASK := $objectData.fixedEnv.UMASK | default $rootCtx.Values.securityContext.container.UMASK -}}
  {{- $PUID := $objectData.fixedEnv.PUID | default $rootCtx.Values.securityContext.container.PUID -}}
  {{- if and (not (kindIs "invalid" $objectData.fixedEnv.PUID)) (eq (int $objectData.fixedEnv.PUID) 0) -}}
    {{- $PUID = $objectData.fixedEnv.PUID -}}
  {{- end -}}
  {{/* calculatedFSGroup is passed from the pod */}}
  {{- $PGID := $objectData.calculatedFSGroup -}}

  {{- $fixed = mustAppend $fixed (dict "k" "TZ" "v" $TZ) -}}
  {{- $fixed = mustAppend $fixed (dict "k" "UMASK" "v" $UMASK) -}}
  {{- $fixed = mustAppend $fixed (dict "k" "UMASK_SET" "v" $UMASK) -}}

  {{- $nvidia := false -}}
  {{- if eq (include "tc.v1.common.lib.container.resources.hasGPU" (dict "rootCtx" $rootCtx "objectData" $objectData "gpuType" "nvidia.com/gpu")) "true" -}}
    {{- $nvidia = true -}}
  {{- end -}}

  {{- if and ($rootCtx.Values.resources) ($rootCtx.Values.resources.limits) -}}
    {{- range $k, $v := $rootCtx.Values.resources.limits -}}
      {{- if and (eq $k "nvidia.com/gpu") (gt ($v | int) 0) -}}
        {{- $nvidia = true -}}
        {{- break -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if and ($objectData.resources) ($objectData.resources.limits) -}}
    {{- range $k, $v := $objectData.resources.limits -}}
      {{- if and (eq $k "nvidia.com/gpu") (gt ($v | int) 0) -}}
        {{- $nvidia = true -}}
        {{- break -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if $nvidia -}}
    {{- $fixed = mustAppend $fixed (dict "k" "NVIDIA_DRIVER_CAPABILITIES" "v" (join "," $nvidiaCaps)) -}}
  {{- else -}}
    {{- $fixed = mustAppend $fixed (dict "k" "NVIDIA_VISIBLE_DEVICES" "v" "void") -}}
  {{- end -}}

  {{/* If running as root and PUID is set (0 or greater), set related envs */}}
  {{- if and (or (eq (int $secContext.runAsUser) 0) (eq (int $secContext.runAsGroup) 0)) (ge (int $PUID) 0) -}}
    {{- $fixed = mustAppend $fixed (dict "k" "PUID" "v" $PUID) -}}
    {{- $fixed = mustAppend $fixed (dict "k" "USER_ID" "v" $PUID) -}}
    {{- $fixed = mustAppend $fixed (dict "k" "UID" "v" $PUID) -}}
    {{- $fixed = mustAppend $fixed (dict "k" "PGID" "v" $PGID) -}}
    {{- $fixed = mustAppend $fixed (dict "k" "GROUP_ID" "v" $PGID) -}}
    {{- $fixed = mustAppend $fixed (dict "k" "GID" "v" $PGID) -}}
  {{- end -}}
  {{/* If rootFS is readOnly OR does not as root, let s6 containers to know that fs is readonly */}}
  {{- if or $secContext.readOnlyRootFilesystem $secContext.runAsNonRoot -}}
    {{- $fixed = mustAppend $fixed (dict "k" "S6_READ_ONLY_ROOT" "v" "1") -}}
  {{- end -}}

  {{- range $env := $fixed -}}
    {{- include "tc.v1.common.helper.container.envDupeCheck" (dict "rootCtx" $rootCtx "objectData" $objectData "source" "fixedEnv" "key" $env.k) }}
- name: {{ $env.k | quote }}
  value: {{ (include "tc.v1.common.helper.makeIntOrNoop" $env.v) | quote }}
  {{- end -}}
{{- end -}}
